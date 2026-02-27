FROM osrf/ros:jazzy-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV GZ_VERSION=harmonic

RUN apt-get update && apt-get install -y \
    ros-jazzy-ros-gz \
    ros-jazzy-ros-gz-bridge \
    ros-jazzy-ros-gz-sim \
    python3-colcon-common-extensions \
    git wget sudo make cmake build-essential \
	python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --break-system-packages \
	kconfiglib \
	jinja2 \
    empy \
    jsonschema \
    pyros-genmsg \
    packaging \
    toml \
    numpy \
    future

ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN if id -u $USER_UID >/dev/null 2>&1; then \
        EXISTING_USER=$(id -nu $USER_UID); \
        usermod -l $USERNAME $EXISTING_USER; \
        groupmod -n $USERNAME $(id -ng $USER_UID); \
        usermod -d /home/$USERNAME -m $USERNAME; \
    else \
        groupadd --gid $USER_GID $USERNAME && \
        useradd --uid $USER_UID --gid $USER_GID -m $USERNAME; \
    fi \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME/ros2_ws
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc 
