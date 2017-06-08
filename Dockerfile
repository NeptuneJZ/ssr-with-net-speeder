# l4d2server
FROM ubuntu:16.04

RUN dpkg --add-architecture i386
RUN apt-get update
#RUN ls /etc/dpkg/dpkg.cfg.d/
#RUN sh -c "echo 'foreign-architecture i386' > /etc/dpkg/dpkg.cfg.d/multiarch"

RUN apt-get install -y openssh-server mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates tmux lib32gcc1 libstdc++6 libstdc++6:i386 binutils vim
RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN adduser l4d2server
RUN echo 'l4d2server:l4d2server' |chpasswd
RUN su - l4d2server


RUN su l4d2server -l -c "wget https://gameservermanagers.com/dl/l4d2server -P /home/l4d2server"
RUN chmod +x /home/l4d2server/l4d2server

RUN su l4d2server -l -c "yes|/home/l4d2server/l4d2server install"

RUN su l4d2server -l -c "remove /home/l4d2server/serverfiles/left4dead2/cfg/l4d2-server.cfg"
COPY l4d2-server.cfg /home/l4d2server/serverfiles/left4dead2/cfg

#RUN su l4d2server -l -c "/home/l4d2server/l4d2server install" 

#RUN echo y > su l4d2server -l -c "/home/l4d2server/l4d2server install"
EXPOSE 22
EXPOSE 27015
EXPOSE 27005

CMD ["/usr/sbin/sshd", "-D"]







#FROM ubuntu:14.04
#MAINTAINER neptunegg <tua@live.cn>

#RUN apt-get update && \
#apt-get clean  

#RUN apt-get install -y openssh-server python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc && \
#apt-get clean

#RUN echo "root:password"|chpasswd
#RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
#	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
	



#WORKDIR l4d2server

#RUN wget https://gameservermanagers.com/dl/l4d2server

#RUN chmod +x l4d2server

#RUN ./l4d2server install -y

#RUN git clone https://github.com/snooda/net-speeder.git net-speeder
#WORKDIR net-speeder
#RUN sh build.sh

#RUN mv net_speeder /usr/local/bin/
#COPY entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/net_speeder

# Configure container to run as an executable
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
