#!/bin/bash
set -e

# Verifica si ROS ya está instalado
if [ -d "/opt/ros/jazzy" ]; then
    echo "ROS 2 Jazzy ya está instalado."
    exit 0
fi

echo "Instalando ROS 2 Jazzy para Ubuntu 24.04..."

# Configurar repositorio
sudo apt update && sudo apt install -y software-properties-common curl gnupg lsb-release

# Añadir clave GPG de ROS correctamente
echo "➤ Añadiendo clave GPG para ROS..."
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc \
| gpg --dearmor \
| sudo tee /usr/share/keyrings/ros-archive-keyring.gpg > /dev/null

# Añadir el repositorio de ROS 2 para Ubuntu 24.04 (Noble)
echo "➤ Añadiendo repositorio de ROS 2 Jazzy..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros2/ubuntu noble main" \
| sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null


# Instalar ROS 2
sudo apt update
sudo apt install -y ros-jazzy-desktop

# Configurar entorno para ROS
echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
source /opt/ros/jazzy/setup.bash

# Inicializar rosdep
sudo apt install -y python3-rosdep
sudo rosdep init || true
rosdep update

echo "✅ ROS 2 Jazzy instalado correctamente."
