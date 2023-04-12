FROM debian:stable-slim
RUN apt update 
RUN apt install ocserv -y
COPY ocserv.conf /etc/ocserv/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
EXPOSE 443/tcp
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["-f","/dev/null"]