FROM ubuntu:18.04
LABEL MAINTAINER NComputing Co. Ltd. <info _AT_ ncomputing _DOT_ com>

RUN apt-get update
RUN apt-get install -y build-essential git curl dos2unix bsdmainutils

LABEL VERSION ="1.0"
LABEL DESCRIPTION ="Docker Image To build Shim 15.6 for NComputing Co. Ltd."

WORKDIR /opt
RUN git clone --recursive -b 15.6 https://github.com/rhboot/shim.git shim
WORKDIR /opt/shim

#development
#RUN curl -O http://10.8.2.21/NC.cer
#RUN curl -O http://10.8.2.21/sbat.ncomputing.csv
#RUN curl -O http://10.8.2.21/shimx64.efi

#production
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/ncomputing-shim-x64-20220826/NC.cer
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/ncomputing-shim-x64-20220826/sbat.ncomputing.csv
RUN curl -O  https://raw.githubusercontent.com/ncboot/shim-review/ncomputing-shim-x64-20220826/shimx64.efi

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
