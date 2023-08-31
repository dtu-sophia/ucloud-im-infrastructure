# Deployment guide

The [Ansible automation platform](https://www.ansible.com/) provides for easily readable deployment scripts grouped in *playbooks* for each target system which then call a number of *roles* each themed around specific software and/or configuration.

A *reverse proxy* with public IP provides external access to the different services on the internal network. The local authentication of UCloud users is managed by the *identity and access management* service, upon successful authentication the user is forwarded to the Deic Integration Portal resource provider service. Here, the Integration Module extension scripts, among other things, ensure the user is created in the *identity provider* (IdP). The [sssd](https://sssd.io/)-based IdP client must be deployed on all systems on which the user should operate; including the resource provider machine (from which compute jobs are submitted) and the HPC cluster systems executing Deic Integration Portal compute jobs.

```bash
├── ansible.cfg
├── inventory
│   └── inventory.yml
├── playbooks
│   ├── iam
│   │   ├── deploy_iam.yml
│   │   ├── prerequisites.yml
│   │   └── vars.yml
│   ├── idp
│   │   └── deploy_389ds.yml
│   ├── integration-module
│   │   ├── clone_extensions.yml
│   │   ├── deploy_im.yml
│   │   ├── files
│   │   │   ├── config-dev
│   │   │   │   ├── core.yaml
│   │   │   │   ├── keycloak.pem
│   │   │   │   ├── plugins.yaml
│   │   │   │   ├── products.yaml
│   │   │   │   ├── server.yaml
│   │   │   │   └── ucloud_crt.pem
│   │   │   ├── config-prod
│   │   │   │   ├── core.yaml
│   │   │   │   ├── keycloak.pem
│   │   │   │   ├── plugins.yaml
│   │   │   │   ├── products.yaml
│   │   │   │   ├── server.yaml
│   │   │   │   └── ucloud_crt.pem
│   │   │   └── ucloud.service
│   │   ├── prerequisites.yml
│   │   └── vars.yml
│   ├── proxy
│   │   ├── deploy_proxy.yml
│   │   ├── prerequisites.yml
│   │   └── vars.yml
├── README.md
└── roles
    ├── chrony-client
    │   ├── defaults
    │   ├── handlers
    │   ├── meta
    │   ├── README.md
    │   ├── tasks
    │   │   ├── configure.yml
    │   │   ├── debian.yml
    │   │   ├── main.yml
    │   │   └── redhat.yml
    │   ├── templates
    │   │   └── chrony.conf.j2
    │   └── vars
    │       ├── Debian.yml
    │       ├── main.yml
    │       └── RedHat.yml
    ├── configure-389ds-server
    │   ├── handlers
    │   ├── tasks
    │   │   ├── create_authgroup.yml
    │   │   ├── create_instance.yml
    │   │   ├── enable_ldaps.yml
    │   │   ├── enable_plugins.yml
    │   │   ├── firewall_ports.yml
    │   │   ├── install_server.yml
    │   │   ├── main.yml
    │   └── templates
    │       ├── deic-instance.inf.j2
    │       └── dsrc.j2
    ├── configure-389ds-sssd-client
    │   ├── defaults
    │   ├── files
    │   │   └── sssd.conf.j2
    │   └── tasks
    ├── create-admin
    │   ├── tasks
    │   └── vars
    ├── envoy
    │   ├── defaults
    │   └── tasks
    ├── graalvm
    │   ├── defaults
    │   └── tasks
    ├── harden-server
    │   ├── handlers
    │   └── tasks
    ├── keycloak
    │   ├── root
    │   │   ├── defaults
    │   │   └── tasks
    │   │       ├── firewall.yml
    │   │       ├── main.yml
    │   │       ├── podman.yml
    │   │       ├── selinux.yml
    │   │       └── user.yml
    │   └── rootless
    │       ├── custom-theme
    │       │   ├── email
    │       │   └── login
    │       ├── defaults
    │       ├── files
    │       │   ├── a-configure-hostname.j2
    │       │   ├── b-configure-caches.cli
    │       │   ├── c-configure-proxy.cli
    │       │   ├── d-configure-session-affinity.cli
    │       │   ├── deic-dev-realm.json.j2
    │       │   ├── deic-realm.json.j2
    │       │   └── emailtheme.properties.j2
    │       └── tasks
    │           ├── certs.yml
    │           ├── db.yml
    │           ├── iam.yml
    │           ├── main.yml
    │           ├── network.yml
    │           └── systemd.yml
    ├── proxy
    │   ├── root
    │   │   ├── defaults
    │   │   └── tasks
    │   │       ├── firewall.yml
    │   │       ├── main.yml
    │   │       ├── podman.yml
    │   │       └── user.yml
    │   └── rootless
    │       ├── defaults
    │       ├── files
    │       │   └── proxy.conf.j2
    │       └── tasks
    │           ├── certs.yml
    │           ├── main.yml
    │           ├── proxy.yml
    │           └── systemd.yml
    ├── slurm-client
    │   ├── defaults
    │   ├── files
    │   │   ├── munge.key
    │   ├── tasks
    │   │   └── main.yml
    │   └── templates
    │       └── slurm.conf.j2
    ├── storage
    │   ├── defaults
    │   └── tasks
    └── update2latest
        └── tasks
```

The internal hostnames and IPs are defined inside the inventory file.  
Ansible tasks are gathered in generic Roles (ie chrony-client, proxy, storage) and Deployment Playbooks (ie deploy_proxy, deploy_iam).  
  
Some of the services defined in the generic roles are deployed as rootless containers. This ensures process isolation, portability, container breakout vulnerabilities. To make this more explicit generic Roles are split into root and rootless roles. 
  
A sample command to deploy a playbook from top level directory

```
 ansible-playbook {{PLAYBOOK_FILE}}
```

The generic roles has default variables, e.g. create-admin role has default variables for admin username and public ssh key. To override the defaults the following example can be used in the playbooks

```

  roles:
    - name: create-admin   
      vars:
        admins:
          - username: admin-one
            sshkey: PUBKEY_CONTENT
          - username: admin-two
            sshkey: PUBKEY_CONTENT

```


## Reverse proxy

***OS: Rocky Linux 9***

A proxy server is used in many production environments as a single point of access to ensure traffic management, authentication, load balancing, security controls etc.
The proxy facilitates access between UCloud portal as external client and IAM Backend Service and Integration-Module Backend Service (see above tree) within DTU Internal Network. The Integration-Module runs in both DEV and PROD in separate VMs.  

The proxy generic roles deploy a sample instance of [Unprivileged Nginx](https://github.com/nginxinc/docker-nginx-unprivileged).  
The specific configuration is defined in the playbook vars.yml file . This file contains nginx configuration for 3 backend services:  

* Prod  
↳  This is the production integration-module environment. It contains the upstream block with information about internal VM DNS/IP and port. It also contains configuration related to hop-by-hop headers for [Websocket Proxying](https://nginx.org/en/docs/http/websocket.html) that are needed for service-provider communication. It also contains upstream rules by path. The max_body_size and buffer_size are adapted to client-server payload size and can be increased for up to 34 MB to fasten file uploads. Any nginx configuration can be appended using the vars.yml file.
    
* Dev  
↳ This environment is used for development purposes. The upstream block defines both Integration-Module-Dev and UCloud-Dev connection details. This configuration will proxy request UCloud-Dev → IM-Dev 

* IAM  
↳ The upstream_block defines the connection details for the IAM environment. The upstream_rules defines http headers and allowed paths as detailed in [Keycloak Docs](https://www.keycloak.org/server/reverseproxy) . Only the following endpoints are available through the public proxy: 
    * auth/js
    * auth/realms
    * auth/resources
    * auth/robots  
Important: The admin rest endpoint auth/admin is **NOT** included in this configuration

The following command can be used for deployment

```
   ansible-playbook playbooks/proxy/deploy_proxy.yml 
```

The generic role used by this playbook deploys self-signed generic TLS certificates. In order to replace the certificates with publicly trusted certificates the admin must log into the proxy VM and stop the container, replace the certificate files in /home/proxyuser/proxy/certs

```
[proxyuser@proxyhost ~]$ systemctl stop container-proxy --user

#replace certs in with publicly trusted certs
[proxyadmin@proxyhost ~]$ sudo ls -la /home/proxyuser/proxy/certs
drwxr-x---. 2    165636    165636 4096 Aug 29 14:26 .
drwxr-x---. 4 proxyuser proxyuser 4096 Jul 24 13:57 ..
-rw-r--r--. 1    165636    165636 5238 Jul 27 15:00 auth.rc.dtu.dk.crt
-rw-------. 1    165636    165636  241 Jul 27 15:01 auth.rc.dtu.dk.key
-rw-r--r--. 1    165636    165636 5254 Aug 29 14:26 ucloud-dev.rc.dtu.dk.crt
-rw-------. 1    165636    165636  241 Aug 29 14:26 ucloud-dev.rc.dtu.dk.key
-rw-r--r--. 1    165636    165636 5242 Jul 27 15:00 ucloud.rc.dtu.dk.crt
-rw-------. 1    165636    165636  241 Jul 27 15:00 ucloud.rc.dtu.dk.key

[proxyuser@proxyhost ~]$ systemctl start container-proxy --user
```

NB: Containers are running in userspace and mounted folders are owned by dynamic users from a range defined in /etc/subuid


## Identity and access management

***OS: Rocky Linux 9***

This service manages identity and access for users on the DTU Sophia provider. Keycloak is an open sourced Identity and Access Management Tool focused on security with capabilities for single sign-on, federation, two-factor authentication, LDAP integration, multitenancy. The generic role for keycloak is deploying a rootless podman and is following best practices.

Important variables in the playbook are:

* frontend_ep  
↳ The frontend URL is used to infer the URL used by users and applications to access Keycloak, where the main goal is to logically group all instances of Keycloak in a cluster under a single domain and issuer using a public domain name.
* admin_ep  
↳ By setting the adminUrl property, any URL used by the Admin Console will be based on the value you provided. That said, links and static resources used to render the console will only be accessible using the URL you defined.

The generic role will deploy also a custom-theme using the default theming framework [Freemarker](https://freemarker.apache.org/). Currently for security reasons only the Login theme and Email theme were overriden. The generic role contains also json files for Deic realm and Dev realm. 

For manually creating the clients refer to README.md

A sample command to run the IAM Playbook from the top level path.

```
   ansible-playbook playbooks/iam/deploy_iam.yml 
```

Once the playbook is deployed, we will have 3 realms available from the admin endpoint

* master realm
* deic realm
* deic-dev realm

There is no user defined except the master realm admin, so you need to create admins on the other 2 realms using the instructions in the README.

The ansible role deploys also the client "im-ucloud" that defines the backend Integration-Module environment.  

The ansible role deploys also two realm groups

* im-ucloud 
* realm-admin

Users allowed to authenticate with Integration Module should be part of "im-ucloud" group.
Users allowed to administer the realm must be part of "realm-admin" group and have access to internal DTU network.



## Identity provider

***OS: Rocky Linux 9***

The DTU Sophia UCloud-IM configuration uses a 389 Directory Server](https://www.port389.org) instance, the Ansible playbook and roles for which are provided for completeness. 

To deploy run
```
ansible-playbook playbooks/idp/deploy_389ds.yml
```


## Deic Integration Portal resource provider

The [UCloud Integration Module (UCloud-IM)](https://github.com/SDU-eScience/UCloud/tree/master/provider-integration) facilitates access to the compute- and storage resources that the Deic Integration Portal resource provider organisation makes available. In the DTU Sophia configuration this service is installed on a VM. It needs to:

* be able to create users on the [identity provider](#identity-provider) associated with the compute resource,
* act as a compute resource login node in order to submit compute jobs on behalf of Deic Integration Portal users, and
* have shared storage mount with the compute resource where user- and project directories resides.

Upon successfull [authentication](#identification-and-access-management) the UCloud-IM executes operations issued via the [Deic Integration Portal](cloud.sdu.dk) via integration module extension scripts.


## Deployment

***OS: Rocky Linux 8.6***

The DTU Sophia compute resource was deployed with [OpenHPC](https://github.com/openhpc/ohpc/wiki/2.X) using Warewulf+Slurm, hence UCloud-IM is also deployed on Rocky Linux 8.

```
ansible-playbook playbooks/integration-module/deploy_im.yml
``` 

The following steps are necessary for deployment

1. Keycloak prerequisites
1. Config files
1. Integration Module Extensions
1. Playbook variables files


### 1. Keycloak prerequisites

Keycloak must be already deployed according to the playbooks. Realm "Deic" corresponds to the integration module production environment and realm "Deic-dev" corresponds to integration module development environment. Refer to README for admin login instructions. Take note of these fields as they will be required in the next section.

* Regenerate UCloud-IM client secret. This secret is used for Integration-Module -> Keycloak communication

![Client Secret](./img/client_secret.png)

* Copy realm public key for RS256. This key is used to verify the signature of tokens issued by this realm.

![Realm PubKey](./img/realm_public_key.png)

* Copy the Keycloak Public HTTPS key

```
[kcuser@keycloak ~]$ cat keycloak/certs/tls.crt 
-----BEGIN CERTIFICATE-----
MIICCjCCAZCgAwIBAgIUBVZP30MwePknEaIDmjuWiCza1nowCgYIKoZIzj0EAwIw
PDERMA8GA1UEAwwIS2V5Y2xvYWsxDDAKBgNVBAoMA0RUVTEMMAoGA1UECwwDQUlU
MQswCQYDVQQGEwJESzAeFw0yMzA4MjkwOTI5NTVaFw0yNDA4MjMwOTI5NTVaMDwx
ETAPBgNVBAMMCEtleWNsb2FrMQwwCgYDVQQKDANEVFUxDDAKBgNVBAsMA0FJVDEL
WyQZNPu/mOxellqJ/ou1HuRxsDD4rP1d/v61Yvda54zQ5A4vdFbSpZYn6OWBf5/V
GDgXDclj0A/pnW8KDa6buXlL6rcObMl9aFan2IHeJ/L++TujUzBRMB0GA1UdDgQW
BBSsX4P92OY8+qNQE98Td2QyFUeEnjAfBgNVHSMEGDAWgBSsX4P92OY8+qNQE98T
d2QyFUeEnjAPBgNVHRMBAf8EBTADAQH/MAoGCCqGSM49BAMCA2gAMGUCMQCE35hv
XepLCmE3BnmIdwg3DLxXvFmop6Ro9qx5ql2riro7AOe3ffKjgvwh/WYxdOsCMBzn
vJz0iZd9En8Ss9kiQWABZqJa4SZXzHzHR9GVvBceGYeyqpdqk5hwIUSeyOv1Fw==
-----END CERTIFICATE-----
```

### 2. Configuration Files

UCloud-IM is configured via a set of files currently residing in config-prod and config-dev depending on the deployed environment

* core.yaml - defines main endpoint and local directories 
* server.yaml - defines networking configuration
* products.yaml - defines provider products
* plugins.yaml - defines main plugins used by current deployment (OIDC, project, slurm etc)
* keycloak.pem - keycloak https public key
* ucloud_crt.pem - certificate used to verify UCloud signature (usually provided by ucloud admin)


Copy Client Secret and Realm Public Key from previous section to plugins.yaml 

#### **`plugins.yaml`**
```
...
    # Client information used in the OIDC protocol.
    client:
        id: im-ucloud
        secret: PASTE_CLIENT_SECRET_FROM_KEYCLOAK
...
    signing: 
     algorithm: RS256
     key: PASTE_REALM_CERTIFICATE_FROM_KEYCLOAK
     issuer: https://auth.rc.dtu.dk/auth/realms/deic
...
```

Copy content of Keycloak HTTPS Public key to keycloak.pem file, an example file below

NB: By default the UCloud-IM expects configuration files in /etc/ucloud. Any other custom directory must be defined in /etc/ucloud/configdir.txt as done in the current playbook and as such this directory must be world readable. The current deployment uploads all UCloud-IM configuration and source files to /home/ucloud.  


#### **`keycloak.pem`**
``` 
-----BEGIN CERTIFICATE-----
MIICCjCCAZCgAwIBAgIUBVZP30MwePknEaIDmjuWiCza1nowCgYIKoZIzj0EAwIw
PDERMA8GA1UEAwwIS2V5Y2xvYWsxDDAKBgNVBAoMA0RUVTEMMAoGA1UECwwDQUlU
MQswCQYDVQQGEwJESzAeFw0yMzA4MjkwOTI5NTVaFw0yNDA4MjMwOTI5NTVaMDwx
ETAPBgNVBAMMCEtleWNsb2FrMQwwCgYDVQQKDANEVFUxDDAKBgNVBAsMA0FJVDEL
WyQZNPu/mOxellqJ/ou1HuRxsDD4rP1d/v61Yvda54zQ5A4vdFbSpZYn6OWBf5/V
GDgXDclj0A/pnW8KDa6buXlL6rcObMl9aFan2IHeJ/L++TujUzBRMB0GA1UdDgQW
BBSsX4P92OY8+qNQE98Td2QyFUeEnjAfBgNVHSMEGDAWgBSsX4P92OY8+qNQE98T
d2QyFUeEnjAPBgNVHRMBAf8EBTADAQH/MAoGCCqGSM49BAMCA2gAMGUCMQCE35hv
XepLCmE3BnmIdwg3DLxXvFmop6Ro9qx5ql2riro7AOe3ffKjgvwh/WYxdOsCMBzn
vJz0iZd9En8Ss9kiQWABZqJa4SZXzHzHR9GVvBceGYeyqpdqk5hwIUSeyOv1Fw==
-----END CERTIFICATE-----
```

### 3. Integration Module extension scripts

UCloud-IM Extensions are scripts tailored for provider specific environments and implement provider idp, storage and controller commands.
These scripts are triggered whenever an particular event occurs. This event can be an user authentication event or a new project event etc.

An example of such scripts can be found at [SDU eScience IM-Extensions ](https://github.com/SDU-eScience/im-extensions.git).

Each provider tailors these scripts to his own environment requirements and specifics and as such clones these scripts from a private repository as can be seen in playbook/integration-module/clone_extensions.yml  For inspiration on developing UCloud-IM extension scripts for your provider resource, please refer to [SDU eScience IM-Extensions](https://github.com/SDU-eScience/im-extensions.git) for a starting point or reach out to [ait-hpc-support@dtu.dk](mailto:ait-hpc-support@dtu.dk).

### 4. Playbook variables

#### Variables file

The variables file is located at playbooks/integration-module/vars.yml
The following variables must be updated beforehand

* env: ("prod"|"dev")  
↳ defines environment to be deployed.   
  
* im_ext_repo: ("https://user:token@private-git/repo")    
↳ The private git repository containing IM-Extensions scripts  
  
* im_ext_branch: ("branchname")    
↳ IM-Extensions branch  
  
* ucloud_tag: ("v2023.2.8")    
↳ Release tag. This can be found at [UCloud Releases](https://github.com/SDU-eScience/UCloud/releases)   



#### Playbook specific variables

The deploy_im.yml and prerequisites.yml `hosts` variable must updated. 

In prerequsites.yml you can define the directory structure for storing users, projects, software according to the convention.



## Starting UCloud Integration Module

The service can be started from the ucloud user $HOME directory symlink:

```
[ucloud@integration-module-host ~]$ ls -la
total 36
drwxrwxr-x. 11 ucloud ucloud  278 Aug 30 18:14  .
drwxr-xr-x.  8 root   root     84 Aug 30 15:15  ..
-rw-r--r--.  1 ucloud ucloud  528 Aug 30 15:55  .bashrc
drwxrwxr-x.  3 ucloud ucloud   21 Aug 30 15:50  .config
drwxrwxr-x.  5 ucloud ucloud  161 Aug 30 15:20  config-prod
drwxr-xr-x. 10 ucloud ucloud  250 Aug 30 15:22  graalvm
drwxrwxr-x.  5 ucloud ucloud  200 Aug 30 15:20  im-extensions
lrwxrwxrwx.  1 ucloud ucloud  112 Aug 30 15:19  ucloud -> /home/ucloud/UCloud/provider-integration/integration-module/build/native/nativeCompile/ucloud-integration-module
drwxr-xr-x. 14 ucloud ucloud 4096 Aug 30 15:19  UCloud
```

Alternatively, the `ucloud` user can start the service via the supplied systemd unit file. 
```
systemctl start ucloud.service --user
```

## Post-deployment

After succesfully deploying the playbooks you can check whether the UCloud-IM is listening on the following default ports

* 8889 - envoy port
* 42000 - rpc server port


Advise following details to SDU UCloud team:

* Provider proxy public DNS
* IAM public DNS


For help debugging the deployment configuration contact [UCloud Team](mailto:support@escience.sdu.dk).
