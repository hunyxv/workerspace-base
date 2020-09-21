FROM ubuntu:18.04

WORKDIR /root
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	apt update && apt install -y vim openssh-server net-tools git wget gcc libc6-dev

RUN wget https://codeload.github.com/golang/go/tar.gz/go1.15.2 -O go1.15.2.linux-amd64.tar.gz && \
	tar -zxf go1.15.2.linux-amd64.tar.gz && cd ./go-go1.15.2/go-go1.15.2/src && \
	export GOROOT_BOOTSTRAP=/usr/local/lib/go && export CGO_ENABLE=0 && \ 
	./all.bash
	
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
