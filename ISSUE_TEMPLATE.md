Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag  
            https://github.com/ncboot/shim-review/tree/v15.4c
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed  
            https://github.com/ncboot/shim-review/blob/v15.4c/shimx64.efi
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)  
            https://github.com/ncboot/shim-review/blob/v15.4c/NC.cer
 - [x] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes allow-listed )  
            no binaries
 - [x] any extra patches to shim via your own git tree or as files  
            no patches
 - [x] any extra patches to grub via your own git tree or as files  
            no patches
 - [x] build logs  
            https://github.com/ncboot/shim-review/blob/v15.4c/build.log
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries  
            https://github.com/ncboot/shim-review/blob/v15.4c/Dockerfile

###### What organization or people are asking to have this signed:
`[NComputing Global, Inc. ]`

###### What product or service is this for:
`[LEAF OS Linux software endpoint solution by NComputing. ]`

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
`[yes, we use directly https://github.com/rhboot/shim/releases/tag/15.4]`

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
`[NComputing LEAF OS is a Linux software endpoint solution that transforms any x86-64 PC, laptop, or thin client into a secure and centrally managed endpoint to access popular desktop virtualization environments, including Microsoft Azure Virtual Desktop (AVD), Windows 365 Cloud PC, Microsoft Remote Desktop Services (RDS) and others.  
LEAF OS solution is available worldwide, covering education, SMB, SME and enterprise customers.   
LEAF OS endpoint solution addresses concerns related to security, corporate data leakage, patch management and central manageability for companies with working-from-home and BYOD initiatives using personal devices.  
A bootable USB memory stick can be created containing LEAF OS. Any x86-64 hardware device can secure boot to LEAF OS and instantly becomes a locked-down LEAF OS thin client. 
LEAF OS can be used to repurpose PCs and laptops by converting any x86-64 hardware from a stand-alone computer to a dedicated thin client by installing directly onto an internal hard drive and removing the old system and files.  
This method extends the usefulness of aging computers using end-of-life operating systems like Windows 7 while giving users powerful up-to-date desktops.  
NComputing would like customers to be able to run LEAFOS Linux endpoint on any x86-64 devices without disabling Secure Boot.]`

###### How do you manage and protect the keys used in your SHIM?
`[keys are on HW eToken (SafeNet eToken 5110 FIPS) kept by authorized persons]`

###### Do you use EV certificates as embedded certificates in the SHIM?
`[yes, we have EV certificate (file NC.cer in this repo) embedded into shim]`

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
`[vendor_db is not used]`

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
`[yes, our kernel has upstream commit "ACPI: configfs: Disallow loading ACPI tables when locked down" 75b0cea7bf307f362057cc778efe89af4c615354 applied]`

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
`[We use upstream GRUB 2.06 with all above CVEs fixed]`

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
`[Our GRUB2 has embedded SBAT section with following 3 lines:]`

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md  
grub,1,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/  
grub.ncomputing,1,Free Software Foundation,grub,2.06,https://ncomputing.com  

##### Were your old SHIM hashes provided to Microsoft ?
`[No, this is first time submission, we have no older SHIMs]`

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
`[We use upstream GRUB 2.06 trusting it's strategy]`

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
`[We use upstream GRUB 2.06 with SBAT section]`

###### What is the origin and full version number of your bootloader (GRUB or other)?
`[GRUB https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz sha256 b79ea44af91b93d17cd3fe80bdae6ed43770678a9a5ae192ccea803ebb657ee1 grub-2.06.tar.xz]`

###### If your SHIM launches any other components, please provide further details on what is launched
`[No, shim launches GRUB only]`

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
`[GRUB2 lanches Kernel only]`

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
`[This is first time submission, we do not have older GRUB2 binaries]`

###### How do the launched components prevent execution of unauthenticated code?
`[We use chained loading: shim -> grub2 -> kernel with all components signed ]`

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
`[No]`

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
`[Kernel 5.10]`

###### What changes were made since your SHIM was last signed?
`[This is first time submission]`

###### What is the SHA256 hash of your final SHIM binary?
`[3ac79c4370f14e444f036319de1c5fbb1fee098e14b6e16cc073b15aa9ef7c39]`
