#!/usr/bin/env bash

VERSION=$(ls -1 /usr/local/texlive | grep -o "[0-9]*" | sort -r | head -1)
pushd /usr/local/texlive/$VERSION/texmf-dist/source/platex/jsclasses
platex jsclasses.ins
popd

pushd ~
git clone https://github.com/matze/mtheme
pushd mtheme
make sty
make install
popd
popd

## Compile TeX files & Generating PDF file.
latexmk -C 
latexmk
# make build
