#!/bin/bash

echo "Before beginning the LAMP installation, it is advisable to add a user."

# Function to add a new user
add_new_user() {
    read -p "Enter the username: " username
    read -s -p "Enter the password: " password
    echo
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists!"
    else
        # Add the user and set the password
        useradd -m "$username"
        echo "$username:$password" | chpasswd
        echo "User '$username' has been added successfully!"
    fi
}

install_lamp() {
    echo "Updating package information..."
    sudo apt update

    echo "Installing Apache..."
    sudo apt install -y apache2

    echo "Configuring UFW to allow Apache traffic..."
    sudo ufw allow in "Apache Full"
    sudo ufw reload

    echo "Installing MySQL..."
    sudo apt install -y mysql-server
    sudo mysql_secure_installation
    echo "Enabling MySQL..."
    sudo systemctl enable mysql

    echo "Installing PHP..."
    sudo apt install -y php libapache2-mod-php php-mysql

    echo "Restarting Apache to apply changes..."
    sudo systemctl restart apache2

    echo "LAMP installation completed successfully!"
}


# Prompt the user to add a new user
read -p "Do you want to add a new user? (Y/yes/y/Yes) " response

case "$response" in
    Y|yes|y|Yes)
        add_new_user
        ;;
    *)
        echo "No new user added."
        ;;
esac


echo "Starting LAMP Installation..."

# Call the function to install LAMP
install_lamp

