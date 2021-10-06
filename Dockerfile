FROM ubuntu:16.04
LABEL MAINTAINER NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>

RUN apt-get update
RUN apt-get install -y build-essential git curl

LABEL VERSION ="1.0"
LABEL DESCRIPTION ="Docker Image To build Shim 15.04 for NComputing Co. Ltd."

WORKDIR /opt
RUN git clone --recursive -b 15.4 https://github.com/rhboot/shim.git shim
WORKDIR /opt/shim
# Fix a broken file header on ia32 Mar 31 14:54:52 2021
RUN git cherry-pick 5b3ca0d2f7b5f425ba1a14db8ce98b8d95a2f89f -n
# Fix handling of ignore_db and user_insecure_mode Apr 8 22:39:02 2021
RUN git cherry-pick 822d07ad4f07ef66fe447a130e1027c88d02a394 -n
# mok: allocate MOK config table as BootServicesData Apr 8 16:23:03 2021
RUN git cherry-pick 4068fd42c891ea6ebdec056f461babc6e4048844 -n
# Don't call QueryVariableInfo() on EFI 1.10 machines shim#364 Apr 10 16:05:23 2021
RUN git cherry-pick 493bd940e5c6e28e673034687de7adef9529efff -n
# Relax the check for import_mok_state() May 11 10:41:43 2021
RUN git cherry-pick 9f973e4e95b1136b8c98051dbbdb1773072cc998 -n
# shim: another attempt to fix load options handling Jun 7 16:34:18 2021
RUN git cherry-pick 4d64389c6c941d21548b06423b8131c872e3c3c7 -n

RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v15.4a/NC.cer
RUN make VENDOR_CERT_FILE=NC.cer
RUN sha256sum shimx64.efi
RUN objdump -s -j .sbat shimx64.efi

