FROM ubuntu:14.04

MAINTAINER Scott Coulton "https://github.com/scotty-c/docker-openvpn"
MAINTAINER Saidimu Apale "https://github.com/saidimu/docker-openvpn"

ENV OPENVPNAS_LATEST http://swupdate.openvpn.org/as/openvpn-as-2.0.17-Ubuntu14.amd_64.deb

RUN apt-get update && apt-get install -y wget iptables pwgen && \
    wget ${OPENVPNAS_LATEST} -O openvpn-as.deb  && \
    dpkg -i openvpn-as.deb && \
    rm -f openvpn-as.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    OVPN_PASSWD=$(pwgen -c 32) echo "openvpn:$OVPN_PASSWD" | chpasswd; echo "OpenVPN-AS password: $OVPN_PASSWD"

EXPOSE 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as"]

CMD ["/usr/local/openvpn_as/scripts/openvpnas", "-n"]
