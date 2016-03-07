FROM ubuntu:latest

MAINTAINER Leonard Marschke <leonard@marschke.me>

#update software repos
RUN apt-get update \
#ugrade software
    && apt-get -y upgrade \
    && apt-get -y install apt-utils \
    && apt-get -y install \
        git \
        curl \
        unzip \
        software-properties-common \
#clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:webupd8team/java \
    && apt-get update \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get -y install oracle-java8-installer \
        oracle-java8-set-default \
#clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -r /var/cache/oracle-jdk8-installer

ENV JAVA_HOME '/usr/lib/jvm/java-8-oracle/'

RUN curl http://product-dist.wso2.com/products/enterprise-mobility-manager/2.0.0/wso2emm-2.0.0.zip -o /tmp/wso2emm.zip \
    && mkdir /tmp/wso2emm \
    && unzip /tmp/wso2emm.zip -d /tmp/wso2emm \
    && mkdir /usr/local/wso2emm \
    && mv /tmp/wso2emm/*/* /usr/local/wso2emm \
    && rm -R /tmp/wso2emm \
    && rm /tmp/wso2emm.zip

RUN cp -av /usr/local/wso2emm/repository /usr/local/wso2emm/repository_original

ADD init.sh /usr/local/bin/init.sh

CMD /usr/local/bin/init.sh

VOLUME /usr/local/wso2emm/repository
