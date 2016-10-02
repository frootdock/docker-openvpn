# docker-openvpn
OpenVPN Access Server in a Docker container

This is an improved version OpenVPN Access Server container (linuxserver/docker-openvpnas) with more configurable parameters.

## Usage

```
docker create \
--name=docker-openvpn \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-e INTERFACE=<interface> \
--net=host --privileged \
froot/docker-openvpn
```

## Environment Variables**

- COMPANY_NAME - company name to be displayed on login screen
- LOGO_FILE_PATH - logo file path to be displayed on login screen
- ADMIN_PASSWORD - administrator password
- OPENVPN_VER - OpenVPN AS version to be installed
- PUID - user id
- PGID - group id

## User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## OpenVPN Init Default paramters

/root/etc/cont-init.d/40-openvpn-init

1. Please enter 'yes' to indicate your agreement [no]: yes
2. Will this be the primary Access Server node?
(enter 'no' to configure as a backup or standby node) 
]> Press ENTER for default [yes]: 
3. Please specify the network interface and IP address to be
used by the Admin Web UI:
(1) all interfaces: 0.0.0.0
(2) eth0: 10.0.2.15
(3) eth1: 192.168.1.30
(4) docker0: 172.17.0.1
Please enter the option number from the list above (1-4). 
]> Press Enter for default [2]: 1
4. Please specify the port number for the Admin Web UI. 
]> Press ENTER for default [943]:
5. Please specify the TCP port number for the OpenVPN Daemon 
]> Press ENTER for default [443]: 
6. Should client traffic be routed by default through the VPN? 
]> Press ENTER for default [yes]:
7. Should client DNS traffic be routed by default through the VPN? 
]> Press ENTER for default [yes]: 
8. Use local authentication via internal DB? > Press ENTER for default [no]:
9. Private subnets detected: ['10.0.2.0/24', '192.168.1.0/24', '172.17.0.0/16']
Should private subnets be accessible to clients by default? 
]> Press ENTER for default [yes]: 
10. To initially login to the Admin Web UI, you must use a
username and password that successfully authenticates you
with the host UNIX system (you can later modify the settings
so that RADIUS or LDAP is used for authentication instead).
You can login to the Admin Web UI as "openvpn" or specify
a different user account to use for this purpose.
Do you wish to login to the Admin UI as "openvpn"? 
]> Press ENTER for default [yes]: admin
11. ]> Please specify your OpenVPN-AS license key (or leave blank to specify later): 