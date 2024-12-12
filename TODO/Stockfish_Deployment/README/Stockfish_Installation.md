**Fixe les permissions du fichier .pem**
```bash
chmod 400 ~/.ssh/azure_stockfish.pem
```

**Accède à la VM via SSH**
```bash
ssh -i ~/.ssh/azure_stockfish.pem azureuser@<IP_ADDRESS>
```

**Téléchargez le binaire de Stockfish**
Lien des téléchargements : https://stockfishchess.org/download/linux/
```bash
wget https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-ubuntu-x86-64-avx2.tar
```

**Extraction du fichier TAR**
```bash
tar -xvf stockfish-ubuntu-x86-64-avx2.tar
```

**Vérification du contenu extrait**
```bash
ls -l
```

**Déplacez le binaire vers /usr/local/bin/**
```bash
sudo mv stockfish/stockfish-ubuntu-x86-64-avx2 /usr/local/bin/stockfish
```

**Rendez le binaire exécutable**
```bash
sudo chmod +x /usr/local/bin/stockfish
```

**Vérifiez l'installation**
```bash
stockfish
```

**Envoyer les commandes UCI**
```bash
uci
ucinewgame
go movetime 2000
```
