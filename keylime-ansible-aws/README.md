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
1. Use the snapshots to create an AMI with UEFI + TPM
2. Add a task that creates an instance with this AMI
3. Create a role to install keylime on the new instance

### Potential blockers 
1. Automating the EC2 serial console to boot via the UEFI shell (required for boot)

## Configuration 
1. Install dependencies \
`$ pip3 install boto3 botocore ` 
2. Install amazon.aws module for ansible \
`$ ansible-galaxy collection install amazon.aws `
3. Create and record the access key ID and secret key for your AWS account
   1. Navigate to the 'IAM' section of the AWS console
   2. On the IAM dashboard, select 'Users'
   3. Select your user
   4. Select 'Security credentials'
   5. Click 'Create access key'
   6. Record your Access key ID and secret key for authenticating the playbook
4. The playbook will generate a SSH key pair named 'aws', add this path to an ansible configuration file in the current directory (`ansible.cfg`)
```
[defaults]
private_key_file=~/.ssh/aws.pem

```

5. Run script to configure environment for ansible. 
```
./set_env_var.sh --help
"Usage: ./set_env_var.sh <AWS access key ID> <AWS secret key> <AWS region>" 
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
