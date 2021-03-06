#!/bin/bash
set -e

# make sure the package repository is up to date
zypper --non-interactive --gpg-auto-import-keys ref

# Packages required to run spacewalk-setup inside of the container
zypper in -y postgresql91-contrib \
             postgresql91-server \
             postgresql91-pltcl \
             smdba \
             syslog-ng \
             perl-DBD-Pg
