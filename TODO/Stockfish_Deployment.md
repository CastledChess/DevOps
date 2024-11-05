Pour réaliser ce projet en respectant ton budget et en optimisant l'usage de tes crédits Azure, voici les étapes et recommandations pour configurer, automatiser et exécuter Stockfish sur le cloud en lien avec ton application front/back sur Vercel :

### 1. Choix de l’infrastructure cloud pour Stockfish

#### Sur Azure (avec tes crédits gratuits)
1. **Type de machine** : Opte pour une machine virtuelle **B2ms** (ou similaire) avec 8 Go de RAM et 2 vCPU (ce qui peut suffire pour Stockfish). Les VMs de la série B sont des machines économiques sur Azure, conçues pour les charges de travail comme les moteurs d’échecs, où les ressources peuvent être temporairement boostées. Si tu as absolument besoin de 8 vCPU, tu pourrais regarder du côté des séries D (D4s_v3 par exemple) mais cela pourrait rapidement épuiser tes crédits.
2. **Optimisation des coûts** :
   - Les machines ne seront créées que les **jeudis et vendredis, de 9h30 à 17h30** pour ne pas dépasser ton budget. Tu peux faire cela via un **script Terraform** ou un **cron en CI/CD**, qui :
      - Lance la machine au début de la période (9h30).
      - Arrête ou supprime la machine en fin de période (17h30).
   - La solution la plus simple serait un **script de cron dans GitHub Actions ou Azure DevOps** pour automatiser la création et la suppression de cette VM. Je te donnerai plus de détails ci-dessous.

#### Alternatives (hors Azure)
- **Google Cloud** et **AWS** : offrent des crédits étudiants similaires. Google Cloud a des machines similaires (f1-micro, e2-micro) qui peuvent être gratuites en permanence (via l’offre Free Tier) mais limités en ressources. AWS propose aussi t2.micro gratuitement, mais avec 1 vCPU et 1 Go de RAM, cela ne suffira pas pour Stockfish en intensif.

En résumé, utilise Azure avec une machine B2ms ou D4s_v3 pour l’instant, et ajuste les spécifications selon la consommation de tes crédits.

### 2. Automatisation des ressources avec Terraform et CI/CD

Pour l’automatisation, utilise **Terraform** pour la configuration de l’infrastructure et **GitHub Actions** pour orchestrer le déploiement :

1. **Terraform Script** :
   - Un fichier Terraform `.tf` configure ta VM Azure avec les ressources nécessaires (B2ms ou D4s_v3).
   - Ajoute une règle de sécurité réseau pour autoriser le trafic SSH (port 22) et HTTP/HTTPS (ports 80/443) ou tout autre port dont tu as besoin pour exposer Stockfish (par exemple le 5000 pour du TCP).

2. **GitHub Actions pour exécuter Terraform** :
   - Utilise GitHub Actions pour déclencher les déploiements chaque jeudi et vendredi à 9h30 et les destructions à 17h30.
   - Exemple de configuration de workflow pour déclencher Terraform tous les jeudis et vendredis :

```yaml
name: Deploy-Stockfish
on:
  schedule:
    - cron: '30 9 * * 4,5'  # Crée la VM tous les jeudis et vendredis à 9h30
    - cron: '30 17 * * 4,5' # Supprime la VM tous les jeudis et vendredis à 17h30

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Apply or Destroy
        run: |
          if [[ "$(date +%H)" == "09" ]]; then
            terraform apply -auto-approve
          else
            terraform destroy -auto-approve
          fi
```

Cette configuration gère le déploiement à 9h30 et la destruction à 17h30 les jours concernés.

### 3. Automatisation du front/back avec Vercel et CI/CD

Pour Vercel, tu peux configurer des déploiements continus :

1. **Connexion de ton dépôt GitHub à Vercel** : Lorsque tu connectes ton dépôt, Vercel propose le déploiement automatique à chaque push sur la branche par défaut. Pour les projets étudiants, Vercel offre une option gratuite qui convient bien.
2. **Pipeline CI/CD** : En utilisant GitHub Actions, tu peux déclencher des builds conditionnellement (par exemple uniquement sur `main` ou à certains moments) afin d’optimiser l’utilisation de Vercel.

### 4. Communication avec Stockfish (moteur CLI) sur le cloud

Pour faire interagir ton backend avec Stockfish sur la machine virtuelle, voici comment procéder :

1. **Exposition de l’IP** : Une fois la VM déployée, note son IP publique (ou utilise un nom de domaine dynamique si l’IP change). Configure les ports nécessaires dans le réseau Azure pour autoriser les requêtes.
2. **Connexion via des commandes CLI** :
   - Depuis ton backend, tu peux exécuter des commandes CLI via SSH (utilise une bibliothèque comme `paramiko` en Python pour envoyer des commandes).
   - Installe `Stockfish` sur la VM et expose un service (par exemple un serveur minimal en Python ou Node.js) pour écouter les requêtes et renvoyer les meilleurs coups.

#### Exemple de script Python pour envoyer des commandes à Stockfish via SSH :
```python
import paramiko

def get_best_move(fen):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect('IP_DE_TA_VM', username='azureuser', key_filename='~/.ssh/id_rsa')

    stdin, stdout, stderr = ssh.exec_command(f'stockfish')
    stdin.write(f'position fen {fen}\n')
    stdin.write('go\n')
    stdin.flush()

    best_move = stdout.readlines()
    ssh.close()
    return best_move
```

### Résumé des étapes

1. **Infrastructure** : Utilise Azure avec une VM de type B2ms ou D4s_v3 pour Stockfish.
2. **Automatisation** : Déploie et supprime la VM avec GitHub Actions et Terraform pour les horaires spécifiés.
3. **Déploiement de front/back sur Vercel** : Automatisation via GitHub Actions.
4. **Connexion backend - Stockfish** : Communication avec la VM via SSH ou un service REST pour envoyer des commandes et récupérer les meilleurs coups.

Cette configuration devrait te permettre d’exécuter ton projet de manière économique en utilisant tes crédits, tout en ayant une infrastructure fonctionnelle pour Stockfish.
