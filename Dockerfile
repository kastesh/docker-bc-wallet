FROM centos:7

RUN yum -y update \
    && yum -y upgrade \
    && yum groupinstall 'Development Tools' -y

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 7
ENV USER centos
ENV GROUP centos
ENV UID 1000
ENV GID 1000


RUN groupadd -g ${GID} ${GROUP} \
    && useradd -u ${UID} -g ${GID} ${USER}

RUN mkdir -p $NVM_DIR

RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default 

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN . $NVM_DIR/nvm.sh \ 
    && npm install -g blockchain-wallet-service

RUN yum clean all -y

COPY run.sh /docker-entrypoint.sh

RUN chmod 755 /docker-entrypoint.sh

USER ${USER}

ENTRYPOINT ["/docker-entrypoint.sh"]
