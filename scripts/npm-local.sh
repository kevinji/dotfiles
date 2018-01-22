#!/bin/bash
set -e

mkdir -p "$HOME"/.npm-global
npm config set prefix "\${HOME}/.npm-global"
echo "export NO_SUDO=true" >> "$HOME"/.zprofile-local
