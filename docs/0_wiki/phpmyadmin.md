# Connect to Mysql instance with PhpMyAdmin

## 1) Forward ArgoCD private port localy
```bash
just phpmyadmin-forward
```

## 2) Get database creds
```bash
# In another terminal, get the credentials
just secenv-context prod kollectif-devsecops-production
```

Now you can login on http://localhost:5555 with the creds on you Mysql Instance
