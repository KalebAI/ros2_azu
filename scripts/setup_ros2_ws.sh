#!/bin/bash
set -e
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws

if [ -f ../ros2_project/ros2.repos ]; then
    vcs import src < ../ros2_project/ros2.repos
fi

rosdep install --from-paths src --ignore-src -r -y
colcon build
