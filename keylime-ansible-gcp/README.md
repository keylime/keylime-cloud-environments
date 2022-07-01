# Ansible Keylime for Google Cloud
Ansible role to deploy a Fedora 35 instance on the Google Cloud Platform with a Virtualized TPM.

Contributions are welcome, should anyone wish to have this role provision other Linux distributions.

For details on using Keylime, please consult the
[project documentation](https://keylime-docs.readthedocs.io/en/latest/).

For details on the Rust agent, please consult the [repository](https://github.com/keylime/rust-keylime).

## Configuration
1. [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). \
Note: must use Ansible 2.9+
2. Install dependecies for the Ansible-GCP module \
`$ pip3 install requests google-auth`
3. [Create GCP project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
4. Enable Compute Engine for this project. \
To do so, select the naivgation menu (the three bars to the left of the GCP logo), hover over "APIs & Services", click "Dashboard", select "+ ENABLE APIS AND SERVICES", search for "Compute Engine API", select and enable. 
5. [Create a GCP service account](https://developers.google.com/identity/protocols/oauth2/service-account#creatinganaccount) for ansible's use. 
6. [Create and download keys linked to this service account](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts&zippy=%2Cservice-accounts). Note: download the keys in JSON format.
7. Create ssh key pair \
` ssh-keygen -t rsa -f ~/.ssh/gcp_ansible_key` 
8. Add the ssh public key to the Metadata section of Compute Engine in Google Cloud Platform. (Compute Engine>Settings>Metadata>SSH) \
`#  cat ~/.ssh/gcp_ansible_key.pub`
9. Add path to ssh private key to ansible config 
   1. Create file in the current directory called `ansible.cfg` 
   2. Indicate the path to your GCP SSH private key in this file. Example:
```
[defaults] 
private_key_file = /home/.ssh/gcp_ansible_key
```
10. Run the script to set up the environment. 
```
./set_env_var.sh --help
Warning: this script parses the GCP service account credential file for the email and project ID.
Usage: ./set_env_var.sh <path to JSON cred file> <GCP region> <GCP zone>
```
## Usage
Run the playbook to create an instance with vTPM. 

```bash
ansible-playbook create_gcp_instance.yml
```
## Keylime Installation 
To deploy keylime on this new VM against the vTPM, use this [ansible-keylime role](https://github.com/keylime/ansible-keylime)
