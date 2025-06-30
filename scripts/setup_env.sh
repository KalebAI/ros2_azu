#!/bin/bash
set -e

# Instalar Miniconda si no está presente (opcional)
if ! command -v conda &> /dev/null; then
  echo "Miniconda no está instalado. Instálalo primero desde https://docs.conda.io/en/latest/miniconda.html"
  exit 1
fi

# Crear entorno conda desde archivo YAML
conda env create -f environment.yaml

# Activar entorno
echo "Para activar el entorno usa:"
echo "conda activate ros2_jazzy_env"

# Instalar ROS 2 Jazzy fuera del entorno conda (solo si no está instalado)
read -p "¿Deseas instalar ROS 2 Jazzy ahora? [s/N] " install_ros
if [[ "$install_ros" =~ ^[Ss]$ ]]; then
  sudo apt update && sudo apt install curl gnupg lsb-release -y
  sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo tee /usr/share/keyrings/ros-archive-keyring.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
  sudo apt update
  sudo apt install ros-jazzy-desktop -y

  # Configura el entorno
  echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
  source ~/.bashrc
  sudo rosdep init || true
  rosdep update
fi
