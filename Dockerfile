FROM ubuntu:noble
LABEL MAINTAINER NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>

RUN apt-get update
RUN apt-get install -y build-essential curl dos2unix bsdmainutils gpg gpg-agent

LABEL VERSION ="2.0"
LABEL DESCRIPTION ="Docker Image To build Shim 16.0 for NComputing Co. Ltd."

WORKDIR /opt

#RUN git clone --recursive -b 15.8 https://github.com/rhboot/shim.git shim

ADD pjones.asc .

ARG SHIM16_URL="https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2"

# Checksums for the shim tarball
ARG CRC_MD5="7b518edd63eb840081912f095ed1487a"
ARG CRC_SHA1="c2453b9b3c02bc01eea248e9cf634a179ff8828c"
ARG CRC_SHA256="d503f778dc75895d3130da07e2ff23d2393862f95b6cd3d24b10cbd4af847217"
ARG CRC_SHA512="b4367f3b1e0716d093f4230902e392d3228bd346e2e07a9377c498d8b3b08a5c0ad25c31aa03af66f54648618074a29b55a3e51925e5cfe5c7ac97257bd25880"

# download shim-16.0, verify and extract
RUN curl --silent --location --remote-name ${SHIM16_URL} && \
    curl --silent --location --remote-name ${SHIM16_URL}.asc && \
    echo "${CRC_MD5}  $(basename ${SHIM16_URL})" | md5sum --check && \
    echo "${CRC_SHA1}  $(basename ${SHIM16_URL})" | sha1sum --check && \
    echo "${CRC_SHA256}  $(basename ${SHIM16_URL})" | sha256sum --check && \
    echo "${CRC_SHA512}  $(basename ${SHIM16_URL})" | sha512sum --check && \
    tar -jxvpf $(basename ${SHIM16_URL}) && \
    rm $(basename ${SHIM16_URL})

WORKDIR /opt/shim-16.0

#do not download 
#RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v16.0/NC.cer
#RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v16.0/sbat.ncomputing.csv
#RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/v16.0/shimx64.efi

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
