This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
[NComputing Global, Inc 

NComputing is a software developer providing secure endpoint solutions for companies and organizations worldwide. https://ncomputing.com ]

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
[LEAF OS Linux software endpoint solution by NComputing. ]

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
[NComputing LEAF OS is a Linux software endpoint solution that transforms any x86-64 PC, laptop, or thin client into a secure and centrally managed endpoint to access popular desktop virtualization environments, including Microsoft Azure Virtual Desktop (AVD), Windows 365 Cloud PC, Microsoft Remote Desktop Services (RDS) and others.  LEAF OS solution is available worldwide, covering education, SMB, SME and enterprise customers. 

LEAF OS endpoint solution addresses concerns related to security, corporate data leakage, patch management and central manageability for companies with working-from-home and BYOD initiatives using personal devices.  A bootable USB memory stick can be created containing LEAF OS. Any x86-64 hardware device can secure boot to LEAF OS and instantly becomes a locked-down LEAF OS thin client. 

LEAF OS can be used to repurpose PCs and laptops by converting any x86-64 hardware from a stand-alone computer to a dedicated thin client by installing directly onto an internal hard drive and removing the old system and files. This method extends the usefulness of aging computers using end-of-life operating systems like Windows 7 while giving users powerful up-to-date desktops. 

NComputing would like customers to be able to run LEAFOS Linux endpoint on any x86-64 devices without disabling Secure Boot.]

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
    - Name: Frank Pesek 
    - Position: Chief Software Architect 
    - Email address: fpesek@ncomputing.com 
    - PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the Linux community: file in repo FrankPesek.pub  
        Keyserver:  
        https://keyserver.ubuntu.com/pks/lookup?search=0x2D8A17C5E2DF9D623F41A253539F4199A91B98BB&fingerprint=on&op=index  
        https://pgp.mit.edu/pks/lookup?search=fpesek%40ncomputing.com&op=vindex&fingerprint=on&exact=on  
        Fingerprint=2D8A 17C5 E2DF 9D62 3F41  A253 539F 4199 A91B 98BB  

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
    - Name: Richard Sah 
    - Position: Chief Technology Officer 
    - Email address: rsah@ncomputing.com 
    - PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the Linux community: file in repo RichardSah.pub  
        Keyserver:  
        https://keyserver.ubuntu.com/pks/lookup?search=0x9a6de75eb4a2a6ef9e874b5dbedcc6f14304ec9f&fingerprint=on&op=index  
        https://pgp.mit.edu/pks/lookup?search=rsah%40ncomputing.com&op=vindex&fingerprint=on&exact=on  
        Fingerprint=9A6D E75E B4A2 A6EF 9E87  4B5D BEDC C6F1 4304 EC9F  

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
[shim binary will be created from https://github.com/rhboot/shim/releases/tag/15.4]

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
[https://github.com/rhboot/shim.git, tag 15.4, plus critical commits cherry-picked]

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
[Following commits cherry-picked]  
5b3ca0d2f7b5f425ba1a14db8ce98b8d95a2f89f Fix a broken file header on ia32 Mar 31 14:54:52 2021  
822d07ad4f07ef66fe447a130e1027c88d02a394 Fix handling of ignore_db and user_insecure_mode Apr 8 22:39:02 2021  
4068fd42c891ea6ebdec056f461babc6e4048844 mok: allocate MOK config table as BootServicesData Apr 8 16:23:03 2021  
493bd940e5c6e28e673034687de7adef9529efff Don't call QueryVariableInfo() on EFI 1.10 machines shim#364 Apr 10 16:05:23 2021  
9f973e4e95b1136b8c98051dbbdb1773072cc998 Relax the check for import_mok_state() May 11 10:41:43 2021  
4d64389c6c941d21548b06423b8131c872e3c3c7 shim: another attempt to fix load options handling Jun 7 16:34:18 2021  

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
[Using GRUB 2.06, all above CVEs are fixed]

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
[ We use upstream GRUB https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz
sha256 b79ea44af91b93d17cd3fe80bdae6ed43770678a9a5ae192ccea803ebb657ee1 grub-2.06.tar.xz ]

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
[First time submission]

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
[yes, we have above upstream commits]

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
[No]

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
[N/A]

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and the differences would be.
-------------------------------------------------------------------------------
[Ubuntu 16.4 or above with Docker, run make-shim.sh]

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
[Output of make-shim.sh script is https://github.com/ncboot/shim-review/blob/master/build.log]

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
[N/A]
