FROM rdmix/ubuntu-base:v0.0.1

LABEL maintainer="starkwang wsd312@163.com"
LABEL name="alinode-base"
LABEL version="v0.0.11"
ENV ALINODE_VERSION v6.0.0
ENV NODE_VERSION v14.0.0
ENV ALINODE_BIN_DIR /root/.tnvm/versions/alinode/$ALINODE_VERSION/bin

SHELL ["/bin/bash", "--login", "-c"]

# install alinode
RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash
RUN source ~/.tnvm/tnvm.sh \
    # install node pm2 yarn
    && tnvm install node-$NODE_VERSION \
    && tnvm use node-$NODE_VERSION \
    && tnvm install alinode-$ALINODE_VERSION \
    && tnvm use alinode-$ALINODE_VERSION \
    && npm install @alicloud/agenthub pm2 yarn -g \
    # set env
    && export NODE_LOG_DIR=/tmp \
    && export ENABLE_NODE_LOG=YES \
    && ln -s $ALINODE_BIN_DIR/* /usr/bin
