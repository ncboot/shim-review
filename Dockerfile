FROM ubuntu:18.04
LABEL MAINTAINER NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>

RUN apt-get update
RUN apt-get install -y build-essential git curl dos2unix bsdmainutils

LABEL VERSION ="1.0"
LABEL DESCRIPTION ="Docker Image To build Shim 15.8 for NComputing Co. Ltd."

WORKDIR /opt
RUN git clone --recursive -b 15.8 https://github.com/rhboot/shim.git shim
WORKDIR /opt/shim

#production
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v15.8a/NC.cer
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v15.8a/sbat.ncomputing.csv
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v15.8a/shimx64.efi

RUN ls -l
RUN cp sbat.ncomputing.csv ./data/
RUN sha256sum shimx64.efi > shim_orig_hash
RUN hexdump -Cv shimx64.efi > shim_orig_dump
RUN cp shimx64.efi shimx64.efi.orig

RUN make VENDOR_CERT_FILE=NC.cer
RUN objdump -s -j .sbat shimx64.efi
RUN sha256sum shimx64.efi > shim_built_hash
RUN hexdump -Cv shimx64.efi > shim_built_dump
RUN cat shim_built_hash
RUN cat shim_orig_hash
RUN diff shim_built_hash shim_orig_hash
RUN diff shim_built_dump shim_orig_dump
