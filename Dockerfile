FROM centos:7 as builder

RUN yum -y update && \
    yum -y install wget && \
    wget  https://github.com/git/git/archive/v2.25.0.tar.gz && \
    tar -zxvf v2.25.0.tar.gz  && \
    cd git-2.25.0 && \
    yum -y install "@Development tools" && \
    yum -y install gettext-devel curl-devel perl-CPAN perl-devel openssl-devel zlib-devel && \
    make configure  && \
    ./configure --prefix=/usr/local && \
    make -j`nproc` && \
    make -j`nproc` test && \
    yum -y remove git  && \
    make install

FROM centos:7
COPY --from=builder /usr/local/bin/ /usr/local/bin
CMD ["/bin/bash"]


