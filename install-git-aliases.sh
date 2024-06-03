#!/bin/bash

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.p push
git config --global alias.pnv 'push --no-verify'
git config --global alias.pfnv 'push -f --no-verify'
git config --global alias.pf 'push -f'
git config --global alias.fa 'fetch --all'
git config --global alias.aa 'add --all'

git config --global fetch.prune true

git config --global core.autocrlf false
git config --global core.eol lf

