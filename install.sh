#!/bin/bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
git clone https://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@github.com/fullstacklabs/devops-ci-challenge.git
cd devops-ci-challenge\codebase
tar -xvf rdicidr-0.1.0
cd rdicidr-0.1.0
cd src
npm install
node index.js
