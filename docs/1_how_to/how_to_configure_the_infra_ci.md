# How to configure the infra CI

Go on Gitlab CI and add the following env vars :

```bash
SCW_DEFAULT_ORGANIZATION_ID="f2ba6e47-8832-4bfb-ba95-8f99641e0c3d"
SCW_DEFAULT_PROJECT_ID="f284cfd3-4466-4b1f-bf16-36dedc7f7123"
SCW_ACCESS_KEY="XXXXXXXXXXXXXXXXX"
SCW_SECRET_KEY="XXXXXXXXXXXXXXXXX"
SCW_DEFAULT_REGION="fr-par"
SCW_DEFAULT_ZONE="fr-par-1"
AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXX" # Same value as SCW_ACCESS_KEY
AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXX" # Same value as SCW_SECRET_KEY
AWS_DEFAULT_REGION="fr-par"
```

