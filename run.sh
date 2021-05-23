#!/usr/bin/env bash

export NVM_DIR=/usr/local/nvm
export NODE_VERSION=7
export NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
export PATH=$NVM_DIR/v$NODE_VERSION/bin:$PATH

. $NVM_DIR/nvm.sh \
    && blockchain-wallet-service start --port 3000 --bind 0.0.0.0

