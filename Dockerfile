FROM amazonlinux:2

#RUN yum install -y gcc libc6-dev zlib-devel \
RUN yum -y update \
    && yum install -y tar gzip bzip2-devel ed gcc gcc-c++ gcc-gfortran less libcurl-devel openssl openssl-devel readline-devel xz-devel zlib-devel \
    && yum install -y glibc-static libcxx libcxx-devel llvm-toolset-7 zlib-static \
    && rm -rf /var/cache/yum

ENV GRAAL_VERSION 19.1.0
ENV GRAAL_FOLDERNAME graalvm-ce-linux-amd64-${GRAAL_VERSION}
ENV GRAAL_FILENAME ${GRAAL_FOLDERNAME}.tar.gz

RUN curl -4 -L https://github.com/oracle/graal/releases/download/vm-${GRAAL_VERSION}/${GRAAL_FILENAME} -o /tmp/${GRAAL_FILENAME}

RUN tar -zxvf /tmp/${GRAAL_FILENAME} -C /tmp
RUN mv /tmp/graalvm-ce-${GRAAL_VERSION} /usr/lib/graalvm

RUN rm -rf /tmp/*

VOLUME /project
WORKDIR /project

RUN /usr/lib/graalvm/bin/gu install native-image

ENTRYPOINT ["/usr/lib/graalvm/bin/native-image"]
