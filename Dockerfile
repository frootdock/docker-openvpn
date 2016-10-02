FROM lsiobase/xenial
MAINTAINER andreas@froot.io

ENV COMPANY_NAME Froot
ENV ADMIN_PASSWORD password
ENV OPENVPN_VER 2.1.4
ENV LOGO_FILE_PATH /etc/vpn_logo.png
ENV TZ Europe/London
ENV INTERFACE eth0

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# install openvpn-as
RUN \
 apt-get update && \
 apt-get install -y \
	iptables \
	net-tools && \

curl -o \
 /tmp/openvpn.deb -L \
	http://swupdate.openvpn.org/as/openvpn-as-${OPENVPN_VER}-Ubuntu16.amd_64.deb && \
 dpkg -i /tmp/openvpn.deb && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/usr/local/openvpn_as/etc/db/* \
	/usr/local/openvpn_as/etc/sock \
	/usr/local/openvpn_as/etc/tmp \
	/usr/local/openvpn_as/tmp \
	/var/lib/apt/lists/* \
	/var/tmp/*

# ensure abc using /config as home folder
RUN \
 usermod -d /config abc && \

# create admin user and set default password for it
 useradd -s /sbin/nologin admin && \
 echo "admin:${OPENVPN_VER}" | chpasswd && \

# set some config for openvpn-as
 find /usr/local/openvpn_as/scripts -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \
 find /usr/local/openvpn_as/bin -type f -print0 | \
	xargs -0 sed -i 's#/usr/local/openvpn_as#/config#g' && \

 sed -i \
		-e 's#=openvpn_as#=abc#g' \
		-e 's#~/tmp#/openvpn/tmp#g' \
		-e 's#~/sock#/openvpn/sock#g' \
		-e 's#company_name=#${COMPANY_NAME}#g' \
	/usr/local/openvpn_as/etc/as_templ.conf && \

 echo "sa.logo_image_file=${LOGO_FILE_PATH}" >> /usr/local/openvpn_as/etc/as_templ.conf

# add local files
COPY /root /

# ports and volumes
EXPOSE 943/tcp 1194/udp 443/tcp
VOLUME /config
