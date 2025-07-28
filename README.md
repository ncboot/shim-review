This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
[NComputing Global, Inc. 
NComputing is a software developer providing secure endpoint solutions for companies and organizations worldwide. https://ncomputing.com ]

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

[ You may find info at https://bizfileonline.sos.ca.gov/search/business by searching "NCOMPUTING GLOBAL"]

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

[your text here]

*******************************************************************************
### What product or service is this for?
*******************************************************************************
[LEAF OS Linux software endpoint solution by NComputing ]

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
[NComputing LEAF OS is a Linux software endpoint solution that transforms any x86-64 PC, laptop, or thin client into a secure and centrally managed endpoint to access popular desktop virtualization environments, including Microsoft Azure Virtual Desktop (AVD), Windows 365 Cloud PC, Microsoft Remote Desktop Services (RDS) and others.  LEAF OS solution is available worldwide, covering education, SMB, SME and enterprise customers. 

LEAF OS endpoint solution addresses concerns related to security, corporate data leakage, patch management and central manageability for companies with working-from-home and BYOD initiatives using personal devices.  A bootable USB memory stick can be created containing LEAF OS. Any x86-64 hardware device can secure boot to LEAF OS and instantly becomes a locked-down LEAF OS thin client. 

LEAF OS can be used to repurpose PCs and laptops by converting any x86-64 hardware from a stand-alone computer to a dedicated thin client by installing directly onto an internal hard drive and removing the old system and files. This method extends the usefulness of aging computers using end-of-life operating systems like Windows 7 while giving users powerful up-to-date desktops. 

NComputing would like customers to be able to run LEAFOS Linux endpoint on any x86-64 devices without disabling Secure Boot.]

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
[NComputing LEAF OS is deeply customized operating system]

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Frank Pesek 
- Position: Chief Software Architect 
- Email address: fpesek@ncomputing.com 
- PGP key fingerprint: file in repo FrankPesek.pub  
        Keyserver:  
        https://keyserver.ubuntu.com/pks/lookup?search=0x2D8A17C5E2DF9D623F41A253539F4199A91B98BB&fingerprint=on&op=index  
        https://pgp.mit.edu/pks/lookup?search=fpesek%40ncomputing.com&op=vindex&fingerprint=on&exact=on  
        Fingerprint=2D8A 17C5 E2DF 9D62 3F41  A253 539F 4199 A91B 98BB  

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Richard Sah 
- Position: Chief Technology Officer 
- Email address: rsah@ncomputing.com 
- PGP key fingerprint: file in repo RichardSah.pub  
        Keyserver:  
        https://keyserver.ubuntu.com/pks/lookup?search=0x9a6de75eb4a2a6ef9e874b5dbedcc6f14304ec9f&fingerprint=on&op=index  
        https://pgp.mit.edu/pks/lookup?search=rsah%40ncomputing.com&op=vindex&fingerprint=on&exact=on  
        Fingerprint=9A6D E75E B4A2 A6EF 9E87  4B5D BEDC C6F1 4304 EC9F  

*******************************************************************************
### Were these binaries created from the 16.0 shim release tar?
Please create your shim binaries starting with the 16.0 shim release tar file: https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.0 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum with the following ones:

```
7b518edd63eb840081912f095ed1487a  shim-16.0.tar.bz2
c2453b9b3c02bc01eea248e9cf634a179ff8828c  shim-16.0.tar.bz2
d503f778dc75895d3130da07e2ff23d2393862f95b6cd3d24b10cbd4af847217  shim-16.0.tar.bz2
b4367f3b1e0716d093f4230902e392d3228bd346e2e07a9377c498d8b3b08a5c0ad25c31aa03af66f54648618074a29b55a3e51925e5cfe5c7ac97257bd25880  shim-16.0.tar.bz2
```

Make sure that you've verified that your build process uses that file
as a source of truth (excluding external patches) and its checksum
matches. You can also further validate the release by checking the PGP
signature: there's [a detached
signature](https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2.asc)

The release is signed by the maintainer Peter Jones - his master key
has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the
signing sub-key in the signature here has the fingerprint
`02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key
is included here for reference:
[pjones.asc](https://github.com/rhboot/shim-review/pjones.asc)

Once you're sure that the tarball you are using is correct and
authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
[We confirm, shim binary will be created from https://github.com/rhboot/shim/releases/tag/16.0 ]

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
[https://github.com/rhboot/shim/releases/tag/16.0 the only difference it is built with NComputing Certificate embedded ]

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************
[no patches ]

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
[NX bit is not set in our shim]

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
[ Using upstream GRUB2 ]

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************
[We are using upstream GRUB 2.12 which has above CVEs fixed]

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
[Yes, upstream global SBAT generation in our GRUB2 binary is set to 4]

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
[ Our new shim does not allow older grub because of upper sbat generation id ]

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
[we have first 2 upstream commits: 1957a85b0032a81e6482ca4aab883643b8dae06e and
75b0cea7bf307f362057cc778efe89af4c615354. 3rd is not used in our upstream kernel version but CONFIG_DEBUG_KERNEL is not set ]

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs
### with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
[your text here]

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
[No local patches]

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
[Yes, ephemeral key for signing kernel modules is used]

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
[No vendor_db]

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
[We changing to a new (CA) certificate. Anyway in future older GRUB2 builds will be disallowed to boot by generation id in SBAT]

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
[Ubuntu 20.4 or above with Docker, run make-shim.sh ]

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
[build.log file is output of make-shim.sh ]

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
[New NComputing certificate in shim bootloader, updated grub2 version to 2.12, updated kernel to 6.1.78 or upper ]

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
[1075d8cee7fac50c87e3b9b10accaed6eaff7514d09122fd7803ece1e3fcbaa0 shimx64.efi]

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
[Keys are stored in a FIPS 140-2 certified HW token provided by Certification Authorities ]

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
[Yes ]

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
[yes, embedding a CA certificate, X509v3 Basic Constraints is set to FALSE]

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --only-section .sbat -O binary YOUR_EFI_BINARY /dev/stdout` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************
[SHIM:  
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md  
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim  
shim.ncomputing,1,NComputing Global Inc,shim,16.0,mail:security@ncomputing.com  
  
GRUB2:  
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md  
grub,4,Free Software Foundation,grub,2.12,https//www.gnu.org/software/grub/  
grub.ncomputing,1,NComputing Global Inc,grub2,2.12,mail:security@ncomputing.com  
]

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
[all_video boot linux ext2 fat font squash4 part_msdos part_gpt normal]

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
[No arm64 or RISCV]

*******************************************************************************
### 1What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
[ Upstream GRUB2 https://git.savannah.gnu.org/git/grub.git, tag grub-2.12 ]

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
[ shimx64.efi launches only GRUB2, which then launches kernel ]

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
[ GRUB2 launches kernel only, no other components. GRUB2 verifies signatures of kernel using shim routines. ]

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
[GRUB2 verifies signatures of kernel using shim routines]

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
[no]

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
[ upstream kernel 6.1.78 which supports SecureBoot ]

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
[]

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
[]

