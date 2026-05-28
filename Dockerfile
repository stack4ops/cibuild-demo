FROM docker.io/library/nginx:1.31.0@sha256:800e7c98538c6bf725f5177e841aa720ae0ed1c378bbea368b6330bfe18a36b3

LABEL maintainer="Stefan Schneider <eqsoft4@gmail.com>"

ARG TARGETARCH

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ARG ALL_PROXY
ARG http_proxy=$HTTP_PROXY
ARG https_proxy=$HTTPS_PROXY
ARG no_proxy=$NO_PROXY
ARG all_proxy=$ALL_PROXY

ARG UID=33
ARG GID=33
ARG NGINX_ROOT=/var/www

USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN <<EOF
set -e
apt-get update
apt-get install -y --no-install-recommends \
tzdata
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
sed -i 's/^user.*;$//' /etc/nginx/nginx.conf
mkdir -p ${NGINX_ROOT}
chown -R $UID:$GID ${NGINX_ROOT}
chmod -R g+w ${NGINX_ROOT}
chown -R $UID:$GID /var/cache/nginx
chown -R $UID:$GID /var/log/nginx
chown -R $UID:$GID /etc/nginx/conf.d
touch /var/run/nginx.pid
chown $UID:0 /var
chown $UID:0 /var/run
chown $UID:$GID /var/run/nginx.pid
EOF

# copy ca certs
COPY crt/root-ca.crt /usr/share/ca-certificates/
COPY crt/signing-ca.crt /usr/share/ca-certificates/
RUN <<EOF
set -e
echo root-ca.crt >> /etc/ca-certificates.conf
echo signing-ca.crt >> /etc/ca-certificates.conf
update-ca-certificates
EOF

USER $UID:$GID

STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]