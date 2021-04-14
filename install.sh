#!/bin/bash

# Check this packages
pkg=(python3)
pkg_manager=(apt brew)

# Check your default package manager and install packages
install_pkg () {
    if [[ $(which $1) && ! "not found" =~ $(which $1) ]]; then
        :
    else
        for manager in ${pkg_manager[*]}; do
            [[ $(which $manager) ]] && sudo $manager install $1 && return
        done
    fi
}

# Installing all packages that you dont have
install_all_pkg () {
    for x in ${pkg[*]}; do 
        install_pkg $x
    done
}

# Copy file in the default bin location (for user)
cp_epinorm() {
    sudo cp $1 /usr/local/bin/epinorm
}

# Main function
main () {
    install_all_pkg
    cp_epinorm EpiNorm.py
}

main