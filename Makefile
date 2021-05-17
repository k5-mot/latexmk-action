#!/usr/bin/make -f

##
## Default variables
##
ROOTNAME  := main
ROOTTEX   := $(ROOTNAME).tex
ROOTPDF   := build/$(ROOTNAME).pdf
SRCDIR    := src
BIBDIR    := bib
CODEDIR   := code
FIGDIR    := figure
TEXFILES  := $(ROOTTEX) $(wildcard $(SRCDIR)/*.tex)
BIBFILES  := $(wildcard $(BIBDIR)/*.bib)
CODEFILES := $(wildcard $(CODEDIR)/*.*)
FIGFILES  := $(wildcard $(FIGDIR)/*.*)
ALLFILES  := $(TEXFILES) $(BIBFILES) $(CODEFILES) $(FIGFILES)

EXCLUDES  := .git .vscode build release

##
## Tools
##
LATEXMK   := latexmk
PDFVIEWER := evince
MKDIR     := mkdir -p
RM        := rm -rf
CP        := cp -rf
#PDFVIEWER = acroread

##
## Commands
##
default: help         ## View help for Makefile.

all:     view         ## View a PDF file.

view:    build        ## View a PDF file.
	$(PDFVIEWER) $(ROOTPDF) &

build:   $(ROOTPDF)   ## Generate a PDF file from TeX files.

clean:                ## Remove generated files.
	$(LATEXMK) -C
	$(RM) build

rebuild: clean build  ## Regenerate a PDF file.

help:                 ## View help for Makefile.
	@printf "$$HELP_TXT"
	@printf "\033[36m%-20s\033[0m %s\n" "[Command]" "[Description]"
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m %-20s\033[0m %s\n", $$1, $$2}'

$(ROOTPDF): $(ALLFILES)
	$(LATEXMK)

.PHONY: clean

.DEFAULT_GOAL := help

##
## Appendix
##
export HELP_TXT
define HELP_TXT
\033[35m \033[35m-----------------------------------------------------\033[35m
\033[35m|\033[34m       _    _____                        _           \033[35m|
\033[35m|\033[34m      | |  |  ___|                      | |          \033[35m|
\033[35m|\033[34m      | | _|___ \ ______ _ __ ___   ___ | |_         \033[35m|
\033[35m|\033[34m      | |/ /   \ \______| '_ ` _ \ / _ \| __|        \033[35m|
\033[35m|\033[34m      |   </\__/ /      | | | | | | (_) | |_         \033[35m|
\033[35m|\033[34m      |_|\_\____/       |_| |_| |_|\___/ \__|        \033[35m|
\033[35m|\033[34m                                                     \033[35m|
\033[35m|\033[37m Copyright (c) 2020-2021 k5-mot All Rights Reserved. \033[35m|
\033[35m|\033[37m    "k5-mot/slide_template" is under MIT license.    \033[35m|
\033[35m \033[35m-----------------------------------------------------\033[35m


endef

