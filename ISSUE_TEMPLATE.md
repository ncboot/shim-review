Confirm the following are included in your repo, checking each box:

 - [+] completed README.md file with the necessary information
 - [+] shim.efi to be signed
 - [+] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [-] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [-] any extra patches to shim via your own git tree or as files
 - [-] any extra patches to grub via your own git tree or as files
 - [+] build logs
 - [+] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/ncboot/shim-review/tree/ncomputing-shim-x64-20240313`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
[1075d8cee7fac50c87e3b9b10accaed6eaff7514d09122fd7803ece1e3fcbaa0  shimx64.efi]

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
[https://github.com/rhboot/shim-review/issues/279]
