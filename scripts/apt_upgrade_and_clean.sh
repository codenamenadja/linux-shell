#!/bin/bash
# Script to automate regular software upgrades

apt update
apt upgrade -y
apt autoclean
apt autoremove
