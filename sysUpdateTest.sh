#!/bin/bash
# Darragh Tate, 2021

# Install shellcheck, a bash script analysis tool
# Documentation at https://github.com/koalaman/shellcheck
sudo apt install shellcheck

# Test sysUpdate.sh
# Ignore error SC2034 - Throws error as "i" in loop isn't used (instead is used as a prerequisite for for loop).
# Can safely be ignored in this case- https://github.com/koalaman/shellcheck/wiki/SC2034
shellcheck -e SC2034 sysUpdate.sh