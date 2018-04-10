#
FROM debian:stretch
# Install some tooling
RUN apt update && apt install wget dumb-init -y
# Install & Configure syslog-ng
RUN apt install syslog-ng-mod-riemann -y
COPY syslog-ng.conf /etc/syslog-ng/conf.d/riemann.conf
# Install & Configure Riemann
RUN apt install openjdk-8-jre-headless -y
RUN wget -nv -O riemann.deb https://github.com/riemann/riemann/releases/download/0.3.0/riemann_0.3.0_all.deb && dpkg -i riemann.deb
COPY riemann.config /etc/riemann/riemann.config
# Install & Configure Caddy Web server
RUN wget -nv -O- https://getcaddy.com | bash -s personal
COPY Caddyfile /etc/
# Expose syslog listener so we can send syslog events to container
EXPOSE 514/udp
# Expose websocket listener so we can subscribe to events
EXPOSE 5556/tcp
# Expose secure websocket listener so we can subscribe to events
EXPOSE 5559/tcp
# Run
COPY start /start
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start"]
