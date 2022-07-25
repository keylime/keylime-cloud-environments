# Ansible Keylime for Google Cloud
Ansible role to deploy a Fedora 35 instance on the Google Cloud Platform with [Keylime](https://github.com/keylime/keylime) and the [rust agent](https://github.com/keylime/rust-keylime) against a Virtualized TPM.

Contributions are welcome, should anyone wish to have this role provision other Linux distributions.

For details on using Keylime, please consult the
[project documentation](https://keylime-docs.readthedocs.io/en/latest/).

For details on the Rust agent, please consult the [repository](https://github.com/keylime/rust-keylime).

## Configuration
1. Install Pip \
`$ dnf install python3-pip python3-wheel`
2.  Install dependecies for the Ansible - GCP module \
`$ pip3 install requests google-auth ansible` \
`$ pip3 install ansible --upgrade`
3. [Create GCP project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
4. Enable Compute Engine for this project. \
To do so, select the naivgation menu (the three bars to the left of the GCP logo), hover over "APIs & Services", click "Dashboard", select "+ ENABLE APIS AND SERVICES", search for "Compute Engine API", select and enable. 
4. [Create a GCP service account](https://developers.google.com/identity/protocols/oauth2/service-account#creatinganaccount) for ansible's use. 
5. [Create and download keys linked to this service account](https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts&zippy=%2Cservice-accounts). Note: download the keys in JSON format.
6. Create ssh key pair \
` ssh-keygen -t rsa -f ~/.ssh/gcp_ansible_key` 
7. Add the ssh public key to the Metadata section of Compute Engine in Google Cloud Platform. (Compute Engine>Settings>Metadata>SSH) 
`#  cat ~/.ssh/gcp_ansible_key.pub`
8. Add path to ssh private key to ansible config (`/etc/ansible/ansible.cfg`) \
Example:
```
[defaults] 
private_key_file = /home/.ssh/gcp_ansible_key
```
9.Run the script to set up the environment. 
```
./set_env_var.sh --help
Warning: this script parses the GCP service account credential file for the email and project ID.
Usage: ./set_env_var.sh <path to JSON cred file> <GCP region> <GCP zone>
```
## Usage
Run the playbook to create and set up an instance. 

If you wish to create your own allow and exclude lists, run the playbook with the command with the flag `-e "custom_config=true"` and read the keylime documentation on [allowlists](https://keylime-docs.readthedocs.io/en/latest/user_guide/runtime_ima.html?highlight=allowlist#keylime-ima-allowlists) and [excludes list](https://keylime-docs.readthedocs.io/en/latest/user_guide/runtime_ima.html?highlight=excludes%20list%20#excludes-list).

```bash
ansible-playbook playbook.yml -e "custom_config=True"
```

Otherwise, run the playbook with the flag ` -e "custom_config=False"`. This will generate an allowlist and include a default excludes list. 
```bash
ansible-playbook playbook.yml -e "custom_config=False"
```

## Getting started with Keylime 
The best way to get started is to read the [Keylime
Documentation](https://keylime-docs.readthedocs.io/en/latest/), however if you're keen to get started right away, follow these steps.

To start the Keylime verifier and registrar, you will need to start the following services. 

`# keylime_verifier`

`# keylime_registrar`

To start the Keylime rust agent, navigate to the rust-keylime directory and run the following command.

`# RUST_LOG=keylime_agent=trace cargo run --bin keylime_agent`

To register the agent, run the tenant. \
`# keylime_tenant -v 127.0.0.1 -t 127.0.0.1 -u d432fbb3-d2f1-4a97-9ef7-75bd81c00000 -f /root/excludes.txt --allowlist /root/allowlist.txt --exclude /root/excludes.txt -c add`

You can now set up a use case, a good first scenario to try out would be [IMA
Integrity Monitoring](https://keylime-docs.readthedocs.io/en/latest/user_guide/runtime_ima.html)

For more detailed set up scenarios, see the [Keylime
documentation](https://keylime-docs.readthedocs.io/en/latest/user_guide/runtime_ima.html)
