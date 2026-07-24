FROM ubuntu:noble@sha256:4fbb8e6a8395de5a7550b33509421a2bafbc0aab6c06ba2cef9ebffbc7092d90


RUN echo 'APT::Snapshot "20260720T020500Z";' | tee /etc/apt/apt.conf.d/50snapshot
RUN apt-config dump | grep -i snapshot

RUN apt-get update -o Acquire::https::Verify-Peer=false && apt-get install -y -o Acquire::https::Verify-Peer=false ca-certificates

RUN apt-get install -y build-essential curl dos2unix bsdmainutils gpg gpg-agent
RUN apt policy build-essential
RUN apt policy curl
RUN apt policy dos2unix
RUN apt policy gpg
RUN apt policy gpg-agent

LABEL VERSION="2.0"
LABEL DESCRIPTION="Docker Image To build Shim 16.1 for NComputing Co. Ltd."
LABEL MAINTAINER="NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>"

WORKDIR /opt

ADD pjones.asc .
RUN gpg --no-default-keyring --keyring ./temp_keyring.gpg --import pjones.asc

ARG SHIM_ARCHIVE="shim-16.1.tar.bz2"
ARG SHIM_URL="https://github.com/rhboot/shim/releases/download/16.1/"

# Checksums for the shim tarball
ARG CRC_SHA256="46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603"
ARG CRC_SHA512="ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb"

# download shim archive, verify and extract
RUN curl --silent --location --remote-name "${SHIM_URL}${SHIM_ARCHIVE}" && \
    curl --silent --location --remote-name "${SHIM_URL}${SHIM_ARCHIVE}".asc && \
    echo "${CRC_SHA256} ${SHIM_ARCHIVE}" | sha256sum --check && \
    echo "${CRC_SHA512} ${SHIM_ARCHIVE}" | sha512sum --check && \
    gpg --no-default-keyring --keyring ./temp_keyring.gpg --verify "$SHIM_ARCHIVE".asc "$SHIM_ARCHIVE" && \
    tar -jxvpf "$SHIM_ARCHIVE" && \
    rm "$SHIM_ARCHIVE"

RUN rm ./temp_keyring.gpg*

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
