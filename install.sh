#!/bin/bash

if [ -z "${BASH_VERSION:-}" ]; then
    abort "Bash is required to interpret this script."
elif [ "$(id -u)" -ne 0 ]; then
    abort "Please run the script with sudo or as root."
else
    current_user=$SUDO_USER
fi

if command -v brew &>/dev/null; then
    echo "Homebrew is already installed. Would you like to Uninstall it? ( Y / n )"
    read -rp "> " uninstall
    if [ $uninstall == "Y" ] || [ -z $uninstall ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    elif [ $uninstall == "n" ]; then
        echo "Okay then. Till next time!!"
        exit 1
    else
        echo "$uninstall is not one of the options! ( Y / n )"
        exit 1
    fi
else
    if ! command -v npm &>/dev/null; then
        echo "npm is not installed. Installing npm..."
        echo "Cannot automatically install npm. Please install it manually from https://nodejs.org."
        exit 1
    fi
    clear
    echo "Would you like to install brew? ( Y / n )"
    read -rp "> " install
    echo "Would you like to install Cakebrew? ( Y / n )"
    read -rp "> " Cakebrew
    if [ $install == "Y" ] || [ -z $install ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "(/opt/homebrew/bin/brew shellenv)"
        echo  'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/rob/.zprofile
        brew update
        if [ $Cakebrew == "Y" ] || [ -z $Cakebrew ]; then
            brew install cakebrew
        elif [ $Cakebrew == "n" ]; then
            echo "Cakebrew is not to be installed"
            if command -v brew &>/dev/null; then
                echo "Homebrew installed succesfully!"
            else
                echo "Homebrew Failed installation!"
            fi
            exit 1
        else
            echo "$Cakebrew is not one of the options! ( Y / n )"
            if command -v brew &>/dev/null; then
                echo "Homebrew installed succesfully!"
            else
                echo "Homebrew Failed installation!"
            fi
            exit 1
        fi
        
    elif [ $install == "n" ]; then
        echo "Okay, come back next time if you would like to install Homebrew!"
        exit 1
    else
        echo "$install is not one of the options! ( Y / n )"
        exit 1
    fi
fi
if command -v brew &>/dev/null; then
    echo "Homebrew installed succesfully!"
else
    echo "Homebrew Failed installation!"
fi
if command -v cakebrew &>/dev/null; then
    echo "Cakebrew installed succesfully!"
else
    echo "Cakebrew Failed installation!"
fi