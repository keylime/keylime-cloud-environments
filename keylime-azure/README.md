# Keylime for Azure
These instructions decribe the steps to deploy a VM with vTPM on Azure. 

For details on using Keylime, please consult the
[project documentation](https://keylime-docs.readthedocs.io/en/latest/).

For details on the Rust agent, please consult the [repository](https://github.com/keylime/rust-keylime).

## Manual Set Up 
### Instance with vTPM
1. Create a RHEL 8.5 x86_64 instances with Security Type: ”Trusted Launch", this will enable the vTPM 
2. The root volume defaults to 2GB no matter the size of the disk, it needs to be extended for Keylime installation. \
`# sudo lvextend -L+#G  /dev/rootvg/rootlv`  
Where `#` is the number of GB to be added 
3. Reboot the machine 
4. Use `lsblk` and `df -h` to check that it was extended

## Future Work 
### Ansible Playbook 
This set up has not been automated as the ansible collection for Azure does not provide support for `Trusted Launch`. Once support for this is added, then the development of an ansible playbook becomes possible.

