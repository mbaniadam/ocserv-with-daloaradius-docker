FROM debian:stable
RUN apt-get update 
RUN apt-get install ocserv iptables procps -y
COPY ocserv.conf /etc/ocserv/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
#USER root
#RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
RUN echo "radius           secretmor" >> /etc/radcli/servers
EXPOSE 443/tcp
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["-f","/dev/null"]