# Ansible Keylime for AWS
Ansible role to deploy the [Rust-Keylime](https://github.com/keylime/rust-keylime) agent with the [Keylime](https://github.com/keylime/keylime) registrar and verifier against a Virtualized TPM.

For details on using Keylime, please consult the
[project documentation](https://keylime-docs.readthedocs.io/en/latest/)

For details on the Rust agent, please consult the [repository](https://github.com/keylime/rust-keylime).

## Developement
**This role is not ready for use.** The ansible AWS module currently does not have the functionality to create an AMI with UEFI and TPM enabled. 
A [issue](https://github.com/ansible-collections/amazon.aws/issues/944) has been opened regarding this.

The playbook can be used to configure snapshots to create an AMI with UEFI and TPM support. Currently, the playbook creates a Fedora instance,
partions the disks, creates the EFI system partition, mounts this system partition to /boot/efi, reinstalls the bootloader, creates keys,
self-signs binaries, and then takes snapshots of both volumes. From here, these snapshots can be used to create an AMI that support UEFI and TPM.

### Next steps
Once the ansible/aws ec2 ami module has the ability to support uefi/tpm, the next steps for this playbook are:
1. Export binary blob to localhost to create AMI as uefi-data
2. Use the snapshots to create an AMI with UEFI + TPM
3. Add a task that creates an instance with this AMI
4. Create a role to install keylime on the new instance

### Potential blockers 
1. Automating the EC2 serial console to boot via the UEFI shell (required for boot)

## Configuration 
1. Install pip 
`$ dnf install python3-pip python3-wheel`
2. Install ansible and dependencies 
`$ pip3 install ansible boto3 botocore `
`$ pip3 install ansible --upgrade`
3. Install amazon.aws module for ansible 
`$ ansible-galaxy collection install amazon.aws `
4. Create and record access key ID and secret key from AWS account. See [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey).
Note: this process while download a .csv file. For the ansible playbook to run, you must have the AWS access key ID and the AWS secret key numbers displayed when creating the key. Make note of them, as they will be used to authenicate the playbook). 
5. Run script to configure environment for ansible. 
```
./set_env_var.sh 
```
## Usage 
Run the playbook to create and set up an instance.

```bash
ansible-playbook playbook.yml
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
