# ssr-with-net-speeder
FROM ubuntu:14.04.3
MAINTAINER neptunegg <tua@live.cn>

RUN apt-get update && \
apt-get clean  

RUN apt-get install -y openssh-server python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc && \
dpkg -y --add-architecture i386; apt-get update;sudo apt-get install -y mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates tmux lib32gcc1 libstdc++6 libstdc++6:i386  && \
apt-get clean

RUN echo "l4d2server:l4d2server123"|chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


WORKDIR l4d2server

RUN wget https://gameservermanagers.com/dl/l4d2server

RUN chmod +x l4d2server

RUN ./l4d2server install -y

#RUN git clone https://github.com/snooda/net-speeder.git net-speeder
#WORKDIR net-speeder
#RUN sh build.sh

#RUN mv net_speeder /usr/local/bin/
#COPY entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/net_speeder

# Configure container to run as an executable
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]