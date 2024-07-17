# LAMP Stack and User Setup Script

This shell script automates the installation of a LAMP stack (Linux, Apache, MySQL, PHP) on a Linux system and provides functionality to add a new user. It also configures UFW (Uncomplicated Firewall) to allow Apache traffic.

## Features

- Updates package information.
- Installs and configures Apache, MySQL, and PHP.
- Configures UFW to allow Apache traffic.
- Adds a new user with a specified username and password.

## Prerequisites

- A Debian-based Linux distribution (e.g., Ubuntu).
- Root privileges to execute the script.

## Usage

1. **Download the Script**

   Save the script to a file, e.g., `setup_lamp_and_user.sh`.

2. **Make the Script Executable**

   ```bash
   chmod +x setup_lamp_and_user.sh
   ```

3. **Run the Script with Root Privileges**

   ```bash
   sudo ./setup_lamp_and_user.sh
   ```

4. **Follow the Prompts**

   - The script will prompt you to add a new user. If you choose to add a new user, you will need to provide a username and password.
   - The script will then proceed to install the LAMP stack and configure UFW to allow Apache traffic.

## Script Explanation

### Function: `add_new_user`

This function handles the addition of a new user.

- Prompts for the new username and password.
- Checks if the user already exists using `id "$username"`.
- Adds the user if they do not exist using `sudo useradd -m "$username"` and sets the password using `echo "$username:$password" | sudo chpasswd`.

### Function: `install_lamp`

This function handles the installation of the LAMP stack and UFW configuration.

- **Update Package Information**: Runs `sudo apt update` to ensure the package list is up to date.
- **Install Apache**: Installs the Apache web server using `sudo apt install -y apache2`.
- **Configure UFW**: Configures UFW to allow incoming traffic for Apache using `sudo ufw allow in "Apache Full"` and reloads UFW with `sudo ufw reload`.
- **Install MySQL**: Installs MySQL server using `sudo apt install -y mysql-server` and runs `sudo mysql_secure_installation` to secure the installation.
- **Install PHP**: Installs PHP and the necessary modules to integrate it with Apache and MySQL using `sudo apt install -y php libapache2-mod-php php-mysql`.
- **Restart Apache**: Restarts Apache to apply changes with `sudo systemctl restart apache2`.

### Main Script

- Prompts the user to add a new user.
- If the response is positive, it calls `add_new_user`.
- Regardless of the user addition, it calls `install_lamp` to set up the LAMP stack.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Please feel free to submit issues and pull requests.

## Acknowledgments

Inspired by various online resources and tutorials on setting up a LAMP stack and user management in Linux.
