FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

#install tools
RUN apt update && apt install -y wget curl gpg-agent python-pip

#install ROS
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -  
RUN apt update && apt install -y ros-melodic-desktop-full

#install gazebo
RUN  sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
  wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add - && apt update && \
  apt install -y gazebo9 ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control libgazebo9-dev

RUN apt install -y curl pkg-config psmisc xvfb libjansson-dev libboost-dev imagemagick libtinyxml-dev ros-melodic-genpy

#install frequetly used ros pkgs
RUN apt install -y ros-melodic-rosbridge-server
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' && \
    wget http://packages.ros.org/ros.key -O - | sudo apt-key add - && \
    apt update && \
    apt install -y  python-catkin-tools

#install miscs
RUN apt install -y gdb terminator
RUN apt install -y apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt update && apt install -y code

#ws setting
RUN echo source /opt/ros/melodic/setup.bash >> /root/.bashrc
ENV CATKIN_WS=/opt/catkin_ws
RUN mkdir -p /opt/catkin_ws/src
WORKDIR ${CATKIN_WS}/src
RUN catkin init

#temp
RUN apt upgrade -y libignition-math4

# setup entrypoint
# COPY ./ros_entrypoint.sh /ros_entrypoint.sh

# ENTRYPOINT ["/ros_entrypoint.sh"]
# CMD ["bash"]