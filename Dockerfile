FROM ubuntu:16.04
LABEL MAINTAINER NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>

RUN apt-get update
RUN apt-get install -y build-essential git curl

LABEL VERSION ="1.0"
LABEL DESCRIPTION ="Docker Image To build Shim 15.04 for NComputing Co. Ltd."

WORKDIR /opt
RUN git clone --recursive -b rel-v15.4 https://github.com/ncboot/shim.git shim
WORKDIR /opt/shim
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v15.4a/NC.cer
RUN make VENDOR_CERT_FILE=NC.cer
RUN sha256sum shimx64.efi
RUN objdump -s -j .sbat shimx64.efi

