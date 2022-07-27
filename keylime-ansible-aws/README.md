# Ansible Keylime for AWS
Ansible role to deploy the [Rust-Keylime](https://github.com/keylime/rust-keylime) agent with the [Keylime](https://github.com/keylime/keylime) registrar and verifier against a Virtualized TPM.

For details on using Keylime, please consult the
[project documentation](https://keylime-docs.readthedocs.io/en/latest/)

For details on the Rust agent, please consult the [repository](https://github.com/keylime/rust-keylime).

## Developement
This role is not ready for use. The ansible AWS module currently does not have the functionality to create an AMI with UEFI and TPM enabled. 
A [issue](https://github.com/ansible-collections/amazon.aws/issues/944) has been opened regarding this.

The playbook can be used to configure snapshots to create an AMI with UEFI and TPM support. Currently, the playbook creates a Fedora instance,
partions the disks, creates the EFI system partition, mounts this system partition to /boot/efi, reinstalls the bootloader, creates keys,
self-signs binaries, and then takes snapshots of both volumes. From here, these snapshots can be used to create an AMI that support UEFI and TPM. 
