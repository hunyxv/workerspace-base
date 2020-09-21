FROM ubuntu:18.04

WORKDIR /root
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	apt update && apt install -y vim openssh-server net-tools git wget gcc libc6-dev

RUN wget https://studygolang.com/dl/golang/go1.15.2.src.tar.gz && apt install -y golang
RUN tar -zxf go1.15.2.src.tar.gz -C /usr/local/lib && cd /usr/local/lib/go/src && ./all.bash
RUN apt remove -y golang && apt autoremove -y && apt-get autoclean && rm -rf /var/lib/apt/lists/*
	
ENV GOROOT=/usr/local/lib/go GOPATH=/root/Projects/go
ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH
COPY ./sshd_config /etc/ssh/
COPY ./start.sh .

RUN chmod u+x start.sh

EXPOSE 22
VOLUME /root/go
ENTRYPOINT ["./start.sh"]
CMD ["start"]


#FROM ubuntu:18.04

#WORKDIR /root
#ENV TZ=Asia/Shanghai
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
#	apt update && apt install -y vim openssh-server net-tools git wget
##ADD ./go1.15/go1.15.2.linux-amd64.tar.gz /usr/local/lib
#ADD ./go1.12/go1.12.17.linux-amd64.tar.gz /usr/local/lib
#ENV GOROOT=/usr/local/lib/go GOPATH=/root/Projects/go
#ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH
#COPY ./sshd_config /etc/ssh/
#COPY ./start.sh .

#RUN chmod u+x start.sh

#EXPOSE 22
#VOLUME /root/go
#ENTRYPOINT ["./start.sh"]
#CMD ["start"]
