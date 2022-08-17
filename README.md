# Keylime Cloud Environments
Setup instructions and scripts for running [Keylime](https://github.com/keylime/keylime) in cloud environments. \
The set up for each cloud environment is located in a seperate directory. For use, follow the instructions found in their respective README. 

## Keylime on Google Cloud
Ansible role to deploy a Fedora 35 instance on the Google Cloud Platform with [Keylime](https://github.com/keylime/keylime) and the [rust agent](https://github.com/keylime/rust-keylime) against a Virtualized TPM.

See the [README](https://github.com/keylime/keylime-cloud-environments/tree/main/keylime-ansible-gcp) for further information on set up and usage. 

## Keylime on AWS
Ansible role to deploy a Fedora 35 instance on AWS with [Keylime](https://github.com/keylime/keylime) and the [rust agent](https://github.com/keylime/rust-keylime) against a Virtualized TPM.
This role is currently in developement. 

See the [README](https://github.com/keylime/keylime-cloud-environments/tree/main/keylime-ansible-aws) for further information.

## Keylime on Azure
The ansible collection for Azure does not yet have the functionality to create a VM with 'Trusted Launch' (enable the vTPM). Manual set up instructions can be found in the [README]((https://github.com/keylime/keylime-cloud-environments/tree/main/keylime-azure) until making an ansible role is possible. 
 
See the [README](https://github.com/keylime/keylime-cloud-environments/tree/main/keylime-ansible-aws) for further information. 

## Keylime on Azure
The ansible collection for Azure does not yet have the functionality to create a VM with 'Trusted Launch' (enable the vTPM). Manual set up instructions can be found in the [README]((https://github.com/keylime/keylime-cloud-environments/tree/main/keylime-azure) until making an ansible role is possible.
