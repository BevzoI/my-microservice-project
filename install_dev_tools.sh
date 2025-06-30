
# Встановлення Docker
install_docker() {
    if check_command docker; then
        echo "Docker вже встановлено."
    else
        echo "🔧 Встановлення Docker..."
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        echo "Docker встановлено."
    fi
}

# Встановлення Docker Compose
install_docker_compose() {
    if check_command docker-compose; then
        echo "Docker Compose вже встановлено."
    else
        echo "🔧 Встановлення Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        echo "Docker Compose встановлено."
    fi
}

# Встановлення Python
install_python() {
    if check_command python3 && python3 --version | grep -qE "3\.(9|1[0-9])"; then
        echo "Python 3.9+ вже встановлено."
    else
        echo "🔧 Встановлення Python 3.9..."
        sudo apt-get update
        sudo apt-get install -y python3.9 python3.9-venv python3.9-distutils
        sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
        echo "Python 3.9 встановлено."
    fi
}

# Встановлення pip та Django
install_django() {
    if check_command pip3 && python3 -m django --version >/dev/null 2>&1; then
        echo "Django вже встановлено."
    else
        echo "Встановлення pip та Django..."
        sudo apt-get install -y python3-pip
        pip3 install --upgrade pip
        pip3 install django
        echo "Django встановлено."
    fi
}

# Виконання всіх встановлень
install_docker
install_docker_compose
install_python
install_django

echo " Усі інструменти встановлені або вже були встановлені."
