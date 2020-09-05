FROM ubuntu:18.04

WORKDIR /root
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	apt update && apt install -y vim openssh-server net-tools
COPY ./sshd_config /etc/ssh/
COPY ./start.sh .
RUN chmod u+x start.sh

EXPOSE 2222
VOLUME /root/Projects
ENTRYPOINT ["./start.sh"]
CMD ["start"]
