#!/bin/bash

# einige Helfer Funktionen "fürs Auge",
# credits: Ben "cowboy" Alman
# siehe auch https://github.com/cowboy/dotfiles/blob/master/bin/dotfiles#L26-L30
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

# Blacklist Einträge
e_header "Blacklist Einträge"
jn=0
while [ $jn = 0 ]; do
    read -p "Die Treiber 'dw_dmac' und 'dw_dmac_core' führen manchmal zu \
Problemen beim hochfahren. \
Sollen die Einträge in die blacklist.conf eingetragen werden? ([J]a oder [N]ein)" jn
    case $jn in
        [JjYy]* )
                    echo "blacklist dw_dmac" >> /etc/modprobe.d/blacklist.conf
                    echo "blacklist dw_dmac_core" >> /etc/modprobe.d/blacklist.conf
                    e_success "Einträge in blacklist.conf eingetragen"
                    break;;
        [Nn]* ) e_error "Einträge werden nicht in die blacklist.conf eingefügt";;
        * ) jn=0; e_arrow "Bitte antworte mit [J]a oder [N]ein";;
    esac
done

# Standby Bugfix
e_header "Standby Bugfix"
jn=0
while [ $jn = 0 ]; do
    read -p "Soll der Standby Bugfix eingetragen werden? ([J]a oder [N]ein)" jn
    case $jn in
        [JjYy]* )
                    cp ./files/20_custom-ehci_hcd /etc/pm/sleep.d/
                    e_success "Standby Bugfix eingetragen"
                    break;;
        [Nn]* ) e_error "Standby Bugfix wird nicht eingefügt";;
        * ) jn=0; e_arrow "Bitte antworte mit [J]a oder [N]ein";;
    esac
done

# Displayhelligkeit Bugfix
e_header "Displayhelligkeit Bugfix"
jn=0
while [ $jn = 0 ]; do
    read -p "Soll der Displayhelligkeit Bugfix eingetragen werden? ([J]a oder [N]ein)" jn
    case $jn in
        [JjYy]* )
                    cp ./files/20-intel.conf /usr/share/X11/xorg.conf.d/
                    e_success "Displayhelligkeit Bugfix eingetragen"
                    break;;
        [Nn]* ) e_error "Displayhelligkeit Bugfix wird nicht eingefügt";;
        * ) jn=0; e_arrow "Bitte antworte mit [J]a oder [N]ein";;
    esac
done
