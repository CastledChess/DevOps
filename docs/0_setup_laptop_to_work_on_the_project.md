# Setup your laptop to work on the project

Install the following on your laptop :
- [asdf](https://asdf-vm.com/guide/getting-started.html) : Used to install libs with good version (like npm but for os libs)
- [direnv](https://direnv.net/docs/installation.html) : Used to inject env vars and credentials in the current shell

Then install all devops required libs by running :

```sh
# install the plugins
cat .tool-versions | cut -d ' ' -f 1 | xargs -I@ asdf plugin add @
# then the actual tools
asdf install
```

And activate pre-commit
```
pre-commit install
```
