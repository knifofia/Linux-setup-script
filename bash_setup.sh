#!/bin/bash

install_miniconda() {
    # Variables
    local MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    local MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
    local MINICONDA_INSTALL_PATH="$HOME/miniconda3"

    # Check if Miniconda is already installed
    if [ -d "$MINICONDA_INSTALL_PATH" ]; then
        echo "Miniconda is already installed at $MINICONDA_INSTALL_PATH"
        return
    fi

    # Download Miniconda installer
    echo "Downloading Miniconda installer..."
    wget $MINICONDA_URL -O $MINICONDA_INSTALLER

    # Install Miniconda
    echo "Installing Miniconda..."
    bash $MINICONDA_INSTALLER -b -p $MINICONDA_INSTALL_PATH

    # Initialize Miniconda
    echo "Initializing Miniconda..."
    $MINICONDA_INSTALL_PATH/bin/conda init

    # Clean up
    echo "Cleaning up..."
    rm $MINICONDA_INSTALLER

    echo "Miniconda installation is complete. Please restart your shell."
}

install_git() {
    # Check if Git is installed
    if ! command -v git &> /dev/null; then
        echo "Git is not installed. Installing Git..."
        sudo apt update
        sudo apt install -y git
    else
        echo "Git is already installed."
    fi

    # Check and set user.name if not configured
    if [ -z "$(git config --global user.name)" ]; then
        read -p "Enter your Git user name: " git_username
        git config --global user.name "$git_username"
        echo "Git user name set to: $git_username"
    else
        echo "Git user name is already configured: $(git config --global user.name)"
    fi

    # Check and set user.email if not configured
    if [ -z "$(git config --global user.email)" ]; then
        read -p "Enter your Git email address: " git_email
        git config --global user.email "$git_email"
        echo "Git email address set to: $git_email"
    else
        echo "Git email address is already configured: $(git config --global user.email)"
    fi

    echo "Git setup complete."
}


echo "Install Miniconda"
install_miniconda

echo "Install Git"
install_git

echo "mkdir source"
mkdir source