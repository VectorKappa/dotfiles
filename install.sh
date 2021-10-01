#!/bin/zsh
sudo stow -t /usr/bin bin
sudo stow -t /usr/lib/systemd/user systemd_units
sudo cp desktop/multimonitor_prepare /usr/bin/multimonitor_prepare