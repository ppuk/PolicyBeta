# Ansible setup

These ansible scripts are the base scripts used to provision the deployment targets for the app. Note that the machines will need creating and their IPs adding to the hosts file before running.

### Domain names

Currently, two envs are created: staging and production. the domain names are staging.app_name.com and app_name.com respectively.

### IP addresses

IP addresses for the servers need adding to the ```ansible/hosts``` file. One IP per env should be created by default.


### SSL certs

Both the crt and key files for the app should be added to:
```
ansible/roles/ssl/files/null/ssl/certs/server.crt
ansible/roles/ssl/files/null/ssl/keys/server.key
```

### ENV vars
Secret env vars (those that should ot be added to scm) are located in:
```
ansible/secret
```

## Usage
```
ansible-playbook -i ansible/hosts ansible/production.yml
```
