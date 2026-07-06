FROM ubuntu:noble
LABEL MAINTAINER="NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>"

RUN apt-get update
RUN apt-get install -y build-essential curl dos2unix bsdmainutils gpg gpg-agent

LABEL VERSION="2.0"
LABEL DESCRIPTION="Docker Image To build Shim 16.1 for NComputing Co. Ltd."

WORKDIR /opt

ADD pjones.asc .

ARG SHIM16_1_URL="https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2"

# Checksums for the shim tarball
ARG CRC_SHA256="46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603"
ARG CRC_SHA512="ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb"

# download shim-16.1, verify and extract
RUN curl --silent --location --remote-name ${SHIM16_1_URL} && \
    curl --silent --location --remote-name ${SHIM16_1_URL}.asc && \
    echo "${CRC_SHA256}  $(basename ${SHIM16_1_URL})" | sha256sum --check && \
    echo "${CRC_SHA512}  $(basename ${SHIM16_1_URL})" | sha512sum --check && \
    tar -jxvpf $(basename ${SHIM16_1_URL}) && \
    rm $(basename ${SHIM16_1_URL})

WORKDIR /opt/shim-16.1

ADD NC.cer .
ADD sbat.ncomputing.csv .
ADD shimx64.efi .

RUN ls -l
RUN mv sbat.ncomputing.csv ./data/
RUN sha256sum shimx64.efi > shim_orig_hash
RUN hexdump -Cv shimx64.efi > shim_orig_dump
RUN mv shimx64.efi shimx64.efi.orig

RUN make VENDOR_CERT_FILE=NC.cer

RUN find ./ -name "*.efi"

RUN objdump -s -j .sbat shimx64.efi
RUN sha256sum shimx64.efi > shim_built_hash
RUN hexdump -Cv shimx64.efi > shim_built_dump
RUN cat shim_built_hash
RUN cat shim_orig_hash
RUN diff shim_built_hash shim_orig_hash
RUN diff shim_built_dump shim_orig_dump
