#!/bin/bash

source $HOME/.nvm/nvm.sh; 
nvm install 0.10.24
nvm use 0.10.24
nvm alias default 0.10.24

npm install -g yo
npm install -g generator-angular
