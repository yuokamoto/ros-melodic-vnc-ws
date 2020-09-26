# VNC Docker container images with ROS

### RUN
```sh
docker run -p 6080:80 yuokamoto1988/ros-melodic-vnc-ws
```

### RUN with password
```sh
docker run -p 6080:80 -e VNC_PASSWORD=mypassword yuokamoto1988/ros-melodic-vnc-ws
```

### RUN with volume mout
```sh
docker run -p 6080:80 -v <path to file in local>:<absolute path in container> yuokamoto1988/ros-melodic-vnc-ws
```
