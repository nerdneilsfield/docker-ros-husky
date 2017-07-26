FROM ros:indigo-robot 
MAINTAINER Deng Qi <dengqi@shanghaitech.edu.cn>
RUN apt-get update && \
    apt-get install -y apt-transport-https
ADD sources.list /etc/apt/sources.list
ADD ros-latest.list /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y openssh-server git  \
                       curl wget nano vim  \
                       cmake clang gcc g++ python python-pip && \
    apt-get clean && \
    apt-get autoclean
ADD sshd_config /etc/ssh/sshd_config
RUN curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc > ~/.vimrc && \
    pip install  --upgrade pip && \
    pip install   rosinstall  && \
    /etc/init.d/ssh start && \
    mkdir -p /ros
VOLUME ["/ros"]
EXPOSE 22

WORKDIR  /

CMD ["/bin/bash"]
