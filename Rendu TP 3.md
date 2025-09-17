# TP3 #
## I. Présentation du lab ##
### 1. Architecture ###
ping kvm1.one
```shell
#commande
[jacques@efrei-xmg4agau1 ~]$ ping kvm1.one

#résultat
PING kvm1.one (10.3.1.11) 56(84) octets de données.
64 octets de kvm1.one (10.3.1.11) : icmp_seq=1 ttl=64 temps=3.23 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=2 ttl=64 temps=1.14 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=3 ttl=64 temps=0.809 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=4 ttl=64 temps=0.778 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=5 ttl=64 temps=2.02 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=6 ttl=64 temps=1.23 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=7 ttl=64 temps=0.979 ms
64 octets de kvm1.one (10.3.1.11) : icmp_seq=8 ttl=64 temps=0.905 ms
^C
--- statistiques ping kvm1.one ---
8 paquets transmis, 8 reçus, 0% packet loss, time 7069ms
rtt min/avg/max/mdev = 0.778/1.385/3.229/0.789 ms
```
ping kvm2.one
```shell
#commande
[jacques@efrei-xmg4agau1 ~]$ ping kvm2.one

#résultat
PING kvm2.one (10.3.1.12) 56(84) octets de données.
64 octets de kvm2.one (10.3.1.12) : icmp_seq=1 ttl=64 temps=1.15 ms
64 octets de kvm2.one (10.3.1.12) : icmp_seq=2 ttl=64 temps=2.68 ms
64 octets de kvm2.one (10.3.1.12) : icmp_seq=3 ttl=64 temps=1.23 ms
64 octets de kvm2.one (10.3.1.12) : icmp_seq=4 ttl=64 temps=1.20 ms
^C
--- statistiques ping kvm2.one ---
4 paquets transmis, 4 reçus, 0% packet loss, time 3007ms
rtt min/avg/max/mdev = 1.153/1.564/2.676/0.642 ms
```
## II. Setup ##
### 1. Frontend ###
#### A. Database ####
Récupération du fichier RPM
```shell
#commande
wget https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm

#résultat
--2025-09-15 13:19:35--  https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
Résolution de dev.mysql.com (dev.mysql.com)… 104.85.37.194, 2a02:26f0:2b80:f95::2e31, 2a02:26f0:2b80:f8d::2e31
Connexion à dev.mysql.com (dev.mysql.com)|104.85.37.194|:443… connecté.
requête HTTP transmise, en attente de la réponse… 302 Moved Temporarily
Emplacement : https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm [suivant]
--2025-09-15 13:19:35--  https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm
Résolution de repo.mysql.com (repo.mysql.com)… 104.85.20.87, 2a02:26f0:2b80:e84::1d68, 2a02:26f0:2b80:e8b::1d68
Connexion à repo.mysql.com (repo.mysql.com)|104.85.20.87|:443… connecté.
requête HTTP transmise, en attente de la réponse… 200 OK
Taille : 13319 (13K) [application/x-redhat-package-manager]
Sauvegarde en : « mysql80-community-release-el9-5.noarch.rpm »

mysql80-community-r 100%[===================>]  13,01K  --.-KB/s    ds 0s

2025-09-15 13:19:35 (390 MB/s) — « mysql80-community-release-el9-5.noarch.rpm » sauvegardé [13319/13319]

[jacques@efrei-xmg4agau1 ~]$
```
Installation du fichier RPM
```shell
#commande
sudo rpm -ivh mysql80-community-release-el9-5.noarch.rpm

#résultat
attention : mysql80-community-release-el9-5.noarch.rpm: Header V4 RSA/SHA256 Signature, clé ID 3a79bd29: NOKEY
Vérification...                      ################################# [100%]
Préparation...                       ################################# [100%]
        paquet mysql80-community-release-el9-5.noarch déjà installé
[jacques@efrei-xmg4agau1 ~]$
```
Vérification du paquet
```shell
#commande
dnf search mysql

#résultat
MySQL 8.0 Community Server                      118 kB/s |  23 kB     00:00
MySQL Connectors Community                      102 kB/s |  19 kB     00:00
MySQL Tools Community                            62 kB/s |  10 kB     00:00
Rocky Linux 10 - BaseOS                         8.6 MB/s |  16 MB     00:01
Rocky Linux 10 - AppStream                      1.6 MB/s | 2.1 MB     00:01
Rocky Linux 10 - Extras                          11 kB/s | 4.9 kB     00:00
====================== Nom & Résumé correspond à : mysql =======================
apr-util-mysql.x86_64 : APR utility library MySQL DBD driver
dovecot-mysql.x86_64 : MySQL back end for dovecot
mysql-community-client.x86_64 : MySQL database client applications and tools
mysql-community-client-plugins.x86_64 : Shared plugins for MySQL client
                                      : applications
mysql-community-common.x86_64 : MySQL database common files for server and
                              : client libs
mysql-community-debugsource.x86_64 : Debug sources for package mysql-community
mysql-community-devel.x86_64 : Development header files and libraries for MySQL
                             : database client applications
mysql-community-icu-data-files.x86_64 : MySQL packaging of ICU data files
mysql-community-libs.x86_64 : Shared libraries for MySQL database client
                            : applications
mysql-community-server-debug.x86_64 : The debug version of MySQL server
mysql-community-test.x86_64 : Test suite for the MySQL database server
mysql-connector-c++.x86_64 : MySQL database connector for C++
mysql-connector-c++-compat.x86_64 : MySQL Connector/C++ -- backward
                                  : compatibility libraries
mysql-connector-c++-debugsource.x86_64 : Debug sources for package
                                       : mysql-connector-c++
mysql-connector-c++-devel.x86_64 : Development header files and libraries for
                                 : MySQL C++ client applications
mysql-connector-c++-jdbc.x86_64 : MySQL Driver for C++ which mimics the JDBC 4.0
                                : API
mysql-connector-j.noarch : Standardized MySQL database driver for Java
mysql-connector-odbc.x86_64 : An ODBC 9.4 driver for MySQL - driver package
mysql-connector-odbc-debugsource.x86_64 : Debug sources for package
                                        : mysql-connector-odbc
mysql-connector-odbc-setup.x86_64 : An ODBC 9.4 driver for MySQL - setup library
mysql-connector-python3.x86_64 : Standardized MySQL database driver for Python 3
mysql-ref-manual-8.0-en-html-chapter.noarch : The MySQL Reference Manual (HTML,
                                            : English)
mysql-ref-manual-8.0-en-pdf.noarch : The MySQL Reference Manual (PDF, English)
mysql-router-community.x86_64 : MySQL Router
mysql-selinux.noarch : SELinux policy modules for MySQL and MariaDB packages
mysql-shell.x86_64 : Command line shell and scripting environment for MySQL
mysql-shell-debugsource.x86_64 : Debug sources for package mysql-shell
mysql-workbench-community.x86_64 : A MySQL visual database modeling,
     ...: administration, development and migration tool
mysql8.4.x86_64 : MySQL client programs and shared libraries
mysql8.4-common.noarch : The shared files required for MySQL server and client
mysql8.4-errmsg.noarch : The error messages files required by MySQL server
mysql8.4-libs.x86_64 : The shared libraries required for MySQL clients
mysql8.4-server.x86_64 : The MySQL server and related files
mysql80-community-release.noarch : MySQL repository configuration for yum
mysqlx-connector-python3.x86_64 : Standardized MySQL database driver for Python
                                : 3
pcp-pmda-mysql.x86_64 : Performance Co-Pilot (PCP) metrics for MySQL
perl-DBD-MySQL.x86_64 : A MySQL interface for Perl
php-mysqlnd.x86_64 : A module for PHP applications that use MySQL databases
postfix-mysql.x86_64 : Postfix MySQL map support
python3-PyMySQL.noarch : Pure-Python MySQL client library
qt6-qtbase-mysql.x86_64 : MySQL driver for Qt6's SQL classes
rsyslog-mysql.x86_64 : MySQL support for rsyslog
rubygem-mysql2.x86_64 : A simple, fast Mysql library for Ruby, binding to
                      : libmysql
=========================== Nom correspond à : mysql ===========================
mysql-community-server.x86_64 : A very fast and reliable SQL database server
========================= Résumé correspond à : mysql ==========================
mariadb-client-utils.x86_64 : Non-essential client utilities for MariaDB/MySQL
                            : applications
mariadb-devel.x86_64 : Files for development of MariaDB/MySQL applications
mariadb-java-client.noarch : Connects applications developed in Java to MariaDB
                           : and MySQL databases
mariadb-server-utils.x86_64 : Non-essential server utilities for MariaDB/MySQL
                            : applications
perl-DBD-MariaDB.x86_64 : MariaDB and MySQL driver for the Perl5 Database
                        : Interface (DBI)
[jacques@efrei-xmg4agau1 ~]$

```
Installation du paquet
```shell
#commande
sudo dnf install mysql-community-server

#résultat
MySQL 8.0 Community Server                      117 kB/s |  23 kB     00:00
MySQL Connectors Community                       98 kB/s |  19 kB     00:00
MySQL Tools Community                            61 kB/s |  10 kB     00:00
Dépendances résolues.
================================================================================
 Paquet                          Architecture
                                         Version       Dépôt              Taille
================================================================================
Installation:
 mysql-community-server          x86_64  8.0.43-1.el9  mysql80-community   50 M
Installation des dépendances:
 mysql-community-client          x86_64  8.0.43-1.el9  mysql80-community  3.3 M
 mysql-community-client-plugins  x86_64  8.0.43-1.el9  mysql80-community  1.4 M
 mysql-community-common          x86_64  8.0.43-1.el9  mysql80-community  556 k
 mysql-community-icu-data-files  x86_64  8.0.43-1.el9  mysql80-community  2.3 M
 mysql-community-libs            x86_64  8.0.43-1.el9  mysql80-community  1.5 M

Résumé de la transaction
================================================================================
Installer  6 Paquets

Taille totale des téléchargements : 59 M
Taille des paquets installés : 337 M
Voulez-vous continuer ? [o/N] : o
Téléchargement des paquets :
(1/6): mysql-community-common-8.0.43-1.el9.x86_ 1.2 MB/s | 556 kB     00:00
(2/6): mysql-community-client-plugins-8.0.43-1. 3.0 MB/s | 1.4 MB     00:00
(3/6): mysql-community-libs-8.0.43-1.el9.x86_64 3.0 MB/s | 1.5 MB     00:00
(4/6): mysql-community-icu-data-files-8.0.43-1. 3.2 MB/s | 2.3 MB     00:00
(5/6): mysql-community-client-8.0.43-1.el9.x86_ 2.4 MB/s | 3.3 MB     00:01
(6/6): mysql-community-server-8.0.43-1.el9.x86_  16 MB/s |  50 MB     00:03
--------------------------------------------------------------------------------
Total                                            14 MB/s |  59 MB     00:04
MySQL 8.0 Community Server                      1.7 MB/s | 3.1 kB     00:00
Import de la clef GPG 0xA8D3785C :
Utilisateur : « MySQL Release Engineering <mysql-build@oss.oracle.com> »
Empreinte : BCA4 3417 C3B4 85DD 128E C6D4 B7B3 B788 A8D3 785C
Provenance : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2023
Voulez-vous continuer ? [o/N] : o
La clé a bien été importée
MySQL 8.0 Community Server                      2.6 MB/s | 3.1 kB     00:00
Import de la clef GPG 0x3A79BD29 :
Utilisateur : « MySQL Release Engineering <mysql-build@oss.oracle.com> »
Empreinte : 859B E8D7 C586 F538 430B 19C2 467B 942D 3A79 BD29
Provenance : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
Voulez-vous continuer ? [o/N] : o
attention : Certificate 467B942D3A79BD29:
  The certificate is expired: The primary key is not live
  Subkey 467B942D3A79BD29 is expired: The primary key is not live
  Certificate does not have any usable signing keys
La clé a bien été importée
Test de la transaction
La vérification de la transaction a réussi.
Lancement de la transaction de test
Transaction de test réussie.
Exécution de la transaction
  Préparation           :                                                   1/1
  Installation          : mysql-community-common-8.0.43-1.el9.x86_64        1/6
  Installation          : mysql-community-client-plugins-8.0.43-1.el9.x86   2/6
  Installation          : mysql-community-libs-8.0.43-1.el9.x86_64          3/6
  Exécution du scriptlet: mysql-community-libs-8.0.43-1.el9.x86_64          3/6
  Installation          : mysql-community-client-8.0.43-1.el9.x86_64        4/6
  Installation          : mysql-community-icu-data-files-8.0.43-1.el9.x86   5/6
  Exécution du scriptlet: mysql-community-server-8.0.43-1.el9.x86_64        6/6
  Installation          : mysql-community-server-8.0.43-1.el9.x86_64        6/6
  Exécution du scriptlet: mysql-community-server-8.0.43-1.el9.x86_64        6/6

Installé:
  mysql-community-client-8.0.43-1.el9.x86_64
  mysql-community-client-plugins-8.0.43-1.el9.x86_64
  mysql-community-common-8.0.43-1.el9.x86_64
  mysql-community-icu-data-files-8.0.43-1.el9.x86_64
  mysql-community-libs-8.0.43-1.el9.x86_64
  mysql-community-server-8.0.43-1.el9.x86_64

Terminé !
[jacques@efrei-xmg4agau1 ~]$
```
Démarrer le serveur MySQL au démarrage
```shell
#commande
sudo systemctl enable mysqld
sudo systemctl start mysqld
```
Setup MySQL

Récupération du MDP
```shell
#commande
sudo cat /var/log/mysqld.log

#résultat
2025-09-15T14:20:54.010831Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.43) initializing of server in progress as process 86469
2025-09-15T14:20:54.043125Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-09-15T14:20:56.222123Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-09-15T14:21:01.935256Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: vs_ualagb0Lx
2025-09-15T14:21:16.054825Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.43) starting as process 86624
2025-09-15T14:21:16.092078Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-09-15T14:21:18.851226Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-09-15T14:21:20.084046Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2025-09-15T14:21:20.084102Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2025-09-15T14:21:20.176489Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
2025-09-15T14:21:20.176849Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.43'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server - GPL.
```
MDP root mysql : vs_ualagb0Lx

Connexion et modification base MySQL
```shell
#commande
sudo mysql --user=root --password

#résultat
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 14
Server version: 8.0.43

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```
Commande MySQL
```sql
#commande
ALTER USER 'root'@'localhost' IDENTIFIED BY 'A_Very_Str0ng_P@ssw0rd';
CREATE USER 'oneadmin' IDENTIFIED BY 'Another_Very_Str0ng_P@ssw0rd';
CREATE DATABASE opennebula;
GRANT ALL PRIVILEGES ON opennebula.* TO 'oneadmin';
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;

#résultat
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'A_Very_Str0ng_P@ssw0rd';
Query OK, 0 rows affected (0,06 sec)

mysql> CREATE USER 'oneadmin' IDENTIFIED BY 'Another_Very_Str0ng_P@ssw0rd';
Query OK, 0 rows affected (0,14 sec)

mysql> CREATE DATABASE opennebula;
Query OK, 1 row affected (0,04 sec)

mysql> GRANT ALL PRIVILEGES ON opennebula.* TO 'oneadmin';
Query OK, 0 rows affected (0,02 sec)

mysql> SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
Query OK, 0 rows affected (0,00 sec)

mysql>
```
#### B. OpenNebula ####
 Ajouter les dépôts Open Nebula
```shell
#Création fichier repo
sudo vi /etc/yum.repos.d/opennebula.repo
```
Contenu du fichier
```bash
[opennebula]
name=OpenNebula Community Edition
baseurl=https://downloads.opennebula.io/repo/6.10/RedHat/$releasever/$basearch
enabled=1
gpgkey=https://downloads.opennebula.io/repo/repo2.key
gpgcheck=1
repo_gpgcheck=1
```
Installation d'OpenNebula

```shell
#commande
sudo dnf install opennebula opennebula-sunstone opennebula-fireedge

#résultat
OpenNebula Community Edition                                                                                                  1.9 kB/s | 833  B     00:00
OpenNebula Community Edition                                                                                                   23 kB/s | 3.1 kB     00:00
Importing GPG key 0x906DC27C:
 Userid     : "OpenNebula Repository <contact@opennebula.io>"
 Fingerprint: 0B2D 385C 7C93 04B1 1A03 67B9 05A0 5927 906D C27C
 From       : https://downloads.opennebula.io/repo/repo2.key
Is this ok [y/N]: y
OpenNebula Community Edition                                                                                                  1.2 MB/s | 690 kB     00:00
Last metadata expiration check: 0:00:01 ago on Mon 15 Sep 2025 10:23:24 AM EDT.
Dependencies resolved.
==============================================================================================================================================================
 Package                                    Architecture            Version                                                 Repository                   Size
==============================================================================================================================================================
Installing:
 opennebula                                 x86_64                  6.10.0.1-1.el9                                          opennebula                   10 M
 opennebula-fireedge                        x86_64                  6.10.0.1-1.el9                                          opennebula                   46 M
 opennebula-sunstone                        noarch                  6.10.0.1-1.el9                                          opennebula                   29 M
Installing dependencies:
 alsa-lib                                   x86_64                  1.2.13-2.el9                                            appstream                   506 k
 augeas-libs                                x86_64                  1.14.1-2.el9                                            appstream                   373 k
 avahi-libs                                 x86_64                  0.8-22.el9_6.1                                          baseos                       66 k
 cairo                                      x86_64                  1.17.4-7.el9                                            appstream                   659 k
 cups-libs                                  x86_64                  1:2.3.3op2-33.el9                                       baseos                      261 k
 emacs-filesystem                           noarch                  1:27.2-14.el9_6.2                                       appstream                   7.9 k
 flac-libs                                  x86_64                  1.3.3-10.el9_2.1                                        appstream                   217 k
 flexiblas                                  x86_64                  3.0.4-8.el9.0.1                                         appstream                    30 k
 flexiblas-netlib                           x86_64                  3.0.4-8.el9.0.1                                         appstream                   3.0 M
 flexiblas-openblas-openmp                  x86_64                  3.0.4-8.el9.0.1                                         appstream                    15 k
 fontconfig                                 x86_64                  2.14.0-2.el9_1                                          appstream                   274 k
 freerdp-libs                               x86_64                  2:2.11.7-1.el9                                          appstream                   900 k
 fribidi                                    x86_64                  1.0.10-6.el9.2                                          appstream                    84 k
 gd                                         x86_64                  2.3.2-3.el9                                             appstream                   131 k
 genisoimage                                x86_64                  1.1.11-48.el9                                           epel                        324 k
 git                                        x86_64                  2.47.3-1.el9_6                                          appstream                    50 k
 git-core                                   x86_64                  2.47.3-1.el9_6                                          appstream                   4.6 M
 git-core-doc                               noarch                  2.47.3-1.el9_6                                          appstream                   2.8 M
 glx-utils                                  x86_64                  8.4.0-12.20210504git0f9e7d9.el9.0.1                     appstream                    40 k
 gnuplot-common                             x86_64                  5.4.3-2.el9                                             epel                        776 k
 gsm                                        x86_64                  1.0.19-6.el9                                            appstream                    33 k
 jbigkit-libs                               x86_64                  2.1-23.el9                                              appstream                    52 k
 keyutils-libs-devel                        x86_64                  1.6.3-1.el9                                             appstream                    54 k
 krb5-devel                                 x86_64                  1.21.1-8.el9_6                                          appstream                   132 k
 lame-libs                                  x86_64                  3.100-12.el9                                            appstream                   332 k
 libICE                                     x86_64                  1.0.10-8.el9                                            appstream                    70 k
 libSM                                      x86_64                  1.2.3-10.el9                                            appstream                    41 k
 libX11                                     x86_64                  1.7.0-11.el9                                            appstream                   645 k
 libX11-common                              noarch                  1.7.0-11.el9                                            appstream                   151 k
 libX11-xcb                                 x86_64                  1.7.0-11.el9                                            appstream                    10 k
 libXau                                     x86_64                  1.0.9-8.el9                                             appstream                    30 k
 libXext                                    x86_64                  1.3.4-8.el9                                             appstream                    39 k
 libXfixes                                  x86_64                  5.0.3-16.el9                                            appstream                    19 k
 libXft                                     x86_64                  2.3.3-8.el9                                             appstream                    61 k
 libXpm                                     x86_64                  3.5.13-10.el9                                           appstream                    58 k
 libXrender                                 x86_64                  0.9.10-16.el9                                           appstream                    27 k
 libXxf86vm                                 x86_64                  1.1.4-18.el9                                            appstream                    18 k
 libasyncns                                 x86_64                  0.8-22.el9                                              appstream                    29 k
 libcerf                                    x86_64                  1.17-2.el9                                              epel                         38 k
 libcom_err-devel                           x86_64                  1.46.5-7.el9                                            appstream                    15 k
 libdrm                                     x86_64                  2.4.123-2.el9                                           appstream                   158 k
 libevdev                                   x86_64                  1.11.0-3.el9                                            appstream                    45 k
 libgfortran                                x86_64                  11.5.0-5.el9_5                                          baseos                      797 k
 libglvnd                                   x86_64                  1:1.3.4-1.el9                                           appstream                   133 k
 libglvnd-egl                               x86_64                  1:1.3.4-1.el9                                           appstream                    36 k
 libglvnd-glx                               x86_64                  1:1.3.4-1.el9                                           appstream                   140 k
 libgudev                                   x86_64                  237-1.el9                                               baseos                       35 k
 libicu                                     x86_64                  67.1-10.el9_6                                           baseos                      9.6 M
 libinput                                   x86_64                  1.19.3-5.el9_6                                          appstream                   193 k
 libjpeg-turbo                              x86_64                  2.0.90-7.el9                                            appstream                   174 k
 libkadm5                                   x86_64                  1.21.1-8.el9_6                                          baseos                       75 k
 libogg                                     x86_64                  2:1.3.4-6.el9                                           appstream                    32 k
 libpciaccess                               x86_64                  0.16-7.el9                                              baseos                       26 k
 libproxy                                   x86_64                  0.4.15-35.el9                                           baseos                       73 k
 libquadmath                                x86_64                  11.5.0-5.el9_5                                          baseos                      187 k
 libselinux-devel                           x86_64                  3.6-3.el9                                               appstream                   113 k
 libsepol-devel                             x86_64                  3.6-2.el9                                               appstream                    39 k
 libsndfile                                 x86_64                  1.0.31-9.el9                                            appstream                   205 k
 libsodium                                  x86_64                  1.0.18-8.el9                                            epel                        161 k
 libsodium-devel                            x86_64                  1.0.18-8.el9                                            epel                        1.0 M
 libssh2                                    x86_64                  1.11.0-1.el9                                            epel                        132 k
 libtiff                                    x86_64                  4.4.0-13.el9                                            appstream                   197 k
 libunwind                                  x86_64                  1.6.2-1.el9                                             epel                         67 k
 libunwind-devel                            x86_64                  1.6.2-1.el9                                             epel                         80 k
 liburing                                   x86_64                  2.5-1.el9                                               appstream                    38 k
 libusal                                    x86_64                  1.1.11-48.el9                                           epel                        137 k
 libusbx                                    x86_64                  1.0.26-1.el9                                            baseos                       75 k
 libverto-devel                             x86_64                  0.3.2-3.el9                                             appstream                    14 k
 libvncserver                               x86_64                  0.9.13-11.el9                                           epel                        296 k
 libvorbis                                  x86_64                  1:1.3.7-5.el9                                           appstream                   192 k
 libwacom                                   x86_64                  1.12.1-3.el9_4                                          appstream                    43 k
 libwacom-data                              noarch                  1.12.1-3.el9_4                                          appstream                   105 k
 libwayland-client                          x86_64                  1.21.0-1.el9                                            appstream                    33 k
 libwayland-cursor                          x86_64                  1.21.0-1.el9                                            appstream                    18 k
 libwayland-server                          x86_64                  1.21.0-1.el9                                            appstream                    41 k
 libwebp                                    x86_64                  1.2.0-8.el9                                             appstream                   276 k
 libwinpr                                   x86_64                  2:2.11.7-1.el9                                          appstream                   356 k
 libxcb                                     x86_64                  1.13.1-9.el9                                            appstream                   224 k
 libxkbcommon                               x86_64                  1.0.3-4.el9                                             appstream                   132 k
 libxkbcommon-x11                           x86_64                  1.0.3-4.el9                                             appstream                    21 k
 libxkbfile                                 x86_64                  1.1.0-8.el9                                             appstream                    88 k
 libxshmfence                               x86_64                  1.3-10.el9                                              appstream                    12 k
 libxslt                                    x86_64                  1.1.34-13.el9_6                                         appstream                   239 k
 mesa-dri-drivers                           x86_64                  24.2.8-2.el9_6                                          appstream                   9.4 M
 mesa-filesystem                            x86_64                  24.2.8-2.el9_6                                          appstream                    11 k
 mesa-libEGL                                x86_64                  24.2.8-2.el9_6                                          appstream                   141 k
 mesa-libGL                                 x86_64                  24.2.8-2.el9_6                                          appstream                   169 k
 mesa-libgbm                                x86_64                  24.2.8-2.el9_6                                          appstream                    36 k
 mesa-libglapi                              x86_64                  24.2.8-2.el9_6                                          appstream                    44 k
 mtdev                                      x86_64                  1.1.5-22.el9                                            appstream                    21 k
 nodejs                                     x86_64                  1:16.20.2-8.el9_4                                       appstream                   111 k
 nodejs-libs                                x86_64                  1:16.20.2-8.el9_4                                       appstream                    15 M
 openblas                                   x86_64                  0.3.26-2.el9                                            appstream                    37 k
 openblas-openmp                            x86_64                  0.3.26-2.el9                                            appstream                   4.9 M
 opennebula-common                          noarch                  6.10.0.1-1.el9                                          opennebula                   23 k
 opennebula-common-onecfg                   noarch                  6.10.0.1-1.el9                                          opennebula                  9.1 k
 opennebula-libs                            noarch                  6.10.0.1-1.el9                                          opennebula                  202 k
 opennebula-provision-data                  noarch                  6.10.0.1-1.el9                                          opennebula                   52 k
 opennebula-rubygems                        x86_64                  6.10.0.1-1.el9                                          opennebula                   16 M
 opennebula-tools                           noarch                  6.10.0.1-1.el9                                          opennebula                  191 k
 openpgm                                    x86_64                  5.2.122-28.el9                                          epel                        176 k
 openpgm-devel                              x86_64                  5.2.122-28.el9                                          epel                         58 k
 opus                                       x86_64                  1.3.1-10.el9                                            appstream                   199 k
 pango                                      x86_64                  1.48.7-3.el9                                            appstream                   297 k
 pcre2-devel                                x86_64                  10.40-6.el9                                             appstream                   471 k
 pcre2-utf16                                x86_64                  10.40-6.el9                                             appstream                   213 k
 pcre2-utf32                                x86_64                  10.40-6.el9                                             appstream                   202 k
 perl-Error                                 noarch                  1:0.17029-7.el9                                         appstream                    41 k
 perl-Git                                   noarch                  2.47.3-1.el9_6                                          appstream                    37 k
 pixman                                     x86_64                  0.40.0-6.el9_3                                          appstream                   269 k
 pulseaudio-libs                            x86_64                  15.0-3.el9                                              appstream                   663 k
 python3-numpy                              x86_64                  1:1.23.5-1.el9                                          appstream                   5.8 M
 qemu-img                                   x86_64                  17:9.1.0-15.el9_6.7                                     appstream                   2.5 M
 qt5-qtbase                                 x86_64                  5.15.9-11.el9_6                                         appstream                   3.5 M
 qt5-qtbase-common                          noarch                  5.15.9-11.el9_6                                         appstream                   7.6 k
 qt5-qtbase-gui                             x86_64                  5.15.9-11.el9_6                                         appstream                   6.3 M
 qt5-qtsvg                                  x86_64                  5.15.9-2.el9                                            appstream                   184 k
 rsync                                      x86_64                  3.2.5-3.el9                                             baseos                      403 k
 ruby                                       x86_64                  3.0.7-165.el9_5                                         appstream                    38 k
 ruby-libs                                  x86_64                  3.0.7-165.el9_5                                         appstream                   3.2 M
 rubygem-bigdecimal                         x86_64                  3.0.0-165.el9_5                                         appstream                    52 k
 rubygem-io-console                         x86_64                  0.5.7-165.el9_5                                         appstream                    23 k
 rubygem-json                               x86_64                  2.5.1-165.el9_5                                         appstream                    51 k
 rubygem-psych                              x86_64                  3.3.2-165.el9_5                                         appstream                    48 k
 rubygem-rexml                              noarch                  3.2.5-165.el9_5                                         appstream                    92 k
 rubygems                                   noarch                  3.2.33-165.el9_5                                        appstream                   253 k
 sqlite                                     x86_64                  3.34.1-8.el9_6                                          appstream                   746 k
 uuid                                       x86_64                  1.6.2-55.el9                                            appstream                    56 k
 xcb-util                                   x86_64                  0.4.0-19.el9                                            appstream                    18 k
 xcb-util-image                             x86_64                  0.4.0-19.el9.0.1                                        appstream                    18 k
 xcb-util-keysyms                           x86_64                  0.4.0-17.el9                                            appstream                    14 k
 xcb-util-renderutil                        x86_64                  0.3.9-20.el9.0.1                                        appstream                    16 k
 xcb-util-wm                                x86_64                  0.4.1-22.el9                                            appstream                    31 k
 xkeyboard-config                           noarch                  2.33-2.el9                                              appstream                   779 k
 xml-common                                 noarch                  0.6.3-58.el9                                            appstream                    31 k
 xmlrpc-c                                   x86_64                  1.51.0-16.el9                                           appstream                   140 k
 zeromq                                     x86_64                  4.3.4-2.el9                                             epel                        431 k
 zeromq-devel                               x86_64                  4.3.4-2.el9                                             epel                         16 k
Installing weak dependencies:
 bash-completion                            noarch                  1:2.11-5.el9                                            baseos                      291 k
 gnuplot                                    x86_64                  5.4.3-2.el9                                             epel                        820 k
 nodejs-docs                                noarch                  1:16.20.2-8.el9_4                                       appstream                   7.1 M
 nodejs-full-i18n                           x86_64                  1:16.20.2-8.el9_4                                       appstream                   8.2 M
 npm                                        x86_64                  1:8.19.4-1.16.20.2.8.el9_4                              appstream                   1.7 M
 opennebula-guacd                           x86_64                  6.10.0.1-1.2.0+1.el9                                    opennebula                  220 k
 ruby-default-gems                          noarch                  3.0.7-165.el9_5                                         appstream                    30 k
 rubygem-bundler                            noarch                  2.2.33-165.el9_5                                        appstream                   370 k
 rubygem-rdoc                               noarch                  6.3.4.1-165.el9_5                                       appstream                   398 k

Transaction Summary
==============================================================================================================================================================
Install  150 Packages

Total download size: 209 M
Installed size: 1.1 G
Is this ok [y/N]: y
Downloading Packages:
(1/150): gnuplot-5.4.3-2.el9.x86_64.rpm                                                                                       2.1 MB/s | 820 kB     00:00
(2/150): genisoimage-1.1.11-48.el9.x86_64.rpm                                                                                 680 kB/s | 324 kB     00:00
(3/150): libcerf-1.17-2.el9.x86_64.rpm                                                                                        377 kB/s |  38 kB     00:00
(4/150): gnuplot-common-5.4.3-2.el9.x86_64.rpm                                                                                1.3 MB/s | 776 kB     00:00
(5/150): libsodium-1.0.18-8.el9.x86_64.rpm                                                                                    1.3 MB/s | 161 kB     00:00
(6/150): libunwind-1.6.2-1.el9.x86_64.rpm                                                                                     608 kB/s |  67 kB     00:00
(7/150): libssh2-1.11.0-1.el9.x86_64.rpm                                                                                      324 kB/s | 132 kB     00:00
(8/150): libunwind-devel-1.6.2-1.el9.x86_64.rpm                                                                               262 kB/s |  80 kB     00:00
(9/150): libsodium-devel-1.0.18-8.el9.x86_64.rpm                                                                              1.7 MB/s | 1.0 MB     00:00
(10/150): libusal-1.1.11-48.el9.x86_64.rpm                                                                                    1.1 MB/s | 137 kB     00:00
(11/150): openpgm-5.2.122-28.el9.x86_64.rpm                                                                                   1.6 MB/s | 176 kB     00:00
(12/150): libvncserver-0.9.13-11.el9.x86_64.rpm                                                                               1.6 MB/s | 296 kB     00:00
(13/150): zeromq-devel-4.3.4-2.el9.x86_64.rpm                                                                                 168 kB/s |  16 kB     00:00
(14/150): openpgm-devel-5.2.122-28.el9.x86_64.rpm                                                                             289 kB/s |  58 kB     00:00
(15/150): opennebula-common-6.10.0.1-1.el9.noarch.rpm                                                                         154 kB/s |  23 kB     00:00
(16/150): opennebula-common-onecfg-6.10.0.1-1.el9.noarch.rpm                                                                  188 kB/s | 9.1 kB     00:00
(17/150): zeromq-4.3.4-2.el9.x86_64.rpm                                                                                       585 kB/s | 431 kB     00:00
(18/150): opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64.rpm                                                                    945 kB/s | 220 kB     00:00
(19/150): opennebula-libs-6.10.0.1-1.el9.noarch.rpm                                                                           1.7 MB/s | 202 kB     00:00
(20/150): opennebula-provision-data-6.10.0.1-1.el9.noarch.rpm                                                                 857 kB/s |  52 kB     00:00
(21/150): opennebula-rubygems-6.10.0.1-1.el9.x86_64.rpm                                                                       1.6 MB/s |  16 MB     00:09
(22/150): opennebula-6.10.0.1-1.el9.x86_64.rpm                                                                                860 kB/s |  10 MB     00:11
(23/150): opennebula-tools-6.10.0.1-1.el9.noarch.rpm                                                                          163 kB/s | 191 kB     00:01
(24/150): libicu-67.1-10.el9_6.x86_64.rpm                                                                                     1.9 MB/s | 9.6 MB     00:05
(25/150): cups-libs-2.3.3op2-33.el9.x86_64.rpm                                                                                792 kB/s | 261 kB     00:00
(26/150): bash-completion-2.11-5.el9.noarch.rpm                                                                               209 kB/s | 291 kB     00:01
(27/150): avahi-libs-0.8-22.el9_6.1.x86_64.rpm                                                                                376 kB/s |  66 kB     00:00
(28/150): libpciaccess-0.16-7.el9.x86_64.rpm                                                                                  324 kB/s |  26 kB     00:00
(29/150): libquadmath-11.5.0-5.el9_5.x86_64.rpm                                                                               1.0 MB/s | 187 kB     00:00
(30/150): libproxy-0.4.15-35.el9.x86_64.rpm                                                                                   667 kB/s |  73 kB     00:00
(31/150): libgudev-237-1.el9.x86_64.rpm                                                                                       303 kB/s |  35 kB     00:00
(32/150): rsync-3.2.5-3.el9.x86_64.rpm                                                                                        1.1 MB/s | 403 kB     00:00
(33/150): libgfortran-11.5.0-5.el9_5.x86_64.rpm                                                                               2.0 MB/s | 797 kB     00:00
(34/150): libkadm5-1.21.1-8.el9_6.x86_64.rpm                                                                                  557 kB/s |  75 kB     00:00
(35/150): libusbx-1.0.26-1.el9.x86_64.rpm                                                                                     487 kB/s |  75 kB     00:00
(36/150): flac-libs-1.3.3-10.el9_2.1.x86_64.rpm                                                                               634 kB/s | 217 kB     00:00
(37/150): rubygem-json-2.5.1-165.el9_5.x86_64.rpm                                                                             968 kB/s |  51 kB     00:00
(38/150): flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64.rpm                                                                277 kB/s |  15 kB     00:00
(39/150): libwinpr-2.11.7-1.el9.x86_64.rpm                                                                                    2.9 MB/s | 356 kB     00:00
(40/150): libXxf86vm-1.1.4-18.el9.x86_64.rpm                                                                                  322 kB/s |  18 kB     00:00
(41/150): libXpm-3.5.13-10.el9.x86_64.rpm                                                                                     755 kB/s |  58 kB     00:00
(42/150): nodejs-docs-16.20.2-8.el9_4.noarch.rpm                                                                              6.3 MB/s | 7.1 MB     00:01
(43/150): libglvnd-1.3.4-1.el9.x86_64.rpm                                                                                     1.6 MB/s | 133 kB     00:00
(44/150): libtiff-4.4.0-13.el9.x86_64.rpm                                                                                     2.5 MB/s | 197 kB     00:00
(45/150): libwayland-client-1.21.0-1.el9.x86_64.rpm                                                                           623 kB/s |  33 kB     00:00
(46/150): libselinux-devel-3.6-3.el9.x86_64.rpm                                                                               1.8 MB/s | 113 kB     00:00
(47/150): rubygem-bundler-2.2.33-165.el9_5.noarch.rpm                                                                         3.5 MB/s | 370 kB     00:00
(48/150): keyutils-libs-devel-1.6.3-1.el9.x86_64.rpm                                                                          987 kB/s |  54 kB     00:00
(49/150): libXrender-0.9.10-16.el9.x86_64.rpm                                                                                 520 kB/s |  27 kB     00:00
(50/150): qt5-qtbase-common-5.15.9-11.el9_6.noarch.rpm                                                                        149 kB/s | 7.6 kB     00:00
(51/150): nodejs-libs-16.20.2-8.el9_4.x86_64.rpm                                                                              4.1 MB/s |  15 MB     00:03
(52/150): libwebp-1.2.0-8.el9.x86_64.rpm                                                                                      1.7 MB/s | 276 kB     00:00
(53/150): xcb-util-wm-0.4.1-22.el9.x86_64.rpm                                                                                 271 kB/s |  31 kB     00:00
(54/150): python3-numpy-1.23.5-1.el9.x86_64.rpm                                                                               6.2 MB/s | 5.8 MB     00:00
(55/150): libX11-common-1.7.0-11.el9.noarch.rpm                                                                               2.2 MB/s | 151 kB     00:00
(56/150): jbigkit-libs-2.1-23.el9.x86_64.rpm                                                                                  835 kB/s |  52 kB     00:00
(57/150): pcre2-utf16-10.40-6.el9.x86_64.rpm                                                                                  2.7 MB/s | 213 kB     00:00
(58/150): libverto-devel-0.3.2-3.el9.x86_64.rpm                                                                               186 kB/s |  14 kB     00:00
(59/150): libXau-1.0.9-8.el9.x86_64.rpm                                                                                       614 kB/s |  30 kB     00:00
(60/150): mesa-libGL-24.2.8-2.el9_6.x86_64.rpm                                                                                2.3 MB/s | 169 kB     00:00
(61/150): augeas-libs-1.14.1-2.el9.x86_64.rpm                                                                                 3.4 MB/s | 373 kB     00:00
(62/150): xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64.rpm                                                                     226 kB/s |  16 kB     00:00
(63/150): mesa-libglapi-24.2.8-2.el9_6.x86_64.rpm                                                                             718 kB/s |  44 kB     00:00
(64/150): ruby-3.0.7-165.el9_5.x86_64.rpm                                                                                     722 kB/s |  38 kB     00:00
(65/150): liburing-2.5-1.el9.x86_64.rpm                                                                                       553 kB/s |  38 kB     00:00
(66/150): libinput-1.19.3-5.el9_6.x86_64.rpm                                                                                  2.3 MB/s | 193 kB     00:00
(67/150): libXext-1.3.4-8.el9.x86_64.rpm                                                                                      638 kB/s |  39 kB     00:00
(68/150): xml-common-0.6.3-58.el9.noarch.rpm                                                                                  592 kB/s |  31 kB     00:00
(69/150): glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64.rpm                                                            541 kB/s |  40 kB     00:00
(70/150): libxshmfence-1.3-10.el9.x86_64.rpm                                                                                  222 kB/s |  12 kB     00:00
(71/150): rubygem-rdoc-6.3.4.1-165.el9_5.noarch.rpm                                                                           3.5 MB/s | 398 kB     00:00
(72/150): openblas-openmp-0.3.26-2.el9.x86_64.rpm                                                                             6.1 MB/s | 4.9 MB     00:00
(73/150): flexiblas-3.0.4-8.el9.0.1.x86_64.rpm                                                                                478 kB/s |  30 kB     00:00
(74/150): flexiblas-netlib-3.0.4-8.el9.0.1.x86_64.rpm                                                                         2.7 MB/s | 3.0 MB     00:01
(75/150): libX11-xcb-1.7.0-11.el9.x86_64.rpm                                                                                  204 kB/s |  10 kB     00:00
(76/150): mesa-libgbm-24.2.8-2.el9_6.x86_64.rpm                                                                               570 kB/s |  36 kB     00:00
(77/150): libglvnd-glx-1.3.4-1.el9.x86_64.rpm                                                                                 2.0 MB/s | 140 kB     00:00
(78/150): libwayland-cursor-1.21.0-1.el9.x86_64.rpm                                                                           339 kB/s |  18 kB     00:00
(79/150): nodejs-full-i18n-16.20.2-8.el9_4.x86_64.rpm                                                                         5.0 MB/s | 8.2 MB     00:01
(80/150): openblas-0.3.26-2.el9.x86_64.rpm                                                                                    595 kB/s |  37 kB     00:00
(81/150): npm-8.19.4-1.16.20.2.8.el9_4.x86_64.rpm                                                                             4.0 MB/s | 1.7 MB     00:00
(82/150): xkeyboard-config-2.33-2.el9.noarch.rpm                                                                              3.4 MB/s | 779 kB     00:00
(83/150): krb5-devel-1.21.1-8.el9_6.x86_64.rpm                                                                                1.0 MB/s | 132 kB     00:00
(84/150): pcre2-devel-10.40-6.el9.x86_64.rpm                                                                                  3.4 MB/s | 471 kB     00:00
(85/150): libglvnd-egl-1.3.4-1.el9.x86_64.rpm                                                                                 589 kB/s |  36 kB     00:00
(86/150): git-core-doc-2.47.3-1.el9_6.noarch.rpm                                                                              2.3 MB/s | 2.8 MB     00:01
(87/150): freerdp-libs-2.11.7-1.el9.x86_64.rpm                                                                                3.7 MB/s | 900 kB     00:00
(88/150): libevdev-1.11.0-3.el9.x86_64.rpm                                                                                    482 kB/s |  45 kB     00:00
(89/150): emacs-filesystem-27.2-14.el9_6.2.noarch.rpm                                                                         130 kB/s | 7.9 kB     00:00
(90/150): libcom_err-devel-1.46.5-7.el9.x86_64.rpm                                                                            219 kB/s |  15 kB     00:00
(91/150): libxcb-1.13.1-9.el9.x86_64.rpm                                                                                      2.3 MB/s | 224 kB     00:00
(92/150): rubygems-3.2.33-165.el9_5.noarch.rpm                                                                                2.6 MB/s | 253 kB     00:00
(93/150): git-2.47.3-1.el9_6.x86_64.rpm                                                                                       772 kB/s |  50 kB     00:00
(94/150): xcb-util-0.4.0-19.el9.x86_64.rpm                                                                                    127 kB/s |  18 kB     00:00
(95/150): libsepol-devel-3.6-2.el9.x86_64.rpm                                                                                 507 kB/s |  39 kB     00:00
(96/150): pulseaudio-libs-15.0-3.el9.x86_64.rpm                                                                               2.8 MB/s | 663 kB     00:00
(97/150): uuid-1.6.2-55.el9.x86_64.rpm                                                                                        475 kB/s |  56 kB     00:00
(98/150): libXft-2.3.3-8.el9.x86_64.rpm                                                                                       847 kB/s |  61 kB     00:00
(99/150): libxkbcommon-x11-1.0.3-4.el9.x86_64.rpm                                                                             181 kB/s |  21 kB     00:00
(100/150): pcre2-utf32-10.40-6.el9.x86_64.rpm                                                                                 1.4 MB/s | 202 kB     00:00
(101/150): xmlrpc-c-1.51.0-16.el9.x86_64.rpm                                                                                  1.1 MB/s | 140 kB     00:00
(102/150): libSM-1.2.3-10.el9.x86_64.rpm                                                                                      478 kB/s |  41 kB     00:00
(103/150): qt5-qtbase-gui-5.15.9-11.el9_6.x86_64.rpm                                                                          3.8 MB/s | 6.3 MB     00:01
(104/150): libwacom-data-1.12.1-3.el9_4.noarch.rpm                                                                            815 kB/s | 105 kB     00:00
(105/150): alsa-lib-1.2.13-2.el9.x86_64.rpm                                                                                   2.3 MB/s | 506 kB     00:00
(106/150): qemu-img-9.1.0-15.el9_6.7.x86_64.rpm                                                                               3.1 MB/s | 2.5 MB     00:00
(107/150): rubygem-bigdecimal-3.0.0-165.el9_5.x86_64.rpm                                                                      797 kB/s |  52 kB     00:00
(108/150): libwacom-1.12.1-3.el9_4.x86_64.rpm                                                                                 349 kB/s |  43 kB     00:00
(109/150): gd-2.3.2-3.el9.x86_64.rpm                                                                                          1.4 MB/s | 131 kB     00:00
(110/150): pango-1.48.7-3.el9.x86_64.rpm                                                                                      2.3 MB/s | 297 kB     00:00
(111/150): xcb-util-keysyms-0.4.0-17.el9.x86_64.rpm                                                                           150 kB/s |  14 kB     00:00
(112/150): libdrm-2.4.123-2.el9.x86_64.rpm                                                                                    1.4 MB/s | 158 kB     00:00
(113/150): cairo-1.17.4-7.el9.x86_64.rpm                                                                                      1.9 MB/s | 659 kB     00:00
(114/150): gsm-1.0.19-6.el9.x86_64.rpm                                                                                        413 kB/s |  33 kB     00:00
(115/150): ruby-default-gems-3.0.7-165.el9_5.noarch.rpm                                                                       363 kB/s |  30 kB     00:00
(116/150): rubygem-io-console-0.5.7-165.el9_5.x86_64.rpm                                                                       68 kB/s |  23 kB     00:00
(117/150): opus-1.3.1-10.el9.x86_64.rpm                                                                                       664 kB/s | 199 kB     00:00
(118/150): rubygem-rexml-3.2.5-165.el9_5.noarch.rpm                                                                           802 kB/s |  92 kB     00:00
(119/150): qt5-qtbase-5.15.9-11.el9_6.x86_64.rpm                                                                              5.1 MB/s | 3.5 MB     00:00
(120/150): libogg-1.3.4-6.el9.x86_64.rpm                                                                                      578 kB/s |  32 kB     00:00
(121/150): nodejs-16.20.2-8.el9_4.x86_64.rpm                                                                                  1.7 MB/s | 111 kB     00:00
(122/150): rubygem-psych-3.3.2-165.el9_5.x86_64.rpm                                                                           792 kB/s |  48 kB     00:00
(123/150): libXfixes-5.0.3-16.el9.x86_64.rpm                                                                                  312 kB/s |  19 kB     00:00
(124/150): mtdev-1.1.5-22.el9.x86_64.rpm                                                                                      411 kB/s |  21 kB     00:00
(125/150): libasyncns-0.8-22.el9.x86_64.rpm                                                                                   403 kB/s |  29 kB     00:00
(126/150): libvorbis-1.3.7-5.el9.x86_64.rpm                                                                                   2.0 MB/s | 192 kB     00:00
(127/150): git-core-2.47.3-1.el9_6.x86_64.rpm                                                                                 5.6 MB/s | 4.6 MB     00:00
(128/150): opennebula-sunstone-6.10.0.1-1.el9.noarch.rpm                                                                      832 kB/s |  29 MB     00:35
(129/150): fontconfig-2.14.0-2.el9_1.x86_64.rpm                                                                               598 kB/s | 274 kB     00:00
(130/150): perl-Error-0.17029-7.el9.noarch.rpm                                                                                650 kB/s |  41 kB     00:00
(131/150): opennebula-fireedge-6.10.0.1-1.el9.x86_64.rpm                                                                      1.0 MB/s |  46 MB     00:46
(132/150): ruby-libs-3.0.7-165.el9_5.x86_64.rpm                                                                               2.3 MB/s | 3.2 MB     00:01
(133/150): libICE-1.0.10-8.el9.x86_64.rpm                                                                                      53 kB/s |  70 kB     00:01
(134/150): libsndfile-1.0.31-9.el9.x86_64.rpm                                                                                 605 kB/s | 205 kB     00:00
(135/150): mesa-libEGL-24.2.8-2.el9_6.x86_64.rpm                                                                              745 kB/s | 141 kB     00:00
(136/150): sqlite-3.34.1-8.el9_6.x86_64.rpm                                                                                   3.3 MB/s | 746 kB     00:00
(137/150): mesa-filesystem-24.2.8-2.el9_6.x86_64.rpm                                                                           44 kB/s |  11 kB     00:00
(138/150): fribidi-1.0.10-6.el9.2.x86_64.rpm                                                                                  912 kB/s |  84 kB     00:00
(139/150): xcb-util-image-0.4.0-19.el9.0.1.x86_64.rpm                                                                         175 kB/s |  18 kB     00:00
(140/150): qt5-qtsvg-5.15.9-2.el9.x86_64.rpm                                                                                  1.5 MB/s | 184 kB     00:00
(141/150): libxkbfile-1.1.0-8.el9.x86_64.rpm                                                                                  770 kB/s |  88 kB     00:00
(142/150): libwayland-server-1.21.0-1.el9.x86_64.rpm                                                                          313 kB/s |  41 kB     00:00
(143/150): libxkbcommon-1.0.3-4.el9.x86_64.rpm                                                                                895 kB/s | 132 kB     00:00
(144/150): perl-Git-2.47.3-1.el9_6.noarch.rpm                                                                                  77 kB/s |  37 kB     00:00
(145/150): lame-libs-3.100-12.el9.x86_64.rpm                                                                                  662 kB/s | 332 kB     00:00
(146/150): mesa-dri-drivers-24.2.8-2.el9_6.x86_64.rpm                                                                         4.8 MB/s | 9.4 MB     00:01
(147/150): pixman-0.40.0-6.el9_3.x86_64.rpm                                                                                   200 kB/s | 269 kB     00:01
(148/150): libjpeg-turbo-2.0.90-7.el9.x86_64.rpm                                                                              128 kB/s | 174 kB     00:01
(149/150): libxslt-1.1.34-13.el9_6.x86_64.rpm                                                                                 1.1 MB/s | 239 kB     00:00
(150/150): libX11-1.7.0-11.el9.x86_64.rpm                                                                                     2.5 MB/s | 645 kB     00:00
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                         4.0 MB/s | 209 MB     00:52
OpenNebula Community Edition                                                                                                   18 kB/s | 3.1 kB     00:00
Importing GPG key 0x906DC27C:
 Userid     : "OpenNebula Repository <contact@opennebula.io>"
 Fingerprint: 0B2D 385C 7C93 04B1 1A03 67B9 05A0 5927 906D C27C
 From       : https://downloads.opennebula.io/repo/repo2.key
Is this ok [y/N]: y
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Running scriptlet: npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                                                                                1/1
  Preparing        :                                                                                                                                      1/1
  Installing       : ruby-libs-3.0.7-165.el9_5.x86_64                                                                                                   1/150
  Installing       : libjpeg-turbo-2.0.90-7.el9.x86_64                                                                                                  2/150
  Running scriptlet: opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                     3/150
  Installing       : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                     3/150
  Installing       : libogg-2:1.3.4-6.el9.x86_64                                                                                                        4/150
  Installing       : libX11-xcb-1.7.0-11.el9.x86_64                                                                                                     5/150
  Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                                                                            6/150
  Installing       : opennebula-common-6.10.0.1-1.el9.noarch                                                                                            6/150
  Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                                                                            6/150
  Installing       : libxshmfence-1.3-10.el9.x86_64                                                                                                     7/150
  Installing       : libwebp-1.2.0-8.el9.x86_64                                                                                                         8/150
  Installing       : libwayland-client-1.21.0-1.el9.x86_64                                                                                              9/150
  Installing       : libvorbis-1:1.3.7-5.el9.x86_64                                                                                                    10/150
  Installing       : ruby-3.0.7-165.el9_5.x86_64                                                                                                       11/150
  Installing       : rubygem-bigdecimal-3.0.0-165.el9_5.x86_64                                                                                         12/150
  Installing       : rubygem-bundler-2.2.33-165.el9_5.noarch                                                                                           13/150
  Installing       : ruby-default-gems-3.0.7-165.el9_5.noarch                                                                                          14/150
  Installing       : rubygem-io-console-0.5.7-165.el9_5.x86_64                                                                                         15/150
  Installing       : rubygem-psych-3.3.2-165.el9_5.x86_64                                                                                              16/150
  Installing       : rubygems-3.2.33-165.el9_5.noarch                                                                                                  17/150
  Installing       : rubygem-json-2.5.1-165.el9_5.x86_64                                                                                               18/150
  Installing       : rubygem-rdoc-6.3.4.1-165.el9_5.noarch                                                                                             19/150
  Installing       : libwayland-server-1.21.0-1.el9.x86_64                                                                                             20/150
  Installing       : libICE-1.0.10-8.el9.x86_64                                                                                                        21/150
  Installing       : git-core-2.47.3-1.el9_6.x86_64                                                                                                    22/150
  Installing       : gsm-1.0.19-6.el9.x86_64                                                                                                           23/150
  Installing       : flexiblas-3.0.4-8.el9.0.1.x86_64                                                                                                  24/150
  Installing       : augeas-libs-1.14.1-2.el9.x86_64                                                                                                   25/150
  Installing       : pcre2-utf16-10.40-6.el9.x86_64                                                                                                    26/150
  Installing       : libglvnd-1:1.3.4-1.el9.x86_64                                                                                                     27/150
  Installing       : libquadmath-11.5.0-5.el9_5.x86_64                                                                                                 28/150
  Installing       : libgfortran-11.5.0-5.el9_5.x86_64                                                                                                 29/150
  Installing       : libicu-67.1-10.el9_6.x86_64                                                                                                       30/150
  Installing       : libwinpr-2:2.11.7-1.el9.x86_64                                                                                                    31/150
  Installing       : openpgm-5.2.122-28.el9.x86_64                                                                                                     32/150
  Installing       : libunwind-1.6.2-1.el9.x86_64                                                                                                      33/150
  Installing       : libsodium-1.0.18-8.el9.x86_64                                                                                                     34/150
  Installing       : zeromq-4.3.4-2.el9.x86_64                                                                                                         35/150
  Installing       : libsodium-devel-1.0.18-8.el9.x86_64                                                                                               36/150
  Installing       : libunwind-devel-1.6.2-1.el9.x86_64                                                                                                37/150
  Installing       : openpgm-devel-5.2.122-28.el9.x86_64                                                                                               38/150
  Installing       : git-core-doc-2.47.3-1.el9_6.noarch                                                                                                39/150
  Installing       : libSM-1.2.3-10.el9.x86_64                                                                                                         40/150
  Installing       : rubygem-rexml-3.2.5-165.el9_5.noarch                                                                                              41/150
  Installing       : libwayland-cursor-1.21.0-1.el9.x86_64                                                                                             42/150
  Installing       : flac-libs-1.3.3-10.el9_2.1.x86_64                                                                                                 43/150
  Installing       : libvncserver-0.9.13-11.el9.x86_64                                                                                                 44/150
  Installing       : libxslt-1.1.34-13.el9_6.x86_64                                                                                                    45/150
  Installing       : opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                         46/150
  Running scriptlet: opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                         46/150
  Installing       : pixman-0.40.0-6.el9_3.x86_64                                                                                                      47/150
  Installing       : lame-libs-3.100-12.el9.x86_64                                                                                                     48/150
  Installing       : fribidi-1.0.10-6.el9.2.x86_64                                                                                                     49/150
  Installing       : mesa-filesystem-24.2.8-2.el9_6.x86_64                                                                                             50/150
  Installing       : sqlite-3.34.1-8.el9_6.x86_64                                                                                                      51/150
  Installing       : perl-Error-1:0.17029-7.el9.noarch                                                                                                 52/150
  Installing       : libasyncns-0.8-22.el9.x86_64                                                                                                      53/150
  Installing       : mtdev-1.1.5-22.el9.x86_64                                                                                                         54/150
  Installing       : opus-1.3.1-10.el9.x86_64                                                                                                          55/150
  Installing       : libsndfile-1.0.31-9.el9.x86_64                                                                                                    56/150
  Installing       : alsa-lib-1.2.13-2.el9.x86_64                                                                                                      57/150
  Installing       : libwacom-data-1.12.1-3.el9_4.noarch                                                                                               58/150
  Installing       : xmlrpc-c-1.51.0-16.el9.x86_64                                                                                                     59/150
  Installing       : pcre2-utf32-10.40-6.el9.x86_64                                                                                                    60/150
  Installing       : pcre2-devel-10.40-6.el9.x86_64                                                                                                    61/150
  Installing       : uuid-1.6.2-55.el9.x86_64                                                                                                          62/150
  Installing       : libsepol-devel-3.6-2.el9.x86_64                                                                                                   63/150
  Installing       : libselinux-devel-3.6-3.el9.x86_64                                                                                                 64/150
  Installing       : libcom_err-devel-1.46.5-7.el9.x86_64                                                                                              65/150
  Installing       : emacs-filesystem-1:27.2-14.el9_6.2.noarch                                                                                         66/150
  Installing       : perl-Git-2.47.3-1.el9_6.noarch                                                                                                    67/150
  Installing       : git-2.47.3-1.el9_6.x86_64                                                                                                         68/150
  Installing       : libevdev-1.11.0-3.el9.x86_64                                                                                                      69/150
  Installing       : xkeyboard-config-2.33-2.el9.noarch                                                                                                70/150
  Installing       : libxkbcommon-1.0.3-4.el9.x86_64                                                                                                   71/150
  Installing       : openblas-0.3.26-2.el9.x86_64                                                                                                      72/150
  Installing       : openblas-openmp-0.3.26-2.el9.x86_64                                                                                               73/150
  Installing       : flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64                                                                                  74/150
  Installing       : flexiblas-netlib-3.0.4-8.el9.0.1.x86_64                                                                                           75/150
  Installing       : python3-numpy-1:1.23.5-1.el9.x86_64                                                                                               76/150
  Running scriptlet: xml-common-0.6.3-58.el9.noarch                                                                                                    77/150
  Installing       : xml-common-0.6.3-58.el9.noarch                                                                                                    77/150
  Installing       : fontconfig-2.14.0-2.el9_1.x86_64                                                                                                  78/150
  Running scriptlet: fontconfig-2.14.0-2.el9_1.x86_64                                                                                                  78/150
  Installing       : liburing-2.5-1.el9.x86_64                                                                                                         79/150
  Installing       : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                                                                               80/150
  Installing       : libXau-1.0.9-8.el9.x86_64                                                                                                         81/150
  Installing       : libxcb-1.13.1-9.el9.x86_64                                                                                                        82/150
  Installing       : xcb-util-wm-0.4.1-22.el9.x86_64                                                                                                   83/150
  Installing       : xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64                                                                                       84/150
  Installing       : xcb-util-0.4.0-19.el9.x86_64                                                                                                      85/150
  Installing       : xcb-util-image-0.4.0-19.el9.0.1.x86_64                                                                                            86/150
  Installing       : pulseaudio-libs-15.0-3.el9.x86_64                                                                                                 87/150
  Installing       : libxkbcommon-x11-1.0.3-4.el9.x86_64                                                                                               88/150
  Installing       : xcb-util-keysyms-0.4.0-17.el9.x86_64                                                                                              89/150
  Installing       : libverto-devel-0.3.2-3.el9.x86_64                                                                                                 90/150
  Installing       : jbigkit-libs-2.1-23.el9.x86_64                                                                                                    91/150
  Installing       : libtiff-4.4.0-13.el9.x86_64                                                                                                       92/150
  Installing       : libX11-common-1.7.0-11.el9.noarch                                                                                                 93/150
  Installing       : libX11-1.7.0-11.el9.x86_64                                                                                                        94/150
  Installing       : libXext-1.3.4-8.el9.x86_64                                                                                                        95/150
  Installing       : libXrender-0.9.10-16.el9.x86_64                                                                                                   96/150
  Installing       : cairo-1.17.4-7.el9.x86_64                                                                                                         97/150
  Installing       : libXft-2.3.3-8.el9.x86_64                                                                                                         98/150
  Installing       : pango-1.48.7-3.el9.x86_64                                                                                                         99/150
  Installing       : libXxf86vm-1.1.4-18.el9.x86_64                                                                                                   100/150
  Installing       : gnuplot-common-5.4.3-2.el9.x86_64                                                                                                101/150
  Installing       : libXpm-3.5.13-10.el9.x86_64                                                                                                      102/150
  Installing       : gd-2.3.2-3.el9.x86_64                                                                                                            103/150
  Installing       : libXfixes-5.0.3-16.el9.x86_64                                                                                                    104/150
  Installing       : libxkbfile-1.1.0-8.el9.x86_64                                                                                                    105/150
  Installing       : nodejs-libs-1:16.20.2-8.el9_4.x86_64                                                                                             106/150
  Installing       : keyutils-libs-devel-1.6.3-1.el9.x86_64                                                                                           107/150
  Installing       : nodejs-docs-1:16.20.2-8.el9_4.noarch                                                                                             108/150
  Installing       : nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64                                                                                        109/150
  Installing       : nodejs-1:16.20.2-8.el9_4.x86_64                                                                                                  110/150
  Installing       : npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                                                                            111/150
  Installing       : libusbx-1.0.26-1.el9.x86_64                                                                                                      112/150
  Installing       : libkadm5-1.21.1-8.el9_6.x86_64                                                                                                   113/150
  Installing       : krb5-devel-1.21.1-8.el9_6.x86_64                                                                                                 114/150
  Installing       : zeromq-devel-4.3.4-2.el9.x86_64                                                                                                  115/150
  Installing       : opennebula-libs-6.10.0.1-1.el9.noarch                                                                                            116/150
  Running scriptlet: opennebula-libs-6.10.0.1-1.el9.noarch                                                                                            116/150
  Installing       : rsync-3.2.5-3.el9.x86_64                                                                                                         117/150
  Installing       : libgudev-237-1.el9.x86_64                                                                                                        118/150
  Installing       : libwacom-1.12.1-3.el9_4.x86_64                                                                                                   119/150
  Installing       : libinput-1.19.3-5.el9_6.x86_64                                                                                                   120/150
  Running scriptlet: libinput-1.19.3-5.el9_6.x86_64                                                                                                   120/150
  Installing       : libproxy-0.4.15-35.el9.x86_64                                                                                                    121/150
  Installing       : qt5-qtbase-common-5.15.9-11.el9_6.noarch                                                                                         122/150
  Running scriptlet: qt5-qtbase-5.15.9-11.el9_6.x86_64                                                                                                123/150
  Installing       : qt5-qtbase-5.15.9-11.el9_6.x86_64                                                                                                123/150
  Running scriptlet: qt5-qtbase-5.15.9-11.el9_6.x86_64                                                                                                123/150
  Installing       : libpciaccess-0.16-7.el9.x86_64                                                                                                   124/150
  Installing       : libdrm-2.4.123-2.el9.x86_64                                                                                                      125/150
  Installing       : mesa-libglapi-24.2.8-2.el9_6.x86_64                                                                                              126/150
  Installing       : mesa-libgbm-24.2.8-2.el9_6.x86_64                                                                                                127/150
  Installing       : libglvnd-egl-1:1.3.4-1.el9.x86_64                                                                                                128/150
  Installing       : mesa-libEGL-24.2.8-2.el9_6.x86_64                                                                                                129/150
  Installing       : mesa-dri-drivers-24.2.8-2.el9_6.x86_64                                                                                           130/150
  Installing       : libglvnd-glx-1:1.3.4-1.el9.x86_64                                                                                                131/150
  Installing       : mesa-libGL-24.2.8-2.el9_6.x86_64                                                                                                 132/150
  Installing       : glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64                                                                             133/150
  Installing       : avahi-libs-0.8-22.el9_6.1.x86_64                                                                                                 134/150
  Installing       : cups-libs-1:2.3.3op2-33.el9.x86_64                                                                                               135/150
  Installing       : qt5-qtbase-gui-5.15.9-11.el9_6.x86_64                                                                                            136/150
  Installing       : qt5-qtsvg-5.15.9-2.el9.x86_64                                                                                                    137/150
  Installing       : freerdp-libs-2:2.11.7-1.el9.x86_64                                                                                               138/150
  Installing       : bash-completion-1:2.11-5.el9.noarch                                                                                              139/150
  Installing       : opennebula-provision-data-6.10.0.1-1.el9.noarch                                                                                  140/150
  Installing       : libusal-1.1.11-48.el9.x86_64                                                                                                     141/150
  Installing       : genisoimage-1.1.11-48.el9.x86_64                                                                                                 142/150
  Running scriptlet: genisoimage-1.1.11-48.el9.x86_64                                                                                                 142/150
  Installing       : libssh2-1.11.0-1.el9.x86_64                                                                                                      143/150
  Running scriptlet: opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                                                                                     144/150
  Installing       : opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                                                                                     144/150
  Running scriptlet: opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                                                                                     144/150
  Installing       : libcerf-1.17-2.el9.x86_64                                                                                                        145/150
  Installing       : gnuplot-5.4.3-2.el9.x86_64                                                                                                       146/150
  Installing       : opennebula-tools-6.10.0.1-1.el9.noarch                                                                                           147/150
  Running scriptlet: opennebula-6.10.0.1-1.el9.x86_64                                                                                                 148/150
  Installing       : opennebula-6.10.0.1-1.el9.x86_64                                                                                                 148/150
  Running scriptlet: opennebula-6.10.0.1-1.el9.x86_64                                                                                                 148/150
Generating public/private rsa key pair.
Your identification has been saved in /var/lib/one/.ssh/id_rsa
Your public key has been saved in /var/lib/one/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:woRk/R2+HAxkY3WQO+Vh5UqQLnlD3EowGD5QjaOunQ8 oneadmin@frontend.one
The key's randomart image is:
+---[RSA 3072]----+
|    +oo*B++=...  |
|   o +=oooBo=.   |
|    ..+o X B...  |
|    .o .+ %...   |
|   .  o S+ =.    |
|    .  .  o      |
|   oE.           |
|  . o.           |
|     ..          |
+----[SHA256]-----+

  Running scriptlet: opennebula-sunstone-6.10.0.1-1.el9.noarch                                                                                        149/150
  Installing       : opennebula-sunstone-6.10.0.1-1.el9.noarch                                                                                        149/150
  Running scriptlet: opennebula-sunstone-6.10.0.1-1.el9.noarch                                                                                        149/150
  Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                                                                                        150/150
  Installing       : opennebula-fireedge-6.10.0.1-1.el9.x86_64                                                                                        150/150
  Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                                                                                        150/150
  Running scriptlet: fontconfig-2.14.0-2.el9_1.x86_64                                                                                                 150/150
  Running scriptlet: gnuplot-5.4.3-2.el9.x86_64                                                                                                       150/150
  Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                                                                                        150/150
  Verifying        : genisoimage-1.1.11-48.el9.x86_64                                                                                                   1/150
  Verifying        : gnuplot-5.4.3-2.el9.x86_64                                                                                                         2/150
  Verifying        : gnuplot-common-5.4.3-2.el9.x86_64                                                                                                  3/150
  Verifying        : libcerf-1.17-2.el9.x86_64                                                                                                          4/150
  Verifying        : libsodium-1.0.18-8.el9.x86_64                                                                                                      5/150
  Verifying        : libsodium-devel-1.0.18-8.el9.x86_64                                                                                                6/150
  Verifying        : libssh2-1.11.0-1.el9.x86_64                                                                                                        7/150
  Verifying        : libunwind-1.6.2-1.el9.x86_64                                                                                                       8/150
  Verifying        : libunwind-devel-1.6.2-1.el9.x86_64                                                                                                 9/150
  Verifying        : libusal-1.1.11-48.el9.x86_64                                                                                                      10/150
  Verifying        : libvncserver-0.9.13-11.el9.x86_64                                                                                                 11/150
  Verifying        : openpgm-5.2.122-28.el9.x86_64                                                                                                     12/150
  Verifying        : openpgm-devel-5.2.122-28.el9.x86_64                                                                                               13/150
  Verifying        : zeromq-4.3.4-2.el9.x86_64                                                                                                         14/150
  Verifying        : zeromq-devel-4.3.4-2.el9.x86_64                                                                                                   15/150
  Verifying        : opennebula-6.10.0.1-1.el9.x86_64                                                                                                  16/150
  Verifying        : opennebula-common-6.10.0.1-1.el9.noarch                                                                                           17/150
  Verifying        : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                    18/150
  Verifying        : opennebula-fireedge-6.10.0.1-1.el9.x86_64                                                                                         19/150
  Verifying        : opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                                                                                      20/150
  Verifying        : opennebula-libs-6.10.0.1-1.el9.noarch                                                                                             21/150
  Verifying        : opennebula-provision-data-6.10.0.1-1.el9.noarch                                                                                   22/150
  Verifying        : opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                         23/150
  Verifying        : opennebula-sunstone-6.10.0.1-1.el9.noarch                                                                                         24/150
  Verifying        : opennebula-tools-6.10.0.1-1.el9.noarch                                                                                            25/150
  Verifying        : libicu-67.1-10.el9_6.x86_64                                                                                                       26/150
  Verifying        : cups-libs-1:2.3.3op2-33.el9.x86_64                                                                                                27/150
  Verifying        : bash-completion-1:2.11-5.el9.noarch                                                                                               28/150
  Verifying        : avahi-libs-0.8-22.el9_6.1.x86_64                                                                                                  29/150
  Verifying        : libpciaccess-0.16-7.el9.x86_64                                                                                                    30/150
  Verifying        : libquadmath-11.5.0-5.el9_5.x86_64                                                                                                 31/150
  Verifying        : libproxy-0.4.15-35.el9.x86_64                                                                                                     32/150
  Verifying        : libgudev-237-1.el9.x86_64                                                                                                         33/150
  Verifying        : rsync-3.2.5-3.el9.x86_64                                                                                                          34/150
  Verifying        : libgfortran-11.5.0-5.el9_5.x86_64                                                                                                 35/150
  Verifying        : libkadm5-1.21.1-8.el9_6.x86_64                                                                                                    36/150
  Verifying        : libusbx-1.0.26-1.el9.x86_64                                                                                                       37/150
  Verifying        : flac-libs-1.3.3-10.el9_2.1.x86_64                                                                                                 38/150
  Verifying        : rubygem-json-2.5.1-165.el9_5.x86_64                                                                                               39/150
  Verifying        : flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64                                                                                  40/150
  Verifying        : libwinpr-2:2.11.7-1.el9.x86_64                                                                                                    41/150
  Verifying        : libXxf86vm-1.1.4-18.el9.x86_64                                                                                                    42/150
  Verifying        : libXpm-3.5.13-10.el9.x86_64                                                                                                       43/150
  Verifying        : nodejs-docs-1:16.20.2-8.el9_4.noarch                                                                                              44/150
  Verifying        : libglvnd-1:1.3.4-1.el9.x86_64                                                                                                     45/150
  Verifying        : libtiff-4.4.0-13.el9.x86_64                                                                                                       46/150
  Verifying        : libwayland-client-1.21.0-1.el9.x86_64                                                                                             47/150
  Verifying        : libselinux-devel-3.6-3.el9.x86_64                                                                                                 48/150
  Verifying        : rubygem-bundler-2.2.33-165.el9_5.noarch                                                                                           49/150
  Verifying        : keyutils-libs-devel-1.6.3-1.el9.x86_64                                                                                            50/150
  Verifying        : libXrender-0.9.10-16.el9.x86_64                                                                                                   51/150
  Verifying        : qt5-qtbase-common-5.15.9-11.el9_6.noarch                                                                                          52/150
  Verifying        : nodejs-libs-1:16.20.2-8.el9_4.x86_64                                                                                              53/150
  Verifying        : libwebp-1.2.0-8.el9.x86_64                                                                                                        54/150
  Verifying        : xcb-util-wm-0.4.1-22.el9.x86_64                                                                                                   55/150
  Verifying        : python3-numpy-1:1.23.5-1.el9.x86_64                                                                                               56/150
  Verifying        : libX11-common-1.7.0-11.el9.noarch                                                                                                 57/150
  Verifying        : jbigkit-libs-2.1-23.el9.x86_64                                                                                                    58/150
  Verifying        : pcre2-utf16-10.40-6.el9.x86_64                                                                                                    59/150
  Verifying        : libverto-devel-0.3.2-3.el9.x86_64                                                                                                 60/150
  Verifying        : libXau-1.0.9-8.el9.x86_64                                                                                                         61/150
  Verifying        : mesa-libGL-24.2.8-2.el9_6.x86_64                                                                                                  62/150
  Verifying        : augeas-libs-1.14.1-2.el9.x86_64                                                                                                   63/150
  Verifying        : xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64                                                                                       64/150
  Verifying        : mesa-libglapi-24.2.8-2.el9_6.x86_64                                                                                               65/150
  Verifying        : ruby-3.0.7-165.el9_5.x86_64                                                                                                       66/150
  Verifying        : liburing-2.5-1.el9.x86_64                                                                                                         67/150
  Verifying        : libinput-1.19.3-5.el9_6.x86_64                                                                                                    68/150
  Verifying        : libXext-1.3.4-8.el9.x86_64                                                                                                        69/150
  Verifying        : xml-common-0.6.3-58.el9.noarch                                                                                                    70/150
  Verifying        : glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64                                                                              71/150
  Verifying        : libxshmfence-1.3-10.el9.x86_64                                                                                                    72/150
  Verifying        : rubygem-rdoc-6.3.4.1-165.el9_5.noarch                                                                                             73/150
  Verifying        : openblas-openmp-0.3.26-2.el9.x86_64                                                                                               74/150
  Verifying        : flexiblas-3.0.4-8.el9.0.1.x86_64                                                                                                  75/150
  Verifying        : flexiblas-netlib-3.0.4-8.el9.0.1.x86_64                                                                                           76/150
  Verifying        : libX11-xcb-1.7.0-11.el9.x86_64                                                                                                    77/150
  Verifying        : mesa-libgbm-24.2.8-2.el9_6.x86_64                                                                                                 78/150
  Verifying        : libglvnd-glx-1:1.3.4-1.el9.x86_64                                                                                                 79/150
  Verifying        : libwayland-cursor-1.21.0-1.el9.x86_64                                                                                             80/150
  Verifying        : nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64                                                                                         81/150
  Verifying        : openblas-0.3.26-2.el9.x86_64                                                                                                      82/150
  Verifying        : npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                                                                             83/150
  Verifying        : xkeyboard-config-2.33-2.el9.noarch                                                                                                84/150
  Verifying        : krb5-devel-1.21.1-8.el9_6.x86_64                                                                                                  85/150
  Verifying        : pcre2-devel-10.40-6.el9.x86_64                                                                                                    86/150
  Verifying        : libglvnd-egl-1:1.3.4-1.el9.x86_64                                                                                                 87/150
  Verifying        : git-core-doc-2.47.3-1.el9_6.noarch                                                                                                88/150
  Verifying        : freerdp-libs-2:2.11.7-1.el9.x86_64                                                                                                89/150
  Verifying        : libevdev-1.11.0-3.el9.x86_64                                                                                                      90/150
  Verifying        : emacs-filesystem-1:27.2-14.el9_6.2.noarch                                                                                         91/150
  Verifying        : libcom_err-devel-1.46.5-7.el9.x86_64                                                                                              92/150
  Verifying        : libxcb-1.13.1-9.el9.x86_64                                                                                                        93/150
  Verifying        : rubygems-3.2.33-165.el9_5.noarch                                                                                                  94/150
  Verifying        : git-2.47.3-1.el9_6.x86_64                                                                                                         95/150
  Verifying        : xcb-util-0.4.0-19.el9.x86_64                                                                                                      96/150
  Verifying        : libsepol-devel-3.6-2.el9.x86_64                                                                                                   97/150
  Verifying        : pulseaudio-libs-15.0-3.el9.x86_64                                                                                                 98/150
  Verifying        : uuid-1.6.2-55.el9.x86_64                                                                                                          99/150
  Verifying        : libXft-2.3.3-8.el9.x86_64                                                                                                        100/150
  Verifying        : libxkbcommon-x11-1.0.3-4.el9.x86_64                                                                                              101/150
  Verifying        : pcre2-utf32-10.40-6.el9.x86_64                                                                                                   102/150
  Verifying        : xmlrpc-c-1.51.0-16.el9.x86_64                                                                                                    103/150
  Verifying        : libSM-1.2.3-10.el9.x86_64                                                                                                        104/150
  Verifying        : qt5-qtbase-gui-5.15.9-11.el9_6.x86_64                                                                                            105/150
  Verifying        : libwacom-data-1.12.1-3.el9_4.noarch                                                                                              106/150
  Verifying        : alsa-lib-1.2.13-2.el9.x86_64                                                                                                     107/150
  Verifying        : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                                                                              108/150
  Verifying        : rubygem-bigdecimal-3.0.0-165.el9_5.x86_64                                                                                        109/150
  Verifying        : libwacom-1.12.1-3.el9_4.x86_64                                                                                                   110/150
  Verifying        : gd-2.3.2-3.el9.x86_64                                                                                                            111/150
  Verifying        : pango-1.48.7-3.el9.x86_64                                                                                                        112/150
  Verifying        : xcb-util-keysyms-0.4.0-17.el9.x86_64                                                                                             113/150
  Verifying        : libdrm-2.4.123-2.el9.x86_64                                                                                                      114/150
  Verifying        : cairo-1.17.4-7.el9.x86_64                                                                                                        115/150
  Verifying        : gsm-1.0.19-6.el9.x86_64                                                                                                          116/150
  Verifying        : ruby-default-gems-3.0.7-165.el9_5.noarch                                                                                         117/150
  Verifying        : rubygem-io-console-0.5.7-165.el9_5.x86_64                                                                                        118/150
  Verifying        : opus-1.3.1-10.el9.x86_64                                                                                                         119/150
  Verifying        : rubygem-rexml-3.2.5-165.el9_5.noarch                                                                                             120/150
  Verifying        : qt5-qtbase-5.15.9-11.el9_6.x86_64                                                                                                121/150
  Verifying        : libogg-2:1.3.4-6.el9.x86_64                                                                                                      122/150
  Verifying        : nodejs-1:16.20.2-8.el9_4.x86_64                                                                                                  123/150
  Verifying        : rubygem-psych-3.3.2-165.el9_5.x86_64                                                                                             124/150
  Verifying        : libXfixes-5.0.3-16.el9.x86_64                                                                                                    125/150
  Verifying        : mtdev-1.1.5-22.el9.x86_64                                                                                                        126/150
  Verifying        : libasyncns-0.8-22.el9.x86_64                                                                                                     127/150
  Verifying        : libvorbis-1:1.3.7-5.el9.x86_64                                                                                                   128/150
  Verifying        : git-core-2.47.3-1.el9_6.x86_64                                                                                                   129/150
  Verifying        : fontconfig-2.14.0-2.el9_1.x86_64                                                                                                 130/150
  Verifying        : perl-Error-1:0.17029-7.el9.noarch                                                                                                131/150
  Verifying        : ruby-libs-3.0.7-165.el9_5.x86_64                                                                                                 132/150
  Verifying        : libICE-1.0.10-8.el9.x86_64                                                                                                       133/150
  Verifying        : libsndfile-1.0.31-9.el9.x86_64                                                                                                   134/150
  Verifying        : mesa-libEGL-24.2.8-2.el9_6.x86_64                                                                                                135/150
  Verifying        : sqlite-3.34.1-8.el9_6.x86_64                                                                                                     136/150
  Verifying        : mesa-filesystem-24.2.8-2.el9_6.x86_64                                                                                            137/150
  Verifying        : fribidi-1.0.10-6.el9.2.x86_64                                                                                                    138/150
  Verifying        : xcb-util-image-0.4.0-19.el9.0.1.x86_64                                                                                           139/150
  Verifying        : qt5-qtsvg-5.15.9-2.el9.x86_64                                                                                                    140/150
  Verifying        : libxkbfile-1.1.0-8.el9.x86_64                                                                                                    141/150
  Verifying        : libwayland-server-1.21.0-1.el9.x86_64                                                                                            142/150
  Verifying        : libxkbcommon-1.0.3-4.el9.x86_64                                                                                                  143/150
  Verifying        : perl-Git-2.47.3-1.el9_6.noarch                                                                                                   144/150
  Verifying        : lame-libs-3.100-12.el9.x86_64                                                                                                    145/150
  Verifying        : mesa-dri-drivers-24.2.8-2.el9_6.x86_64                                                                                           146/150
  Verifying        : pixman-0.40.0-6.el9_3.x86_64                                                                                                     147/150
  Verifying        : libjpeg-turbo-2.0.90-7.el9.x86_64                                                                                                148/150
  Verifying        : libxslt-1.1.34-13.el9_6.x86_64                                                                                                   149/150
  Verifying        : libX11-1.7.0-11.el9.x86_64                                                                                                       150/150

Installed:
  alsa-lib-1.2.13-2.el9.x86_64                       augeas-libs-1.14.1-2.el9.x86_64                         avahi-libs-0.8-22.el9_6.1.x86_64
  bash-completion-1:2.11-5.el9.noarch                cairo-1.17.4-7.el9.x86_64                               cups-libs-1:2.3.3op2-33.el9.x86_64
  emacs-filesystem-1:27.2-14.el9_6.2.noarch          flac-libs-1.3.3-10.el9_2.1.x86_64                       flexiblas-3.0.4-8.el9.0.1.x86_64
  flexiblas-netlib-3.0.4-8.el9.0.1.x86_64            flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64        fontconfig-2.14.0-2.el9_1.x86_64
  freerdp-libs-2:2.11.7-1.el9.x86_64                 fribidi-1.0.10-6.el9.2.x86_64                           gd-2.3.2-3.el9.x86_64
  genisoimage-1.1.11-48.el9.x86_64                   git-2.47.3-1.el9_6.x86_64                               git-core-2.47.3-1.el9_6.x86_64
  git-core-doc-2.47.3-1.el9_6.noarch                 glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64    gnuplot-5.4.3-2.el9.x86_64
  gnuplot-common-5.4.3-2.el9.x86_64                  gsm-1.0.19-6.el9.x86_64                                 jbigkit-libs-2.1-23.el9.x86_64
  keyutils-libs-devel-1.6.3-1.el9.x86_64             krb5-devel-1.21.1-8.el9_6.x86_64                        lame-libs-3.100-12.el9.x86_64
  libICE-1.0.10-8.el9.x86_64                         libSM-1.2.3-10.el9.x86_64                               libX11-1.7.0-11.el9.x86_64
  libX11-common-1.7.0-11.el9.noarch                  libX11-xcb-1.7.0-11.el9.x86_64                          libXau-1.0.9-8.el9.x86_64
  libXext-1.3.4-8.el9.x86_64                         libXfixes-5.0.3-16.el9.x86_64                           libXft-2.3.3-8.el9.x86_64
  libXpm-3.5.13-10.el9.x86_64                        libXrender-0.9.10-16.el9.x86_64                         libXxf86vm-1.1.4-18.el9.x86_64
  libasyncns-0.8-22.el9.x86_64                       libcerf-1.17-2.el9.x86_64                               libcom_err-devel-1.46.5-7.el9.x86_64
  libdrm-2.4.123-2.el9.x86_64                        libevdev-1.11.0-3.el9.x86_64                            libgfortran-11.5.0-5.el9_5.x86_64
  libglvnd-1:1.3.4-1.el9.x86_64                      libglvnd-egl-1:1.3.4-1.el9.x86_64                       libglvnd-glx-1:1.3.4-1.el9.x86_64
  libgudev-237-1.el9.x86_64                          libicu-67.1-10.el9_6.x86_64                             libinput-1.19.3-5.el9_6.x86_64
  libjpeg-turbo-2.0.90-7.el9.x86_64                  libkadm5-1.21.1-8.el9_6.x86_64                          libogg-2:1.3.4-6.el9.x86_64
  libpciaccess-0.16-7.el9.x86_64                     libproxy-0.4.15-35.el9.x86_64                           libquadmath-11.5.0-5.el9_5.x86_64
  libselinux-devel-3.6-3.el9.x86_64                  libsepol-devel-3.6-2.el9.x86_64                         libsndfile-1.0.31-9.el9.x86_64
  libsodium-1.0.18-8.el9.x86_64                      libsodium-devel-1.0.18-8.el9.x86_64                     libssh2-1.11.0-1.el9.x86_64
  libtiff-4.4.0-13.el9.x86_64                        libunwind-1.6.2-1.el9.x86_64                            libunwind-devel-1.6.2-1.el9.x86_64
  liburing-2.5-1.el9.x86_64                          libusal-1.1.11-48.el9.x86_64                            libusbx-1.0.26-1.el9.x86_64
  libverto-devel-0.3.2-3.el9.x86_64                  libvncserver-0.9.13-11.el9.x86_64                       libvorbis-1:1.3.7-5.el9.x86_64
  libwacom-1.12.1-3.el9_4.x86_64                     libwacom-data-1.12.1-3.el9_4.noarch                     libwayland-client-1.21.0-1.el9.x86_64
  libwayland-cursor-1.21.0-1.el9.x86_64              libwayland-server-1.21.0-1.el9.x86_64                   libwebp-1.2.0-8.el9.x86_64
  libwinpr-2:2.11.7-1.el9.x86_64                     libxcb-1.13.1-9.el9.x86_64                              libxkbcommon-1.0.3-4.el9.x86_64
  libxkbcommon-x11-1.0.3-4.el9.x86_64                libxkbfile-1.1.0-8.el9.x86_64                           libxshmfence-1.3-10.el9.x86_64
  libxslt-1.1.34-13.el9_6.x86_64                     mesa-dri-drivers-24.2.8-2.el9_6.x86_64                  mesa-filesystem-24.2.8-2.el9_6.x86_64
  mesa-libEGL-24.2.8-2.el9_6.x86_64                  mesa-libGL-24.2.8-2.el9_6.x86_64                        mesa-libgbm-24.2.8-2.el9_6.x86_64
  mesa-libglapi-24.2.8-2.el9_6.x86_64                mtdev-1.1.5-22.el9.x86_64                               nodejs-1:16.20.2-8.el9_4.x86_64
  nodejs-docs-1:16.20.2-8.el9_4.noarch               nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64               nodejs-libs-1:16.20.2-8.el9_4.x86_64
  npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64              openblas-0.3.26-2.el9.x86_64                            openblas-openmp-0.3.26-2.el9.x86_64
  opennebula-6.10.0.1-1.el9.x86_64                   opennebula-common-6.10.0.1-1.el9.noarch                 opennebula-common-onecfg-6.10.0.1-1.el9.noarch
  opennebula-fireedge-6.10.0.1-1.el9.x86_64          opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64            opennebula-libs-6.10.0.1-1.el9.noarch
  opennebula-provision-data-6.10.0.1-1.el9.noarch    opennebula-rubygems-6.10.0.1-1.el9.x86_64               opennebula-sunstone-6.10.0.1-1.el9.noarch
  opennebula-tools-6.10.0.1-1.el9.noarch             openpgm-5.2.122-28.el9.x86_64                           openpgm-devel-5.2.122-28.el9.x86_64
  opus-1.3.1-10.el9.x86_64                           pango-1.48.7-3.el9.x86_64                               pcre2-devel-10.40-6.el9.x86_64
  pcre2-utf16-10.40-6.el9.x86_64                     pcre2-utf32-10.40-6.el9.x86_64                          perl-Error-1:0.17029-7.el9.noarch
  perl-Git-2.47.3-1.el9_6.noarch                     pixman-0.40.0-6.el9_3.x86_64                            pulseaudio-libs-15.0-3.el9.x86_64
  python3-numpy-1:1.23.5-1.el9.x86_64                qemu-img-17:9.1.0-15.el9_6.7.x86_64                     qt5-qtbase-5.15.9-11.el9_6.x86_64
  qt5-qtbase-common-5.15.9-11.el9_6.noarch           qt5-qtbase-gui-5.15.9-11.el9_6.x86_64                   qt5-qtsvg-5.15.9-2.el9.x86_64
  rsync-3.2.5-3.el9.x86_64                           ruby-3.0.7-165.el9_5.x86_64                             ruby-default-gems-3.0.7-165.el9_5.noarch
  ruby-libs-3.0.7-165.el9_5.x86_64                   rubygem-bigdecimal-3.0.0-165.el9_5.x86_64               rubygem-bundler-2.2.33-165.el9_5.noarch
  rubygem-io-console-0.5.7-165.el9_5.x86_64          rubygem-json-2.5.1-165.el9_5.x86_64                     rubygem-psych-3.3.2-165.el9_5.x86_64
  rubygem-rdoc-6.3.4.1-165.el9_5.noarch              rubygem-rexml-3.2.5-165.el9_5.noarch                    rubygems-3.2.33-165.el9_5.noarch
  sqlite-3.34.1-8.el9_6.x86_64                       uuid-1.6.2-55.el9.x86_64                                xcb-util-0.4.0-19.el9.x86_64
  xcb-util-image-0.4.0-19.el9.0.1.x86_64             xcb-util-keysyms-0.4.0-17.el9.x86_64                    xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64
  xcb-util-wm-0.4.1-22.el9.x86_64                    xkeyboard-config-2.33-2.el9.noarch                      xml-common-0.6.3-58.el9.noarch
  xmlrpc-c-1.51.0-16.el9.x86_64                      zeromq-4.3.4-2.el9.x86_64                               zeromq-devel-4.3.4-2.el9.x86_64

Complete!
```
Configuration OpenNebula
```shell
#commande
sudo vi /etc/one/oned.conf

#résultat
DB = [ BACKEND = "mysql",
       SERVER  = "localhost",
       PORT    = 0,
       USER    = "oneadmin",
       PASSWD  = "Another_Very_Str0ng_P@ssw0rd",
       DB_NAME = "opennebula",
       CONNECTIONS = 25,
       COMPARE_BINARY = "no" ]
```
Création d'un user pour se log sur la WebUI OpenNebula
```shell
#commande
echo 'oneadmin:Efrei2025' > /var/lib/one/.one/one_auth
sudo chmod 600 /var/lib/one/.one/one_auth
```

Démarrage des services OpenNebula
```shell
#commande
sudo systemctl enable opennebula opennebula-sunstone
sudo systemctl start opennebula opennebula-sunstone
```

#### C. Conf système ####
Ouverture firewall
```shell
#commande
sudo firewall-cmd --permanent --add-port=22/tcp

#résultat
[sudo] password for oneadmin:
success
```
```shell
#commande
sudo firewall-cmd --permanent --add-port=9869/tcp

#résultat
success
```
```shell
#commande
sudo firewall-cmd --permanent --add-port=2633/tcp

#résultat
success
```
```shell
#commande
sudo firewall-cmd --permanent --add-port=4124/tcp

#résultat
success
```
```shell
#commande
sudo firewall-cmd --permanent --add-port=4124/udp

#résultat
success
```
```shell
#commande
sudo firewall-cmd --permanent --add-port=29876/tcp

#résultat
success
```
### 2. Noeuds KVM ###
#### A. KVM ####

 Ajouter les dépôts Open Nebula
```shell
#Création fichier repo
sudo vi /etc/yum.repos.d/opennebula.repo
```
Contenu du fichier
```bash
[opennebula]
name=OpenNebula Community Edition
baseurl=https://downloads.opennebula.io/repo/6.10/RedHat/$releasever/$basearch
enabled=1
gpgkey=https://downloads.opennebula.io/repo/repo2.key
gpgcheck=1
repo_gpgcheck=1
```
Récupération du fichier RPM
```shell
#commande
wget https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm

#résultat
--2025-09-15 13:57:15--  https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
Resolving dev.mysql.com (dev.mysql.com)... 104.85.37.194, 2a02:26f0:680:48c::2e31, 2a02:26f0:680:48b::2e31
Connecting to dev.mysql.com (dev.mysql.com)|104.85.37.194|:443... connected.
HTTP request sent, awaiting response... 302 Moved Temporarily
Location: https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm [following]
--2025-09-15 13:57:24--  https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm
Resolving repo.mysql.com (repo.mysql.com)... 104.85.20.87, 2a02:26f0:9100:196::1d68, 2a02:26f0:9100:184::1d68
Connecting to repo.mysql.com (repo.mysql.com)|104.85.20.87|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 13319 (13K) [application/x-redhat-package-manager]
Saving to: ‘mysql80-community-release-el9-5.noarch.rpm’

mysql80-community-release-el9-5.noarch. 100%[=============================================================================>]  13.01K  --.-KB/s    in 0s

2025-09-15 13:57:32 (38.0 MB/s) - ‘mysql80-community-release-el9-5.noarch.rpm’ saved [13319/13319]
```
Installation du fichier RPM
```shell
#commande
sudo rpm -ivh mysql80-community-release-el9-5.noarch.rpm

#résultat
warning: mysql80-community-release-el9-5.noarch.rpm: Header V4 RSA/SHA256 Signature, key ID 3a79bd29: NOKEY
Verifying...                          ################################# [100%]
Preparing...                          ################################# [100%]
Updating / installing...
   1:mysql80-community-release-el9-5  ################################# [100%]
```
Ajout des dépôts EPEL
```shell
#commande
sudo dnf install -y epel-release

#résultat
MySQL 8.0 Community Server                                                                                                    166 kB/s | 2.7 MB     00:16
MySQL Connectors Community                                                                                                    5.6 kB/s |  90 kB     00:16
MySQL Tools Community                                                                                                          73 kB/s | 1.2 MB     00:16
Package epel-release-9-10.el9.noarch is already installed.
Dependencies resolved.
Nothing to do.
Complete!
```


Installation des libs MySQL
```bash
#commande
sudo dnf install -y mysql-community-server

#résultat
Last metadata expiration check: 0:00:38 ago on Mon 15 Sep 2025 02:03:39 PM EDT.
Dependencies resolved.
==============================================================================================================================================================
 Package                                         Architecture            Version                                     Repository                          Size
==============================================================================================================================================================
Installing:
 mysql-community-server                          x86_64                  8.0.43-1.el9                                mysql80-community                   50 M
Installing dependencies:
 libtirpc                                        x86_64                  1.3.3-9.el9                                 baseos                              93 k
 mysql-community-client                          x86_64                  8.0.43-1.el9                                mysql80-community                  3.3 M
 mysql-community-client-plugins                  x86_64                  8.0.43-1.el9                                mysql80-community                  1.4 M
 mysql-community-common                          x86_64                  8.0.43-1.el9                                mysql80-community                  556 k
 mysql-community-icu-data-files                  x86_64                  8.0.43-1.el9                                mysql80-community                  2.3 M
 mysql-community-libs                            x86_64                  8.0.43-1.el9                                mysql80-community                  1.5 M
 net-tools                                       x86_64                  2.0-0.64.20160912git.el9                    baseos                             294 k

Transaction Summary
==============================================================================================================================================================
Install  8 Packages

Total download size: 59 M
Installed size: 338 M
Downloading Packages:
(1/8): mysql-community-common-8.0.43-1.el9.x86_64.rpm                                                                          66 kB/s | 556 kB     00:08
(2/8): mysql-community-client-plugins-8.0.43-1.el9.x86_64.rpm                                                                 165 kB/s | 1.4 MB     00:08
(3/8): mysql-community-client-8.0.43-1.el9.x86_64.rpm                                                                         380 kB/s | 3.3 MB     00:08
(4/8): mysql-community-libs-8.0.43-1.el9.x86_64.rpm                                                                           3.2 MB/s | 1.5 MB     00:00
(5/8): mysql-community-icu-data-files-8.0.43-1.el9.x86_64.rpm                                                                 3.0 MB/s | 2.3 MB     00:00
(6/8): mysql-community-server-8.0.43-1.el9.x86_64.rpm                                                                          12 MB/s |  50 MB     00:04
(7/8): libtirpc-1.3.3-9.el9.x86_64.rpm                                                                                         12 kB/s |  93 kB     00:08
(8/8): net-tools-2.0-0.64.20160912git.el9.x86_64.rpm                                                                           36 kB/s | 294 kB     00:08
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                         2.3 MB/s |  59 MB     00:25
MySQL 8.0 Community Server                                                                                                    339 kB/s | 3.1 kB     00:00
Importing GPG key 0xA8D3785C:
 Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
 Fingerprint: BCA4 3417 C3B4 85DD 128E C6D4 B7B3 B788 A8D3 785C
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2023
Key imported successfully
MySQL 8.0 Community Server                                                                                                    3.0 MB/s | 3.1 kB     00:00
Importing GPG key 0x3A79BD29:
 Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
 Fingerprint: 859B E8D7 C586 F538 430B 19C2 467B 942D 3A79 BD29
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                      1/1
  Installing       : mysql-community-common-8.0.43-1.el9.x86_64                                                                                           1/8
  Installing       : mysql-community-client-plugins-8.0.43-1.el9.x86_64                                                                                   2/8
  Installing       : mysql-community-libs-8.0.43-1.el9.x86_64                                                                                             3/8
  Running scriptlet: mysql-community-libs-8.0.43-1.el9.x86_64                                                                                             3/8
  Installing       : mysql-community-client-8.0.43-1.el9.x86_64                                                                                           4/8
  Installing       : libtirpc-1.3.3-9.el9.x86_64                                                                                                          5/8
  Installing       : net-tools-2.0-0.64.20160912git.el9.x86_64                                                                                            6/8
  Running scriptlet: net-tools-2.0-0.64.20160912git.el9.x86_64                                                                                            6/8
  Installing       : mysql-community-icu-data-files-8.0.43-1.el9.x86_64                                                                                   7/8
  Running scriptlet: mysql-community-server-8.0.43-1.el9.x86_64                                                                                           8/8
  Installing       : mysql-community-server-8.0.43-1.el9.x86_64                                                                                           8/8
  Running scriptlet: mysql-community-server-8.0.43-1.el9.x86_64                                                                                           8/8
  Verifying        : mysql-community-client-8.0.43-1.el9.x86_64                                                                                           1/8
  Verifying        : mysql-community-client-plugins-8.0.43-1.el9.x86_64                                                                                   2/8
  Verifying        : mysql-community-common-8.0.43-1.el9.x86_64                                                                                           3/8
  Verifying        : mysql-community-icu-data-files-8.0.43-1.el9.x86_64                                                                                   4/8
  Verifying        : mysql-community-libs-8.0.43-1.el9.x86_64                                                                                             5/8
  Verifying        : mysql-community-server-8.0.43-1.el9.x86_64                                                                                           6/8
  Verifying        : net-tools-2.0-0.64.20160912git.el9.x86_64                                                                                            7/8
  Verifying        : libtirpc-1.3.3-9.el9.x86_64                                                                                                          8/8

Installed:
  libtirpc-1.3.3-9.el9.x86_64                    mysql-community-client-8.0.43-1.el9.x86_64             mysql-community-client-plugins-8.0.43-1.el9.x86_64
  mysql-community-common-8.0.43-1.el9.x86_64     mysql-community-icu-data-files-8.0.43-1.el9.x86_64     mysql-community-libs-8.0.43-1.el9.x86_64
  mysql-community-server-8.0.43-1.el9.x86_64     net-tools-2.0-0.64.20160912git.el9.x86_64

Complete!
```

Installation KVM
```shell
#commande
sudo dnf install -y opennebula-node-kvm

#résultat
Last metadata expiration check: 0:02:06 ago on Mon 15 Sep 2025 02:03:39 PM EDT.
Dependencies resolved.
==============================================================================================================================================================
 Package                                              Architecture         Version                                             Repository                Size
==============================================================================================================================================================
Installing:
 opennebula-node-kvm                                  noarch               6.10.0.1-1.el9                                      opennebula                13 k
Installing dependencies:
 augeas                                               x86_64               1.14.1-2.el9                                        appstream                 63 k
 augeas-libs                                          x86_64               1.14.1-2.el9                                        appstream                373 k
 boost-iostreams                                      x86_64               1.75.0-10.el9                                       appstream                 36 k
 boost-system                                         x86_64               1.75.0-10.el9                                       appstream                 11 k
 boost-thread                                         x86_64               1.75.0-10.el9                                       appstream                 53 k
 bzip2                                                x86_64               1.0.8-10.el9_5                                      baseos                    51 k
 capstone                                             x86_64               4.0.2-10.el9                                        appstream                766 k
 cyrus-sasl-gssapi                                    x86_64               2.1.27-21.el9                                       baseos                    26 k
 daxctl-libs                                          x86_64               78-2.el9                                            baseos                    41 k
 device-mapper-multipath-libs                         x86_64               0.8.7-35.el9_6.1                                    baseos                   267 k
 dmidecode                                            x86_64               1:3.6-1.el9                                         baseos                   100 k
 dnsmasq                                              x86_64               2.85-16.el9_4                                       appstream                326 k
 edk2-ovmf                                            noarch               20241117-2.el9                                      appstream                6.1 M
 flac-libs                                            x86_64               1.3.3-10.el9_2.1                                    appstream                217 k
 gnutls-dane                                          x86_64               3.8.3-6.el9                                         appstream                 18 k
 gnutls-utils                                         x86_64               3.8.3-6.el9                                         appstream                283 k
 gsm                                                  x86_64               1.0.19-6.el9                                        appstream                 33 k
 gssproxy                                             x86_64               0.8.4-7.el9                                         baseos                   108 k
 ipxe-roms-qemu                                       noarch               20200823-9.git4bd064de.el9                          appstream                673 k
 iscsi-initiator-utils                                x86_64               6.2.1.9-1.gita65a472.el9                            baseos                   383 k
 iscsi-initiator-utils-iscsiuio                       x86_64               6.2.1.9-1.gita65a472.el9                            baseos                    80 k
 isns-utils-libs                                      x86_64               0.101-4.el9                                         baseos                   100 k
 json-glib                                            x86_64               1.6.6-1.el9                                         baseos                   151 k
 libX11                                               x86_64               1.7.0-11.el9                                        appstream                645 k
 libX11-common                                        noarch               1.7.0-11.el9                                        appstream                151 k
 libX11-xcb                                           x86_64               1.7.0-11.el9                                        appstream                 10 k
 libXau                                               x86_64               1.0.9-8.el9                                         appstream                 30 k
 libXext                                              x86_64               1.3.4-8.el9                                         appstream                 39 k
 libXfixes                                            x86_64               5.0.3-16.el9                                        appstream                 19 k
 libXxf86vm                                           x86_64               1.1.4-18.el9                                        appstream                 18 k
 libasyncns                                           x86_64               0.8-22.el9                                          appstream                 29 k
 libblkio                                             x86_64               1.5.0-1.el9_4                                       appstream                1.0 M
 libbsd                                               x86_64               0.12.2-1.el9                                        epel                     120 k
 libdrm                                               x86_64               2.4.123-2.el9                                       appstream                158 k
 libepoxy                                             x86_64               1.5.5-4.el9                                         appstream                244 k
 libev                                                x86_64               4.33-6.el9                                          baseos                    51 k
 libfdt                                               x86_64               1.6.0-7.el9                                         appstream                 33 k
 libglvnd                                             x86_64               1:1.3.4-1.el9                                       appstream                133 k
 libglvnd-egl                                         x86_64               1:1.3.4-1.el9                                       appstream                 36 k
 libglvnd-glx                                         x86_64               1:1.3.4-1.el9                                       appstream                140 k
 libibverbs                                           x86_64               54.0-1.el9                                          baseos                   434 k
 libmd                                                x86_64               1.1.0-1.el9                                         epel                      46 k
 libnbd                                               x86_64               1.20.3-1.el9                                        appstream                168 k
 libnfsidmap                                          x86_64               1:2.5.4-34.el9                                      baseos                    60 k
 libogg                                               x86_64               2:1.3.4-6.el9                                       appstream                 32 k
 libpcap                                              x86_64               14:1.10.0-4.el9                                     baseos                   172 k
 libpciaccess                                         x86_64               0.16-7.el9                                          baseos                    26 k
 libpmem                                              x86_64               1.12.1-1.el9                                        appstream                111 k
 librados2                                            x86_64               2:16.2.4-5.el9                                      appstream                3.4 M
 librbd1                                              x86_64               2:16.2.4-5.el9                                      appstream                3.0 M
 librdmacm                                            x86_64               54.0-1.el9                                          baseos                    70 k
 libretls                                             x86_64               3.8.1-1.el9                                         epel                      41 k
 libslirp                                             x86_64               4.4.0-8.el9                                         appstream                 67 k
 libsndfile                                           x86_64               1.0.31-9.el9                                        appstream                205 k
 libtpms                                              x86_64               0.9.1-5.20211126git1ff6fe1f43.el9_6                 appstream                182 k
 liburing                                             x86_64               2.5-1.el9                                           appstream                 38 k
 libusbx                                              x86_64               1.0.26-1.el9                                        baseos                    75 k
 libverto-libev                                       x86_64               0.3.2-3.el9                                         baseos                    13 k
 libvirt                                              x86_64               10.10.0-7.6.el9_6                                   appstream                 29 k
 libvirt-client                                       x86_64               10.10.0-7.6.el9_6                                   appstream                449 k
 libvirt-client-qemu                                  x86_64               10.10.0-7.6.el9_6                                   appstream                 49 k
 libvirt-daemon                                       x86_64               10.10.0-7.6.el9_6                                   appstream                215 k
 libvirt-daemon-common                                x86_64               10.10.0-7.6.el9_6                                   appstream                137 k
 libvirt-daemon-config-network                        x86_64               10.10.0-7.6.el9_6                                   appstream                 31 k
 libvirt-daemon-config-nwfilter                       x86_64               10.10.0-7.6.el9_6                                   appstream                 37 k
 libvirt-daemon-driver-interface                      x86_64               10.10.0-7.6.el9_6                                   appstream                221 k
 libvirt-daemon-driver-network                        x86_64               10.10.0-7.6.el9_6                                   appstream                270 k
 libvirt-daemon-driver-nodedev                        x86_64               10.10.0-7.6.el9_6                                   appstream                245 k
 libvirt-daemon-driver-nwfilter                       x86_64               10.10.0-7.6.el9_6                                   appstream                257 k
 libvirt-daemon-driver-qemu                           x86_64               10.10.0-7.6.el9_6                                   appstream                991 k
 libvirt-daemon-driver-secret                         x86_64               10.10.0-7.6.el9_6                                   appstream                218 k
 libvirt-daemon-driver-storage                        x86_64               10.10.0-7.6.el9_6                                   appstream                 28 k
 libvirt-daemon-driver-storage-core                   x86_64               10.10.0-7.6.el9_6                                   appstream                273 k
 libvirt-daemon-driver-storage-disk                   x86_64               10.10.0-7.6.el9_6                                   appstream                 39 k
 libvirt-daemon-driver-storage-iscsi                  x86_64               10.10.0-7.6.el9_6                                   appstream                 37 k
 libvirt-daemon-driver-storage-logical                x86_64               10.10.0-7.6.el9_6                                   appstream                 41 k
 libvirt-daemon-driver-storage-mpath                  x86_64               10.10.0-7.6.el9_6                                   appstream                 34 k
 libvirt-daemon-driver-storage-rbd                    x86_64               10.10.0-7.6.el9_6                                   appstream                 45 k
 libvirt-daemon-driver-storage-scsi                   x86_64               10.10.0-7.6.el9_6                                   appstream                 36 k
 libvirt-daemon-lock                                  x86_64               10.10.0-7.6.el9_6                                   appstream                 66 k
 libvirt-daemon-log                                   x86_64               10.10.0-7.6.el9_6                                   appstream                 70 k
 libvirt-daemon-plugin-lockd                          x86_64               10.10.0-7.6.el9_6                                   appstream                 40 k
 libvirt-daemon-proxy                                 x86_64               10.10.0-7.6.el9_6                                   appstream                214 k
 libvirt-libs                                         x86_64               10.10.0-7.6.el9_6                                   appstream                5.0 M
 libvorbis                                            x86_64               1:1.3.7-5.el9                                       appstream                192 k
 libwayland-client                                    x86_64               1.21.0-1.el9                                        appstream                 33 k
 libwayland-server                                    x86_64               1.21.0-1.el9                                        appstream                 41 k
 libxcb                                               x86_64               1.13.1-9.el9                                        appstream                224 k
 libxkbcommon                                         x86_64               1.0.3-4.el9                                         appstream                132 k
 libxshmfence                                         x86_64               1.3-10.el9                                          appstream                 12 k
 libxslt                                              x86_64               1.1.34-13.el9_6                                     appstream                239 k
 lzop                                                 x86_64               1.04-8.el9                                          baseos                    55 k
 mdevctl                                              x86_64               1.1.0-4.el9                                         appstream                758 k
 mesa-dri-drivers                                     x86_64               24.2.8-2.el9_6                                      appstream                9.4 M
 mesa-filesystem                                      x86_64               24.2.8-2.el9_6                                      appstream                 11 k
 mesa-libEGL                                          x86_64               24.2.8-2.el9_6                                      appstream                141 k
 mesa-libGL                                           x86_64               24.2.8-2.el9_6                                      appstream                169 k
 mesa-libgbm                                          x86_64               24.2.8-2.el9_6                                      appstream                 36 k
 mesa-libglapi                                        x86_64               24.2.8-2.el9_6                                      appstream                 44 k
 nbdkit-basic-filters                                 x86_64               1.38.5-5.el9_6                                      appstream                308 k
 nbdkit-basic-plugins                                 x86_64               1.38.5-5.el9_6                                      appstream                207 k
 nbdkit-selinux                                       noarch               1.38.5-5.el9_6                                      appstream                 23 k
 nbdkit-server                                        x86_64               1.38.5-5.el9_6                                      appstream                128 k
 ndctl-libs                                           x86_64               78-2.el9                                            baseos                    89 k
 nfs-utils                                            x86_64               1:2.5.4-34.el9                                      baseos                   430 k
 numad                                                x86_64               0.5-37.20150602git.el9                              baseos                    36 k
 opennebula-common                                    noarch               6.10.0.1-1.el9                                      opennebula                23 k
 opennebula-common-onecfg                             noarch               6.10.0.1-1.el9                                      opennebula               9.1 k
 opennebula-rubygems                                  x86_64               6.10.0.1-1.el9                                      opennebula                16 M
 opus                                                 x86_64               1.3.1-10.el9                                        appstream                199 k
 passt-selinux                                        noarch               0^20250217.ga1e48a0-10.el9_6                        appstream                 27 k
 pciutils                                             x86_64               3.7.0-7.el9                                         baseos                    92 k
 pixman                                               x86_64               0.40.0-6.el9_3                                      appstream                269 k
 protobuf-c                                           x86_64               1.3.3-13.el9                                        baseos                    34 k
 pulseaudio-libs                                      x86_64               15.0-3.el9                                          appstream                663 k
 python3-cffi                                         x86_64               1.14.5-5.el9                                        baseos                   241 k
 python3-cryptography                                 x86_64               36.0.1-4.el9                                        baseos                   1.2 M
 python3-libvirt                                      x86_64               10.10.0-1.el9                                       appstream                333 k
 python3-lxml                                         x86_64               4.6.5-3.el9                                         appstream                1.2 M
 python3-ply                                          noarch               3.11-14.el9.0.1                                     baseos                   103 k
 python3-pycparser                                    noarch               2.20-6.el9                                          baseos                   124 k
 python3-pyyaml                                       x86_64               5.4.1-6.el9                                         baseos                   191 k
 qemu-img                                             x86_64               17:9.1.0-15.el9_6.7                                 appstream                2.5 M
 qemu-kvm                                             x86_64               17:9.1.0-15.el9_6.7                                 appstream                 64 k
 qemu-kvm-audio-pa                                    x86_64               17:9.1.0-15.el9_6.7                                 appstream                 73 k
 qemu-kvm-block-blkio                                 x86_64               17:9.1.0-15.el9_6.7                                 appstream                 76 k
 qemu-kvm-block-rbd                                   x86_64               17:9.1.0-15.el9_6.7                                 appstream                 78 k
 qemu-kvm-common                                      x86_64               17:9.1.0-15.el9_6.7                                 appstream                668 k
 qemu-kvm-core                                        x86_64               17:9.1.0-15.el9_6.7                                 appstream                4.9 M
 qemu-kvm-device-display-virtio-gpu                   x86_64               17:9.1.0-15.el9_6.7                                 appstream                 85 k
 qemu-kvm-device-display-virtio-gpu-pci               x86_64               17:9.1.0-15.el9_6.7                                 appstream                 68 k
 qemu-kvm-device-display-virtio-vga                   x86_64               17:9.1.0-15.el9_6.7                                 appstream                 69 k
 qemu-kvm-device-usb-host                             x86_64               17:9.1.0-15.el9_6.7                                 appstream                 82 k
 qemu-kvm-device-usb-redirect                         x86_64               17:9.1.0-15.el9_6.7                                 appstream                 87 k
 qemu-kvm-docs                                        x86_64               17:9.1.0-15.el9_6.7                                 appstream                1.2 M
 qemu-kvm-tools                                       x86_64               17:9.1.0-15.el9_6.7                                 appstream                571 k
 qemu-kvm-ui-egl-headless                             x86_64               17:9.1.0-15.el9_6.7                                 appstream                 69 k
 qemu-kvm-ui-opengl                                   x86_64               17:9.1.0-15.el9_6.7                                 appstream                 76 k
 qemu-pr-helper                                       x86_64               17:9.1.0-15.el9_6.7                                 appstream                492 k
 quota                                                x86_64               1:4.09-4.el9                                        baseos                   188 k
 quota-nls                                            noarch               1:4.09-4.el9                                        baseos                    76 k
 rpcbind                                              x86_64               1.2.6-7.el9                                         baseos                    56 k
 rsync                                                x86_64               3.2.5-3.el9                                         baseos                   403 k
 ruby                                                 x86_64               3.0.7-165.el9_5                                     appstream                 38 k
 ruby-libs                                            x86_64               3.0.7-165.el9_5                                     appstream                3.2 M
 rubygem-io-console                                   x86_64               0.5.7-165.el9_5                                     appstream                 23 k
 rubygem-json                                         x86_64               2.5.1-165.el9_5                                     appstream                 51 k
 rubygem-psych                                        x86_64               3.3.2-165.el9_5                                     appstream                 48 k
 rubygem-rexml                                        noarch               3.2.5-165.el9_5                                     appstream                 92 k
 rubygem-sqlite3                                      x86_64               1.4.2-8.el9                                         epel                      44 k
 rubygems                                             noarch               3.2.33-165.el9_5                                    appstream                253 k
 scrub                                                x86_64               2.6.1-4.el9                                         appstream                 44 k
 seabios-bin                                          noarch               1.16.3-4.el9                                        appstream                100 k
 seavgabios-bin                                       noarch               1.16.3-4.el9                                        appstream                 34 k
 sssd-nfs-idmap                                       x86_64               2.9.6-4.el9_6.2                                     baseos                    39 k
 swtpm                                                x86_64               0.8.0-2.el9_4                                       appstream                 42 k
 swtpm-libs                                           x86_64               0.8.0-2.el9_4                                       appstream                 48 k
 swtpm-tools                                          x86_64               0.8.0-2.el9_4                                       appstream                116 k
 systemd-container                                    x86_64               252-51.el9_6.1                                      baseos                   577 k
 unbound-libs                                         x86_64               1.16.2-19.el9_6.1                                   appstream                550 k
 usbredir                                             x86_64               0.13.0-2.el9                                        appstream                 50 k
 virtiofsd                                            x86_64               1.13.2-1.el9_6                                      appstream                990 k
 xkeyboard-config                                     noarch               2.33-2.el9                                          appstream                779 k
 zstd                                                 x86_64               1.5.5-1.el9                                         baseos                   461 k
Installing weak dependencies:
 nbdkit                                               x86_64               1.38.5-5.el9_6                                      appstream                8.5 k
 nbdkit-curl-plugin                                   x86_64               1.38.5-5.el9_6                                      appstream                 39 k
 nbdkit-ssh-plugin                                    x86_64               1.38.5-5.el9_6                                      appstream                 28 k
 netcat                                               x86_64               1.229-1.el9                                         epel                      34 k
 passt                                                x86_64               0^20250217.ga1e48a0-10.el9_6                        appstream                259 k
 ruby-default-gems                                    noarch               3.0.7-165.el9_5                                     appstream                 30 k
 rubygem-bigdecimal                                   x86_64               3.0.0-165.el9_5                                     appstream                 52 k
 rubygem-bundler                                      noarch               2.2.33-165.el9_5                                    appstream                370 k
 rubygem-rdoc                                         noarch               6.3.4.1-165.el9_5                                   appstream                398 k

Transaction Summary
==============================================================================================================================================================
Install  174 Packages

Total download size: 84 M
Installed size: 492 M
Downloading Packages:
(1/174): libretls-3.8.1-1.el9.x86_64.rpm                                                                                      5.1 kB/s |  41 kB     00:08
(2/174): libmd-1.1.0-1.el9.x86_64.rpm                                                                                         5.6 kB/s |  46 kB     00:08
(3/174): libbsd-0.12.2-1.el9.x86_64.rpm                                                                                        15 kB/s | 120 kB     00:08
(4/174): netcat-1.229-1.el9.x86_64.rpm                                                                                        922 kB/s |  34 kB     00:00
(5/174): rubygem-sqlite3-1.4.2-8.el9.x86_64.rpm                                                                               710 kB/s |  44 kB     00:00
(6/174): opennebula-common-onecfg-6.10.0.1-1.el9.noarch.rpm                                                                   1.1 kB/s | 9.1 kB     00:08
(7/174): opennebula-common-6.10.0.1-1.el9.noarch.rpm                                                                          2.7 kB/s |  23 kB     00:08
(8/174): opennebula-node-kvm-6.10.0.1-1.el9.noarch.rpm                                                                        1.5 kB/s |  13 kB     00:08
(9/174): opennebula-rubygems-6.10.0.1-1.el9.x86_64.rpm                                                                         16 MB/s |  16 MB     00:01
(10/174): protobuf-c-1.3.3-13.el9.x86_64.rpm                                                                                  4.3 kB/s |  34 kB     00:08
(11/174): python3-pycparser-2.20-6.el9.noarch.rpm                                                                              14 kB/s | 124 kB     00:09
(12/174): isns-utils-libs-0.101-4.el9.x86_64.rpm                                                                               11 kB/s | 100 kB     00:09
(13/174): sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64.rpm                                                                           562 kB/s |  39 kB     00:00
(14/174): numad-0.5-37.20150602git.el9.x86_64.rpm                                                                             552 kB/s |  36 kB     00:00
(15/174): python3-pyyaml-5.4.1-6.el9.x86_64.rpm                                                                               1.2 MB/s | 191 kB     00:00
(16/174): iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64.rpm                                                           2.3 MB/s | 383 kB     00:00
(17/174): python3-cryptography-36.0.1-4.el9.x86_64.rpm                                                                        6.0 MB/s | 1.2 MB     00:00
(18/174): lzop-1.04-8.el9.x86_64.rpm                                                                                          483 kB/s |  55 kB     00:00
(19/174): librdmacm-54.0-1.el9.x86_64.rpm                                                                                     1.1 MB/s |  70 kB     00:00
(20/174): cyrus-sasl-gssapi-2.1.27-21.el9.x86_64.rpm                                                                          363 kB/s |  26 kB     00:00
(21/174): device-mapper-multipath-libs-0.8.7-35.el9_6.1.x86_64.rpm                                                            3.1 MB/s | 267 kB     00:00
(22/174): quota-4.09-4.el9.x86_64.rpm                                                                                         2.3 MB/s | 188 kB     00:00
(23/174): python3-ply-3.11-14.el9.0.1.noarch.rpm                                                                              1.8 MB/s | 103 kB     00:00
(24/174): iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64.rpm                                                  1.2 MB/s |  80 kB     00:00
(25/174): libpciaccess-0.16-7.el9.x86_64.rpm                                                                                  437 kB/s |  26 kB     00:00
(26/174): gssproxy-0.8.4-7.el9.x86_64.rpm                                                                                     1.6 MB/s | 108 kB     00:00
(27/174): quota-nls-4.09-4.el9.noarch.rpm                                                                                     920 kB/s |  76 kB     00:00
(28/174): dmidecode-3.6-1.el9.x86_64.rpm                                                                                      1.2 MB/s | 100 kB     00:00
(29/174): json-glib-1.6.6-1.el9.x86_64.rpm                                                                                    2.4 MB/s | 151 kB     00:00
(30/174): ndctl-libs-78-2.el9.x86_64.rpm                                                                                      1.4 MB/s |  89 kB     00:00
(31/174): libibverbs-54.0-1.el9.x86_64.rpm                                                                                    4.7 MB/s | 434 kB     00:00
(32/174): libev-4.33-6.el9.x86_64.rpm                                                                                         896 kB/s |  51 kB     00:00
(33/174): libverto-libev-0.3.2-3.el9.x86_64.rpm                                                                               227 kB/s |  13 kB     00:00
(34/174): python3-cffi-1.14.5-5.el9.x86_64.rpm                                                                                3.2 MB/s | 241 kB     00:00
(35/174): libpcap-1.10.0-4.el9.x86_64.rpm                                                                                     2.0 MB/s | 172 kB     00:00
(36/174): nfs-utils-2.5.4-34.el9.x86_64.rpm                                                                                   4.4 MB/s | 430 kB     00:00
(37/174): rpcbind-1.2.6-7.el9.x86_64.rpm                                                                                      778 kB/s |  56 kB     00:00
(38/174): pciutils-3.7.0-7.el9.x86_64.rpm                                                                                     1.3 MB/s |  92 kB     00:00
(39/174): systemd-container-252-51.el9_6.1.x86_64.rpm                                                                         4.2 MB/s | 577 kB     00:00
(40/174): zstd-1.5.5-1.el9.x86_64.rpm                                                                                         5.3 MB/s | 461 kB     00:00
(41/174): libnfsidmap-2.5.4-34.el9.x86_64.rpm                                                                                 780 kB/s |  60 kB     00:00
(42/174): daxctl-libs-78-2.el9.x86_64.rpm                                                                                     672 kB/s |  41 kB     00:00
(43/174): bzip2-1.0.8-10.el9_5.x86_64.rpm                                                                                     983 kB/s |  51 kB     00:00
(44/174): rsync-3.2.5-3.el9.x86_64.rpm                                                                                        5.1 MB/s | 403 kB     00:00
(45/174): libusbx-1.0.26-1.el9.x86_64.rpm                                                                                     947 kB/s |  75 kB     00:00
(46/174): libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_6.x86_64.rpm                                                            550 kB/s |  40 kB     00:00
(47/174): libslirp-4.4.0-8.el9.x86_64.rpm                                                                                     459 kB/s |  67 kB     00:00
(48/174): flac-libs-1.3.3-10.el9_2.1.x86_64.rpm                                                                               2.3 MB/s | 217 kB     00:00
(49/174): dnsmasq-2.85-16.el9_4.x86_64.rpm                                                                                    1.7 MB/s | 326 kB     00:00
(50/174): rubygem-json-2.5.1-165.el9_5.x86_64.rpm                                                                             507 kB/s |  51 kB     00:00
(51/174): libXxf86vm-1.1.4-18.el9.x86_64.rpm                                                                                  360 kB/s |  18 kB     00:00
(52/174): libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64.rpm                                                                   1.6 MB/s | 214 kB     00:00
(53/174): libglvnd-1.3.4-1.el9.x86_64.rpm                                                                                     1.7 MB/s | 133 kB     00:00
(54/174): libwayland-client-1.21.0-1.el9.x86_64.rpm                                                                           869 kB/s |  33 kB     00:00
(55/174): virtiofsd-1.13.2-1.el9_6.x86_64.rpm                                                                                 6.5 MB/s | 990 kB     00:00
(56/174): passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch.rpm                                                               115 kB/s |  27 kB     00:00
(57/174): libvirt-daemon-10.10.0-7.6.el9_6.x86_64.rpm                                                                         2.2 MB/s | 215 kB     00:00
(58/174): libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64.rpm                                                                    1.4 MB/s |  66 kB     00:00
(59/174): rubygem-bundler-2.2.33-165.el9_5.noarch.rpm                                                                         4.1 MB/s | 370 kB     00:00
(60/174): swtpm-0.8.0-2.el9_4.x86_64.rpm                                                                                      406 kB/s |  42 kB     00:00
(61/174): swtpm-tools-0.8.0-2.el9_4.x86_64.rpm                                                                                1.5 MB/s | 116 kB     00:00
(62/174): nbdkit-selinux-1.38.5-5.el9_6.noarch.rpm                                                                            258 kB/s |  23 kB     00:00
(63/174): libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64.rpm                                                          2.6 MB/s | 245 kB     00:00
(64/174): libX11-common-1.7.0-11.el9.noarch.rpm                                                                               1.9 MB/s | 151 kB     00:00
(65/174): libvirt-libs-10.10.0-7.6.el9_6.x86_64.rpm                                                                            10 MB/s | 5.0 MB     00:00
(66/174): passt-0^20250217.ga1e48a0-10.el9_6.x86_64.rpm                                                                       927 kB/s | 259 kB     00:00
(67/174): qemu-kvm-block-rbd-9.1.0-15.el9_6.7.x86_64.rpm                                                                      461 kB/s |  78 kB     00:00
(68/174): libXau-1.0.9-8.el9.x86_64.rpm                                                                                       1.1 MB/s |  30 kB     00:00
(69/174): libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64.rpm                                                                     1.2 MB/s |  70 kB     00:00
(70/174): mesa-libglapi-24.2.8-2.el9_6.x86_64.rpm                                                                             1.2 MB/s |  44 kB     00:00
(71/174): mesa-libGL-24.2.8-2.el9_6.x86_64.rpm                                                                                1.9 MB/s | 169 kB     00:00
(72/174): augeas-libs-1.14.1-2.el9.x86_64.rpm                                                                                 4.1 MB/s | 373 kB     00:00
(73/174): ruby-3.0.7-165.el9_5.x86_64.rpm                                                                                     836 kB/s |  38 kB     00:00
(74/174): libnbd-1.20.3-1.el9.x86_64.rpm                                                                                      2.1 MB/s | 168 kB     00:00
(75/174): boost-thread-1.75.0-10.el9.x86_64.rpm                                                                               1.0 MB/s |  53 kB     00:00
(76/174): libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.x86_64.rpm                                                              3.0 MB/s | 182 kB     00:00
(77/174): seavgabios-bin-1.16.3-4.el9.noarch.rpm                                                                              603 kB/s |  34 kB     00:00
(78/174): libXext-1.3.4-8.el9.x86_64.rpm                                                                                      1.5 MB/s |  39 kB     00:00
(79/174): nbdkit-server-1.38.5-5.el9_6.x86_64.rpm                                                                             2.4 MB/s | 128 kB     00:00
(80/174): liburing-2.5-1.el9.x86_64.rpm                                                                                       381 kB/s |  38 kB     00:00
(81/174): libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64.rpm                                                          311 kB/s |  31 kB     00:00
(82/174): scrub-2.6.1-4.el9.x86_64.rpm                                                                                        496 kB/s |  44 kB     00:00
(83/174): libxshmfence-1.3-10.el9.x86_64.rpm                                                                                  310 kB/s |  12 kB     00:00
(84/174): qemu-kvm-device-display-virtio-gpu-9.1.0-15.el9_6.7.x86_64.rpm                                                      1.2 MB/s |  85 kB     00:00
(85/174): qemu-kvm-docs-9.1.0-15.el9_6.7.x86_64.rpm                                                                           6.3 MB/s | 1.2 MB     00:00
(86/174): libvirt-daemon-driver-storage-mpath-10.10.0-7.6.el9_6.x86_64.rpm                                                    459 kB/s |  34 kB     00:00
(87/174): rubygem-rdoc-6.3.4.1-165.el9_5.noarch.rpm                                                                           5.3 MB/s | 398 kB     00:00
(88/174): libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64.rpm                                                     3.5 MB/s | 273 kB     00:00
(89/174): libvirt-daemon-driver-storage-iscsi-10.10.0-7.6.el9_6.x86_64.rpm                                                    873 kB/s |  37 kB     00:00
(90/174): qemu-kvm-device-usb-redirect-9.1.0-15.el9_6.7.x86_64.rpm                                                            473 kB/s |  87 kB     00:00
(91/174): libX11-xcb-1.7.0-11.el9.x86_64.rpm                                                                                  288 kB/s |  10 kB     00:00
(92/174): libvirt-client-10.10.0-7.6.el9_6.x86_64.rpm                                                                         2.6 MB/s | 449 kB     00:00
(93/174): mesa-libgbm-24.2.8-2.el9_6.x86_64.rpm                                                                               1.1 MB/s |  36 kB     00:00
(94/174): libglvnd-glx-1.3.4-1.el9.x86_64.rpm                                                                                 4.1 MB/s | 140 kB     00:00
(95/174): ipxe-roms-qemu-20200823-9.git4bd064de.el9.noarch.rpm                                                                3.0 MB/s | 673 kB     00:00
(96/174): libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64.rpm                                                         3.8 MB/s | 257 kB     00:00
(97/174): libepoxy-1.5.5-4.el9.x86_64.rpm                                                                                     3.7 MB/s | 244 kB     00:00
(98/174): libvirt-daemon-driver-storage-logical-10.10.0-7.6.el9_6.x86_64.rpm                                                  712 kB/s |  41 kB     00:00
(99/174): capstone-4.0.2-10.el9.x86_64.rpm                                                                                    5.3 MB/s | 766 kB     00:00
(100/174): nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64.rpm                                                                       910 kB/s |  39 kB     00:00
(101/174): libglvnd-egl-1.3.4-1.el9.x86_64.rpm                                                                                544 kB/s |  36 kB     00:00
(102/174): qemu-kvm-ui-egl-headless-9.1.0-15.el9_6.7.x86_64.rpm                                                               1.0 MB/s |  69 kB     00:00
(103/174): xkeyboard-config-2.33-2.el9.noarch.rpm                                                                             5.4 MB/s | 779 kB     00:00
(104/174): libxcb-1.13.1-9.el9.x86_64.rpm                                                                                     4.2 MB/s | 224 kB     00:00
(105/174): qemu-kvm-9.1.0-15.el9_6.7.x86_64.rpm                                                                               986 kB/s |  64 kB     00:00
(106/174): rubygems-3.2.33-165.el9_5.noarch.rpm                                                                               1.9 MB/s | 253 kB     00:00
(107/174): libpmem-1.12.1-1.el9.x86_64.rpm                                                                                    1.3 MB/s | 111 kB     00:00
(108/174): qemu-pr-helper-9.1.0-15.el9_6.7.x86_64.rpm                                                                         3.9 MB/s | 492 kB     00:00
(109/174): pulseaudio-libs-15.0-3.el9.x86_64.rpm                                                                              6.3 MB/s | 663 kB     00:00
(110/174): gnutls-dane-3.8.3-6.el9.x86_64.rpm                                                                                 146 kB/s |  18 kB     00:00
(111/174): augeas-1.14.1-2.el9.x86_64.rpm                                                                                     987 kB/s |  63 kB     00:00
(112/174): swtpm-libs-0.8.0-2.el9_4.x86_64.rpm                                                                                675 kB/s |  48 kB     00:00
(113/174): libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64.rpm                                                                 2.1 MB/s | 137 kB     00:00
(114/174): libvirt-daemon-driver-storage-disk-10.10.0-7.6.el9_6.x86_64.rpm                                                    308 kB/s |  39 kB     00:00
(115/174): qemu-img-9.1.0-15.el9_6.7.x86_64.rpm                                                                                10 MB/s | 2.5 MB     00:00
(116/174): qemu-kvm-core-9.1.0-15.el9_6.7.x86_64.rpm                                                                          6.3 MB/s | 4.9 MB     00:00
(117/174): rubygem-bigdecimal-3.0.0-165.el9_5.x86_64.rpm                                                                      299 kB/s |  52 kB     00:00
(118/174): unbound-libs-1.16.2-19.el9_6.1.x86_64.rpm                                                                          4.1 MB/s | 550 kB     00:00
(119/174): libdrm-2.4.123-2.el9.x86_64.rpm                                                                                    4.1 MB/s | 158 kB     00:00
(120/174): nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64.rpm                                                                        473 kB/s |  28 kB     00:00
(121/174): qemu-kvm-device-display-virtio-vga-9.1.0-15.el9_6.7.x86_64.rpm                                                     1.9 MB/s |  69 kB     00:00
(122/174): boost-iostreams-1.75.0-10.el9.x86_64.rpm                                                                           525 kB/s |  36 kB     00:00
(123/174): ruby-default-gems-3.0.7-165.el9_5.noarch.rpm                                                                       582 kB/s |  30 kB     00:00
(124/174): gsm-1.0.19-6.el9.x86_64.rpm                                                                                        473 kB/s |  33 kB     00:00
(125/174): rubygem-io-console-0.5.7-165.el9_5.x86_64.rpm                                                                      614 kB/s |  23 kB     00:00
(126/174): libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64.rpm                                                       4.3 MB/s | 221 kB     00:00
(127/174): opus-1.3.1-10.el9.x86_64.rpm                                                                                       2.1 MB/s | 199 kB     00:00
(128/174): libogg-1.3.4-6.el9.x86_64.rpm                                                                                      1.2 MB/s |  32 kB     00:00
(129/174): boost-system-1.75.0-10.el9.x86_64.rpm                                                                              274 kB/s |  11 kB     00:00
(130/174): usbredir-0.13.0-2.el9.x86_64.rpm                                                                                   371 kB/s |  50 kB     00:00
(131/174): rubygem-rexml-3.2.5-165.el9_5.noarch.rpm                                                                           692 kB/s |  92 kB     00:00
(132/174): libXfixes-5.0.3-16.el9.x86_64.rpm                                                                                  447 kB/s |  19 kB     00:00
(133/174): rubygem-psych-3.3.2-165.el9_5.x86_64.rpm                                                                           810 kB/s |  48 kB     00:00
(134/174): qemu-kvm-device-usb-host-9.1.0-15.el9_6.7.x86_64.rpm                                                               1.9 MB/s |  82 kB     00:00
(135/174): libasyncns-0.8-22.el9.x86_64.rpm                                                                                   1.1 MB/s |  29 kB     00:00
(136/174): libvorbis-1.3.7-5.el9.x86_64.rpm                                                                                   5.1 MB/s | 192 kB     00:00
(137/174): qemu-kvm-device-display-virtio-gpu-pci-9.1.0-15.el9_6.7.x86_64.rpm                                                 1.0 MB/s |  68 kB     00:00
(138/174): seabios-bin-1.16.3-4.el9.noarch.rpm                                                                                2.0 MB/s | 100 kB     00:00
(139/174): nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64.rpm                                                                     3.4 MB/s | 207 kB     00:00
(140/174): gnutls-utils-3.8.3-6.el9.x86_64.rpm                                                                                3.7 MB/s | 283 kB     00:00
(141/174): libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64.rpm                                                        574 kB/s |  37 kB     00:00
(142/174): qemu-kvm-block-blkio-9.1.0-15.el9_6.7.x86_64.rpm                                                                   1.1 MB/s |  76 kB     00:00
(143/174): libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64.rpm                                                          3.0 MB/s | 218 kB     00:00
(144/174): libblkio-1.5.0-1.el9_4.x86_64.rpm                                                                                  5.5 MB/s | 1.0 MB     00:00
(145/174): mdevctl-1.1.0-4.el9.x86_64.rpm                                                                                     4.0 MB/s | 758 kB     00:00
(146/174): libsndfile-1.0.31-9.el9.x86_64.rpm                                                                                 4.9 MB/s | 205 kB     00:00
(147/174): ruby-libs-3.0.7-165.el9_5.x86_64.rpm                                                                               8.4 MB/s | 3.2 MB     00:00
(148/174): mesa-libEGL-24.2.8-2.el9_6.x86_64.rpm                                                                              1.7 MB/s | 141 kB     00:00
(149/174): python3-libvirt-10.10.0-1.el9.x86_64.rpm                                                                           2.7 MB/s | 333 kB     00:00
(150/174): mesa-filesystem-24.2.8-2.el9_6.x86_64.rpm                                                                          381 kB/s |  11 kB     00:00
(151/174): libvirt-daemon-driver-storage-scsi-10.10.0-7.6.el9_6.x86_64.rpm                                                    961 kB/s |  36 kB     00:00
(152/174): libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64.rpm                                                            6.8 MB/s | 991 kB     00:00
(153/174): qemu-kvm-tools-9.1.0-15.el9_6.7.x86_64.rpm                                                                         4.7 MB/s | 571 kB     00:00
(154/174): libwayland-server-1.21.0-1.el9.x86_64.rpm                                                                          1.1 MB/s |  41 kB     00:00
(155/174): nbdkit-1.38.5-5.el9_6.x86_64.rpm                                                                                    57 kB/s | 8.5 kB     00:00
(156/174): libvirt-daemon-driver-storage-10.10.0-7.6.el9_6.x86_64.rpm                                                         146 kB/s |  28 kB     00:00
(157/174): edk2-ovmf-20241117-2.el9.noarch.rpm                                                                                 11 MB/s | 6.1 MB     00:00
(158/174): libxkbcommon-1.0.3-4.el9.x86_64.rpm                                                                                1.2 MB/s | 132 kB     00:00
(159/174): qemu-kvm-audio-pa-9.1.0-15.el9_6.7.x86_64.rpm                                                                      1.2 MB/s |  73 kB     00:00
(160/174): libvirt-daemon-driver-storage-rbd-10.10.0-7.6.el9_6.x86_64.rpm                                                     756 kB/s |  45 kB     00:00
(161/174): librados2-16.2.4-5.el9.x86_64.rpm                                                                                  5.7 MB/s | 3.4 MB     00:00
(162/174): libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64.rpm                                                         2.3 MB/s | 270 kB     00:00
(163/174): qemu-kvm-ui-opengl-9.1.0-15.el9_6.7.x86_64.rpm                                                                     950 kB/s |  76 kB     00:00
(164/174): libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64.rpm                                                                   510 kB/s |  49 kB     00:00
(165/174): libfdt-1.6.0-7.el9.x86_64.rpm                                                                                      590 kB/s |  33 kB     00:00
(166/174): librbd1-16.2.4-5.el9.x86_64.rpm                                                                                     10 MB/s | 3.0 MB     00:00
(167/174): libvirt-10.10.0-7.6.el9_6.x86_64.rpm                                                                               163 kB/s |  29 kB     00:00
(168/174): nbdkit-basic-filters-1.38.5-5.el9_6.x86_64.rpm                                                                     1.5 MB/s | 308 kB     00:00
(169/174): pixman-0.40.0-6.el9_3.x86_64.rpm                                                                                   1.0 MB/s | 269 kB     00:00
(170/174): python3-lxml-4.6.5-3.el9.x86_64.rpm                                                                                4.7 MB/s | 1.2 MB     00:00
(171/174): libxslt-1.1.34-13.el9_6.x86_64.rpm                                                                                 1.6 MB/s | 239 kB     00:00
(172/174): mesa-dri-drivers-24.2.8-2.el9_6.x86_64.rpm                                                                          13 MB/s | 9.4 MB     00:00
(173/174): libX11-1.7.0-11.el9.x86_64.rpm                                                                                     3.2 MB/s | 645 kB     00:00
(174/174): qemu-kvm-common-9.1.0-15.el9_6.7.x86_64.rpm                                                                        2.3 MB/s | 668 kB     00:00
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                         1.5 MB/s |  84 MB     00:56
OpenNebula Community Edition                                                                                                  388  B/s | 3.1 kB     00:08
Importing GPG key 0x906DC27C:
 Userid     : "OpenNebula Repository <contact@opennebula.io>"
 Fingerprint: 0B2D 385C 7C93 04B1 1A03 67B9 05A0 5927 906D C27C
 From       : https://downloads.opennebula.io/repo/repo2.key
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                      1/1
  Installing       : ruby-libs-3.0.7-165.el9_5.x86_64                                                                                                   1/174
  Installing       : nbdkit-server-1.38.5-5.el9_6.x86_64                                                                                                2/174
  Installing       : pixman-0.40.0-6.el9_3.x86_64                                                                                                       3/174
  Installing       : libibverbs-54.0-1.el9.x86_64                                                                                                       4/174
  Installing       : libogg-2:1.3.4-6.el9.x86_64                                                                                                        5/174
  Installing       : libX11-xcb-1.7.0-11.el9.x86_64                                                                                                     6/174
  Installing       : libxshmfence-1.3-10.el9.x86_64                                                                                                     7/174
  Installing       : liburing-2.5-1.el9.x86_64                                                                                                          8/174
  Installing       : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                                                                                9/174
  Installing       : libusbx-1.0.26-1.el9.x86_64                                                                                                       10/174
  Installing       : librdmacm-54.0-1.el9.x86_64                                                                                                       11/174
  Installing       : passt-0^20250217.ga1e48a0-10.el9_6.x86_64                                                                                         12/174
  Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                                                                                 13/174
  Installing       : passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                                                                                 13/174
  Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                                                                                 13/174
  Installing       : daxctl-libs-78-2.el9.x86_64                                                                                                       14/174
  Installing       : ndctl-libs-78-2.el9.x86_64                                                                                                        15/174
  Installing       : libxslt-1.1.34-13.el9_6.x86_64                                                                                                    16/174
  Installing       : libwayland-server-1.21.0-1.el9.x86_64                                                                                             17/174
  Installing       : libepoxy-1.5.5-4.el9.x86_64                                                                                                       18/174
  Installing       : libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.x86_64                                                                                19/174
  Installing       : libnbd-1.20.3-1.el9.x86_64                                                                                                        20/174
  Installing       : augeas-libs-1.14.1-2.el9.x86_64                                                                                                   21/174
  Installing       : libglvnd-1:1.3.4-1.el9.x86_64                                                                                                     22/174
  Installing       : libnfsidmap-1:2.5.4-34.el9.x86_64                                                                                                 23/174
  Installing       : libpciaccess-0.16-7.el9.x86_64                                                                                                    24/174
  Installing       : libdrm-2.4.123-2.el9.x86_64                                                                                                       25/174
  Installing       : augeas-1.14.1-2.el9.x86_64                                                                                                        26/174
  Installing       : swtpm-libs-0.8.0-2.el9_4.x86_64                                                                                                   27/174
  Installing       : swtpm-0.8.0-2.el9_4.x86_64                                                                                                        28/174
  Running scriptlet: swtpm-0.8.0-2.el9_4.x86_64                                                                                                        28/174
  Installing       : python3-lxml-4.6.5-3.el9.x86_64                                                                                                   29/174
  Installing       : libpmem-1.12.1-1.el9.x86_64                                                                                                       30/174
  Installing       : usbredir-0.13.0-2.el9.x86_64                                                                                                      31/174
  Installing       : flac-libs-1.3.3-10.el9_2.1.x86_64                                                                                                 32/174
  Installing       : libvorbis-1:1.3.7-5.el9.x86_64                                                                                                    33/174
  Installing       : libpcap-14:1.10.0-4.el9.x86_64                                                                                                    34/174
  Installing       : nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64                                                                                          35/174
  Installing       : nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64                                                                                           36/174
  Installing       : nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64                                                                                        37/174
  Installing       : nbdkit-basic-filters-1.38.5-5.el9_6.x86_64                                                                                        38/174
  Installing       : ruby-3.0.7-165.el9_5.x86_64                                                                                                       39/174
  Installing       : rubygem-bigdecimal-3.0.0-165.el9_5.x86_64                                                                                         40/174
  Installing       : rubygem-bundler-2.2.33-165.el9_5.noarch                                                                                           41/174
  Installing       : ruby-default-gems-3.0.7-165.el9_5.noarch                                                                                          42/174
  Installing       : rubygem-io-console-0.5.7-165.el9_5.x86_64                                                                                         43/174
  Installing       : rubygem-psych-3.3.2-165.el9_5.x86_64                                                                                              44/174
  Installing       : rubygems-3.2.33-165.el9_5.noarch                                                                                                  45/174
  Installing       : rubygem-json-2.5.1-165.el9_5.x86_64                                                                                               46/174
  Installing       : rubygem-rdoc-6.3.4.1-165.el9_5.noarch                                                                                             47/174
  Installing       : rubygem-sqlite3-1.4.2-8.el9.x86_64                                                                                                48/174
  Installing       : opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                         49/174
  Running scriptlet: opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                         49/174
  Installing       : rubygem-rexml-3.2.5-165.el9_5.noarch                                                                                              50/174
  Installing       : libfdt-1.6.0-7.el9.x86_64                                                                                                         51/174
  Installing       : edk2-ovmf-20241117-2.el9.noarch                                                                                                   52/174
  Installing       : mesa-filesystem-24.2.8-2.el9_6.x86_64                                                                                             53/174
  Installing       : mdevctl-1.1.0-4.el9.x86_64                                                                                                        54/174
  Installing       : libblkio-1.5.0-1.el9_4.x86_64                                                                                                     55/174
  Installing       : seabios-bin-1.16.3-4.el9.noarch                                                                                                   56/174
  Installing       : libasyncns-0.8-22.el9.x86_64                                                                                                      57/174
  Installing       : boost-system-1.75.0-10.el9.x86_64                                                                                                 58/174
  Installing       : boost-thread-1.75.0-10.el9.x86_64                                                                                                 59/174
  Installing       : opus-1.3.1-10.el9.x86_64                                                                                                          60/174
  Installing       : gsm-1.0.19-6.el9.x86_64                                                                                                           61/174
  Installing       : libsndfile-1.0.31-9.el9.x86_64                                                                                                    62/174
  Installing       : boost-iostreams-1.75.0-10.el9.x86_64                                                                                              63/174
  Installing       : librados2-2:16.2.4-5.el9.x86_64                                                                                                   64/174
  Running scriptlet: librados2-2:16.2.4-5.el9.x86_64                                                                                                   64/174
  Installing       : librbd1-2:16.2.4-5.el9.x86_64                                                                                                     65/174
  Running scriptlet: librbd1-2:16.2.4-5.el9.x86_64                                                                                                     65/174
  Installing       : xkeyboard-config-2.33-2.el9.noarch                                                                                                66/174
  Installing       : libxkbcommon-1.0.3-4.el9.x86_64                                                                                                   67/174
  Installing       : qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64                                                                                         68/174
  Installing       : capstone-4.0.2-10.el9.x86_64                                                                                                      69/174
  Installing       : ipxe-roms-qemu-20200823-9.git4bd064de.el9.noarch                                                                                  70/174
  Installing       : scrub-2.6.1-4.el9.x86_64                                                                                                          71/174
  Installing       : qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64                                                                                          72/174
  Installing       : seavgabios-bin-1.16.3-4.el9.noarch                                                                                                73/174
  Installing       : qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64                                                                                        74/174
  Running scriptlet: qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64                                                                                        74/174
  Installing       : qemu-kvm-device-display-virtio-gpu-17:9.1.0-15.el9_6.7.x86_64                                                                     75/174
  Installing       : qemu-kvm-device-display-virtio-gpu-pci-17:9.1.0-15.el9_6.7.x86_64                                                                 76/174
  Installing       : qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_64                                                                                     77/174
  Installing       : qemu-kvm-device-usb-redirect-17:9.1.0-15.el9_6.7.x86_64                                                                           78/174
  Installing       : qemu-kvm-device-display-virtio-vga-17:9.1.0-15.el9_6.7.x86_64                                                                     79/174
  Installing       : qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7.x86_64                                                                               80/174
  Installing       : qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86_64                                                                                   81/174
  Installing       : libXau-1.0.9-8.el9.x86_64                                                                                                         82/174
  Installing       : libxcb-1.13.1-9.el9.x86_64                                                                                                        83/174
  Installing       : pulseaudio-libs-15.0-3.el9.x86_64                                                                                                 84/174
  Installing       : qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64                                                                                      85/174
  Installing       : libX11-common-1.7.0-11.el9.noarch                                                                                                 86/174
  Installing       : libX11-1.7.0-11.el9.x86_64                                                                                                        87/174
  Installing       : libXext-1.3.4-8.el9.x86_64                                                                                                        88/174
  Installing       : libXxf86vm-1.1.4-18.el9.x86_64                                                                                                    89/174
  Installing       : libXfixes-5.0.3-16.el9.x86_64                                                                                                     90/174
  Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch                                                                                              91/174
  Installing       : nbdkit-selinux-1.38.5-5.el9_6.noarch                                                                                              91/174
  Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch                                                                                              91/174
  Installing       : nbdkit-1.38.5-5.el9_6.x86_64                                                                                                      92/174
  Installing       : libwayland-client-1.21.0-1.el9.x86_64                                                                                             93/174
  Installing       : mesa-libglapi-24.2.8-2.el9_6.x86_64                                                                                               94/174
  Installing       : mesa-libgbm-24.2.8-2.el9_6.x86_64                                                                                                 95/174
  Installing       : libglvnd-egl-1:1.3.4-1.el9.x86_64                                                                                                 96/174
  Installing       : mesa-libEGL-24.2.8-2.el9_6.x86_64                                                                                                 97/174
  Installing       : mesa-dri-drivers-24.2.8-2.el9_6.x86_64                                                                                            98/174
  Installing       : libglvnd-glx-1:1.3.4-1.el9.x86_64                                                                                                 99/174
  Installing       : mesa-libGL-24.2.8-2.el9_6.x86_64                                                                                                 100/174
  Installing       : qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_64                                                                                    101/174
  Installing       : qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7.x86_64                                                                              102/174
  Installing       : virtiofsd-1.13.2-1.el9_6.x86_64                                                                                                  103/174
  Running scriptlet: dnsmasq-2.85-16.el9_4.x86_64                                                                                                     104/174
  Installing       : dnsmasq-2.85-16.el9_4.x86_64                                                                                                     104/174
  Running scriptlet: dnsmasq-2.85-16.el9_4.x86_64                                                                                                     104/174
  Installing       : libslirp-4.4.0-8.el9.x86_64                                                                                                      105/174
  Installing       : qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64                                                                                         106/174
  Installing       : rsync-3.2.5-3.el9.x86_64                                                                                                         107/174
  Installing       : bzip2-1.0.8-10.el9_5.x86_64                                                                                                      108/174
  Installing       : zstd-1.5.5-1.el9.x86_64                                                                                                          109/174
  Installing       : pciutils-3.7.0-7.el9.x86_64                                                                                                      110/174
  Running scriptlet: rpcbind-1.2.6-7.el9.x86_64                                                                                                       111/174
  Installing       : rpcbind-1.2.6-7.el9.x86_64                                                                                                       111/174
  Running scriptlet: rpcbind-1.2.6-7.el9.x86_64                                                                                                       111/174
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /usr/lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /usr/lib/systemd/system/rpcbind.socket.

  Installing       : systemd-container-252-51.el9_6.1.x86_64                                                                                          112/174
  Installing       : libev-4.33-6.el9.x86_64                                                                                                          113/174
  Installing       : libverto-libev-0.3.2-3.el9.x86_64                                                                                                114/174
  Installing       : gssproxy-0.8.4-7.el9.x86_64                                                                                                      115/174
  Running scriptlet: gssproxy-0.8.4-7.el9.x86_64                                                                                                      115/174
  Installing       : json-glib-1.6.6-1.el9.x86_64                                                                                                     116/174
  Installing       : dmidecode-1:3.6-1.el9.x86_64                                                                                                     117/174
  Installing       : quota-nls-1:4.09-4.el9.noarch                                                                                                    118/174
  Installing       : quota-1:4.09-4.el9.x86_64                                                                                                        119/174
  Installing       : python3-ply-3.11-14.el9.0.1.noarch                                                                                               120/174
  Installing       : python3-pycparser-2.20-6.el9.noarch                                                                                              121/174
  Installing       : python3-cffi-1.14.5-5.el9.x86_64                                                                                                 122/174
  Installing       : python3-cryptography-36.0.1-4.el9.x86_64                                                                                         123/174
  Installing       : device-mapper-multipath-libs-0.8.7-35.el9_6.1.x86_64                                                                             124/174
  Installing       : qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64                                                                                        125/174
  Installing       : qemu-kvm-17:9.1.0-15.el9_6.7.x86_64                                                                                              126/174
  Installing       : cyrus-sasl-gssapi-2.1.27-21.el9.x86_64                                                                                           127/174
  Installing       : libvirt-libs-10.10.0-7.6.el9_6.x86_64                                                                                            128/174
  Running scriptlet: libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64                                                                                     129/174
  Installing       : libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64                                                                                     129/174
  Running scriptlet: libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64                                                                                      130/174
  Installing       : libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64                                                                                      130/174
  Installing       : libvirt-client-10.10.0-7.6.el9_6.x86_64                                                                                          131/174
  Running scriptlet: libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64                                                                                   132/174
  Installing       : libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64                                                                                   132/174
  Running scriptlet: libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          133/174
  Installing       : libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          133/174
  Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                                                                           134/174
  Installing       : libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                                                                           134/174
  Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                                                                           134/174
  Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64                                                                           135/174
  Installing       : libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64                                                                           135/174
  Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64                                                                           135/174
  Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          136/174
  Installing       : libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          136/174
  Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          136/174
  Running scriptlet: libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64                                                                           137/174
  Installing       : libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64                                                                           137/174
  Running scriptlet: libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64                                                                         138/174
  Installing       : libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64                                                                         138/174
  Running scriptlet: libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64                                                                            139/174
  Installing       : libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64                                                                            139/174
  Installing       : libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_6.x86_64                                                                             140/174
  Installing       : python3-libvirt-10.10.0-1.el9.x86_64                                                                                             141/174
  Installing       : libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64                                                                                     142/174
  Installing       : lzop-1.04-8.el9.x86_64                                                                                                           143/174
  Installing       : python3-pyyaml-5.4.1-6.el9.x86_64                                                                                                144/174
  Running scriptlet: nfs-utils-1:2.5.4-34.el9.x86_64                                                                                                  145/174
  Installing       : nfs-utils-1:2.5.4-34.el9.x86_64                                                                                                  145/174
  Running scriptlet: nfs-utils-1:2.5.4-34.el9.x86_64                                                                                                  145/174
  Running scriptlet: libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64                                                                      146/174
  Installing       : libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64                                                                      146/174
  Installing       : libvirt-daemon-driver-storage-mpath-10.10.0-7.6.el9_6.x86_64                                                                     147/174
  Installing       : libvirt-daemon-driver-storage-logical-10.10.0-7.6.el9_6.x86_64                                                                   148/174
  Installing       : libvirt-daemon-driver-storage-disk-10.10.0-7.6.el9_6.x86_64                                                                      149/174
  Installing       : libvirt-daemon-driver-storage-scsi-10.10.0-7.6.el9_6.x86_64                                                                      150/174
  Installing       : libvirt-daemon-driver-storage-rbd-10.10.0-7.6.el9_6.x86_64                                                                       151/174
  Installing       : numad-0.5-37.20150602git.el9.x86_64                                                                                              152/174
  Running scriptlet: numad-0.5-37.20150602git.el9.x86_64                                                                                              152/174
  Installing       : protobuf-c-1.3.3-13.el9.x86_64                                                                                                   153/174
  Running scriptlet: unbound-libs-1.16.2-19.el9_6.1.x86_64                                                                                            154/174
  Installing       : unbound-libs-1.16.2-19.el9_6.1.x86_64                                                                                            154/174
  Running scriptlet: unbound-libs-1.16.2-19.el9_6.1.x86_64                                                                                            154/174
Created symlink /etc/systemd/system/timers.target.wants/unbound-anchor.timer → /usr/lib/systemd/system/unbound-anchor.timer.

  Installing       : gnutls-dane-3.8.3-6.el9.x86_64                                                                                                   155/174
  Installing       : gnutls-utils-3.8.3-6.el9.x86_64                                                                                                  156/174
  Installing       : swtpm-tools-0.8.0-2.el9_4.x86_64                                                                                                 157/174
  Running scriptlet: libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64                                                                              158/174
  Installing       : libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64                                                                              158/174
  Installing       : isns-utils-libs-0.101-4.el9.x86_64                                                                                               159/174
  Installing       : iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64                                                                   160/174
  Running scriptlet: iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64                                                                   160/174
Created symlink /etc/systemd/system/sockets.target.wants/iscsiuio.socket → /usr/lib/systemd/system/iscsiuio.socket.

  Installing       : iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64                                                                            161/174
  Running scriptlet: iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64                                                                            161/174
Created symlink /etc/systemd/system/sysinit.target.wants/iscsi-starter.service → /usr/lib/systemd/system/iscsi-starter.service.
Created symlink /etc/systemd/system/sockets.target.wants/iscsid.socket → /usr/lib/systemd/system/iscsid.socket.
Created symlink /etc/systemd/system/sysinit.target.wants/iscsi-onboot.service → /usr/lib/systemd/system/iscsi-onboot.service.

  Installing       : libvirt-daemon-driver-storage-iscsi-10.10.0-7.6.el9_6.x86_64                                                                     162/174
  Installing       : libvirt-daemon-driver-storage-10.10.0-7.6.el9_6.x86_64                                                                           163/174
  Running scriptlet: opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                   164/174
  Installing       : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                   164/174
  Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                                                                          165/174
  Installing       : opennebula-common-6.10.0.1-1.el9.noarch                                                                                          165/174
  Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                                                                          165/174
  Installing       : libretls-3.8.1-1.el9.x86_64                                                                                                      166/174
  Installing       : libmd-1.1.0-1.el9.x86_64                                                                                                         167/174
  Installing       : libbsd-0.12.2-1.el9.x86_64                                                                                                       168/174
  Installing       : netcat-1.229-1.el9.x86_64                                                                                                        169/174
  Running scriptlet: netcat-1.229-1.el9.x86_64                                                                                                        169/174
  Running scriptlet: libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64                                                                                    170/174
  Installing       : libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64                                                                                    170/174
  Running scriptlet: libvirt-daemon-10.10.0-7.6.el9_6.x86_64                                                                                          171/174
  Installing       : libvirt-daemon-10.10.0-7.6.el9_6.x86_64                                                                                          171/174
  Installing       : libvirt-10.10.0-7.6.el9_6.x86_64                                                                                                 172/174
  Installing       : opennebula-node-kvm-6.10.0.1-1.el9.noarch                                                                                        173/174
  Running scriptlet: opennebula-node-kvm-6.10.0.1-1.el9.noarch                                                                                        173/174
  Installing       : sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64                                                                                            174/174
  Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                                                                                174/174
  Running scriptlet: swtpm-0.8.0-2.el9_4.x86_64                                                                                                       174/174
  Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch                                                                                             174/174
  Running scriptlet: libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64                                                                                     174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtlockd.socket → /usr/lib/systemd/system/virtlockd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtlockd-admin.socket → /usr/lib/systemd/system/virtlockd-admin.socket.

  Running scriptlet: libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64                                                                                      174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtlogd.socket → /usr/lib/systemd/system/virtlogd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtlogd-admin.socket → /usr/lib/systemd/system/virtlogd-admin.socket.

  Running scriptlet: libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64                                                                                   174/174
  Running scriptlet: libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd.socket → /usr/lib/systemd/system/virtnwfilterd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd-ro.socket → /usr/lib/systemd/system/virtnwfilterd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd-admin.socket → /usr/lib/systemd/system/virtnwfilterd-admin.socket.

  Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                                                                           174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd.socket → /usr/lib/systemd/system/virtnetworkd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd-ro.socket → /usr/lib/systemd/system/virtnetworkd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd-admin.socket → /usr/lib/systemd/system/virtnetworkd-admin.socket.

  Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64                                                                           174/174
  Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          174/174
  Running scriptlet: libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64                                                                           174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd.socket → /usr/lib/systemd/system/virtnodedevd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd-ro.socket → /usr/lib/systemd/system/virtnodedevd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd-admin.socket → /usr/lib/systemd/system/virtnodedevd-admin.socket.

  Running scriptlet: libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64                                                                         174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced.socket → /usr/lib/systemd/system/virtinterfaced.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced-ro.socket → /usr/lib/systemd/system/virtinterfaced-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced-admin.socket → /usr/lib/systemd/system/virtinterfaced-admin.socket.

  Running scriptlet: libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64                                                                            174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd.socket → /usr/lib/systemd/system/virtsecretd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd-ro.socket → /usr/lib/systemd/system/virtsecretd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd-admin.socket → /usr/lib/systemd/system/virtsecretd-admin.socket.

  Running scriptlet: libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64                                                                      174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged.socket → /usr/lib/systemd/system/virtstoraged.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged-ro.socket → /usr/lib/systemd/system/virtstoraged-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged-admin.socket → /usr/lib/systemd/system/virtstoraged-admin.socket.

  Running scriptlet: libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64                                                                              174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtqemud.socket → /usr/lib/systemd/system/virtqemud.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtqemud-ro.socket → /usr/lib/systemd/system/virtqemud-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtqemud-admin.socket → /usr/lib/systemd/system/virtqemud-admin.socket.
Created symlink /etc/systemd/system/multi-user.target.wants/virtqemud.service → /usr/lib/systemd/system/virtqemud.service.

  Running scriptlet: libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64                                                                                    174/174
Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd.socket → /usr/lib/systemd/system/virtproxyd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd-ro.socket → /usr/lib/systemd/system/virtproxyd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd-admin.socket → /usr/lib/systemd/system/virtproxyd-admin.socket.

  Running scriptlet: libvirt-daemon-10.10.0-7.6.el9_6.x86_64                                                                                          174/174
  Running scriptlet: sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64                                                                                            174/174
/usr/lib/sysusers.d/libvirt-qemu.conf:1: Conflict with earlier configuration for group 'kvm', ignoring line.

Couldn't write '1' to 'net/bridge/bridge-nf-call-arptables', ignoring: No such file or directory
Couldn't write '1' to 'net/bridge/bridge-nf-call-ip6tables', ignoring: No such file or directory
Couldn't write '1' to 'net/bridge/bridge-nf-call-iptables', ignoring: No such file or directory

  Verifying        : libbsd-0.12.2-1.el9.x86_64                                                                                                         1/174
  Verifying        : libmd-1.1.0-1.el9.x86_64                                                                                                           2/174
  Verifying        : libretls-3.8.1-1.el9.x86_64                                                                                                        3/174
  Verifying        : netcat-1.229-1.el9.x86_64                                                                                                          4/174
  Verifying        : rubygem-sqlite3-1.4.2-8.el9.x86_64                                                                                                 5/174
  Verifying        : opennebula-common-6.10.0.1-1.el9.noarch                                                                                            6/174
  Verifying        : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                                                                                     7/174
  Verifying        : opennebula-node-kvm-6.10.0.1-1.el9.noarch                                                                                          8/174
  Verifying        : opennebula-rubygems-6.10.0.1-1.el9.x86_64                                                                                          9/174
  Verifying        : python3-pycparser-2.20-6.el9.noarch                                                                                               10/174
  Verifying        : isns-utils-libs-0.101-4.el9.x86_64                                                                                                11/174
  Verifying        : protobuf-c-1.3.3-13.el9.x86_64                                                                                                    12/174
  Verifying        : sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64                                                                                             13/174
  Verifying        : numad-0.5-37.20150602git.el9.x86_64                                                                                               14/174
  Verifying        : python3-pyyaml-5.4.1-6.el9.x86_64                                                                                                 15/174
  Verifying        : iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64                                                                             16/174
  Verifying        : python3-cryptography-36.0.1-4.el9.x86_64                                                                                          17/174
  Verifying        : lzop-1.04-8.el9.x86_64                                                                                                            18/174
  Verifying        : librdmacm-54.0-1.el9.x86_64                                                                                                       19/174
  Verifying        : cyrus-sasl-gssapi-2.1.27-21.el9.x86_64                                                                                            20/174
  Verifying        : device-mapper-multipath-libs-0.8.7-35.el9_6.1.x86_64                                                                              21/174
  Verifying        : quota-1:4.09-4.el9.x86_64                                                                                                         22/174
  Verifying        : python3-ply-3.11-14.el9.0.1.noarch                                                                                                23/174
  Verifying        : iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64                                                                    24/174
  Verifying        : libpciaccess-0.16-7.el9.x86_64                                                                                                    25/174
  Verifying        : quota-nls-1:4.09-4.el9.noarch                                                                                                     26/174
  Verifying        : gssproxy-0.8.4-7.el9.x86_64                                                                                                       27/174
  Verifying        : dmidecode-1:3.6-1.el9.x86_64                                                                                                      28/174
  Verifying        : json-glib-1.6.6-1.el9.x86_64                                                                                                      29/174
  Verifying        : ndctl-libs-78-2.el9.x86_64                                                                                                        30/174
  Verifying        : libibverbs-54.0-1.el9.x86_64                                                                                                      31/174
  Verifying        : libev-4.33-6.el9.x86_64                                                                                                           32/174
  Verifying        : libverto-libev-0.3.2-3.el9.x86_64                                                                                                 33/174
  Verifying        : python3-cffi-1.14.5-5.el9.x86_64                                                                                                  34/174
  Verifying        : libpcap-14:1.10.0-4.el9.x86_64                                                                                                    35/174
  Verifying        : nfs-utils-1:2.5.4-34.el9.x86_64                                                                                                   36/174
  Verifying        : systemd-container-252-51.el9_6.1.x86_64                                                                                           37/174
  Verifying        : rpcbind-1.2.6-7.el9.x86_64                                                                                                        38/174
  Verifying        : pciutils-3.7.0-7.el9.x86_64                                                                                                       39/174
  Verifying        : zstd-1.5.5-1.el9.x86_64                                                                                                           40/174
  Verifying        : libnfsidmap-1:2.5.4-34.el9.x86_64                                                                                                 41/174
  Verifying        : daxctl-libs-78-2.el9.x86_64                                                                                                       42/174
  Verifying        : bzip2-1.0.8-10.el9_5.x86_64                                                                                                       43/174
  Verifying        : rsync-3.2.5-3.el9.x86_64                                                                                                          44/174
  Verifying        : libusbx-1.0.26-1.el9.x86_64                                                                                                       45/174
  Verifying        : libslirp-4.4.0-8.el9.x86_64                                                                                                       46/174
  Verifying        : libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_6.x86_64                                                                              47/174
  Verifying        : dnsmasq-2.85-16.el9_4.x86_64                                                                                                      48/174
  Verifying        : flac-libs-1.3.3-10.el9_2.1.x86_64                                                                                                 49/174
  Verifying        : rubygem-json-2.5.1-165.el9_5.x86_64                                                                                               50/174
  Verifying        : libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64                                                                                     51/174
  Verifying        : libXxf86vm-1.1.4-18.el9.x86_64                                                                                                    52/174
  Verifying        : passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                                                                                 53/174
  Verifying        : libglvnd-1:1.3.4-1.el9.x86_64                                                                                                     54/174
  Verifying        : virtiofsd-1.13.2-1.el9_6.x86_64                                                                                                   55/174
  Verifying        : libwayland-client-1.21.0-1.el9.x86_64                                                                                             56/174
  Verifying        : libvirt-daemon-10.10.0-7.6.el9_6.x86_64                                                                                           57/174
  Verifying        : libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64                                                                                      58/174
  Verifying        : libvirt-libs-10.10.0-7.6.el9_6.x86_64                                                                                             59/174
  Verifying        : rubygem-bundler-2.2.33-165.el9_5.noarch                                                                                           60/174
  Verifying        : swtpm-0.8.0-2.el9_4.x86_64                                                                                                        61/174
  Verifying        : swtpm-tools-0.8.0-2.el9_4.x86_64                                                                                                  62/174
  Verifying        : nbdkit-selinux-1.38.5-5.el9_6.noarch                                                                                              63/174
  Verifying        : libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64                                                                            64/174
  Verifying        : passt-0^20250217.ga1e48a0-10.el9_6.x86_64                                                                                         65/174
  Verifying        : libX11-common-1.7.0-11.el9.noarch                                                                                                 66/174
  Verifying        : qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_64                                                                                     67/174
  Verifying        : libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64                                                                                       68/174
  Verifying        : libXau-1.0.9-8.el9.x86_64                                                                                                         69/174
  Verifying        : mesa-libGL-24.2.8-2.el9_6.x86_64                                                                                                  70/174
  Verifying        : augeas-libs-1.14.1-2.el9.x86_64                                                                                                   71/174
  Verifying        : mesa-libglapi-24.2.8-2.el9_6.x86_64                                                                                               72/174
  Verifying        : libnbd-1.20.3-1.el9.x86_64                                                                                                        73/174
  Verifying        : ruby-3.0.7-165.el9_5.x86_64                                                                                                       74/174
  Verifying        : boost-thread-1.75.0-10.el9.x86_64                                                                                                 75/174
  Verifying        : libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.x86_64                                                                                76/174
  Verifying        : seavgabios-bin-1.16.3-4.el9.noarch                                                                                                77/174
  Verifying        : liburing-2.5-1.el9.x86_64                                                                                                         78/174
  Verifying        : nbdkit-server-1.38.5-5.el9_6.x86_64                                                                                               79/174
  Verifying        : libXext-1.3.4-8.el9.x86_64                                                                                                        80/174
  Verifying        : libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64                                                                            81/174
  Verifying        : qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64                                                                                          82/174
  Verifying        : scrub-2.6.1-4.el9.x86_64                                                                                                          83/174
  Verifying        : libxshmfence-1.3-10.el9.x86_64                                                                                                    84/174
  Verifying        : qemu-kvm-device-display-virtio-gpu-17:9.1.0-15.el9_6.7.x86_64                                                                     85/174
  Verifying        : libvirt-daemon-driver-storage-mpath-10.10.0-7.6.el9_6.x86_64                                                                      86/174
  Verifying        : rubygem-rdoc-6.3.4.1-165.el9_5.noarch                                                                                             87/174
  Verifying        : libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64                                                                       88/174
  Verifying        : qemu-kvm-device-usb-redirect-17:9.1.0-15.el9_6.7.x86_64                                                                           89/174
  Verifying        : libvirt-daemon-driver-storage-iscsi-10.10.0-7.6.el9_6.x86_64                                                                      90/174
  Verifying        : libvirt-client-10.10.0-7.6.el9_6.x86_64                                                                                           91/174
  Verifying        : ipxe-roms-qemu-20200823-9.git4bd064de.el9.noarch                                                                                  92/174
  Verifying        : libX11-xcb-1.7.0-11.el9.x86_64                                                                                                    93/174
  Verifying        : mesa-libgbm-24.2.8-2.el9_6.x86_64                                                                                                 94/174
  Verifying        : libglvnd-glx-1:1.3.4-1.el9.x86_64                                                                                                 95/174
  Verifying        : libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                           96/174
  Verifying        : capstone-4.0.2-10.el9.x86_64                                                                                                      97/174
  Verifying        : libepoxy-1.5.5-4.el9.x86_64                                                                                                       98/174
  Verifying        : libvirt-daemon-driver-storage-logical-10.10.0-7.6.el9_6.x86_64                                                                    99/174
  Verifying        : xkeyboard-config-2.33-2.el9.noarch                                                                                               100/174
  Verifying        : nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64                                                                                         101/174
  Verifying        : libglvnd-egl-1:1.3.4-1.el9.x86_64                                                                                                102/174
  Verifying        : qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7.x86_64                                                                              103/174
  Verifying        : qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64                                                                                         104/174
  Verifying        : libxcb-1.13.1-9.el9.x86_64                                                                                                       105/174
  Verifying        : rubygems-3.2.33-165.el9_5.noarch                                                                                                 106/174
  Verifying        : qemu-kvm-17:9.1.0-15.el9_6.7.x86_64                                                                                              107/174
  Verifying        : qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64                                                                                        108/174
  Verifying        : libpmem-1.12.1-1.el9.x86_64                                                                                                      109/174
  Verifying        : gnutls-dane-3.8.3-6.el9.x86_64                                                                                                   110/174
  Verifying        : pulseaudio-libs-15.0-3.el9.x86_64                                                                                                111/174
  Verifying        : augeas-1.14.1-2.el9.x86_64                                                                                                       112/174
  Verifying        : swtpm-libs-0.8.0-2.el9_4.x86_64                                                                                                  113/174
  Verifying        : libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64                                                                                   114/174
  Verifying        : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                                                                              115/174
  Verifying        : libvirt-daemon-driver-storage-disk-10.10.0-7.6.el9_6.x86_64                                                                      116/174
  Verifying        : rubygem-bigdecimal-3.0.0-165.el9_5.x86_64                                                                                        117/174
  Verifying        : unbound-libs-1.16.2-19.el9_6.1.x86_64                                                                                            118/174
  Verifying        : nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64                                                                                          119/174
  Verifying        : libdrm-2.4.123-2.el9.x86_64                                                                                                      120/174
  Verifying        : qemu-kvm-device-display-virtio-vga-17:9.1.0-15.el9_6.7.x86_64                                                                    121/174
  Verifying        : boost-iostreams-1.75.0-10.el9.x86_64                                                                                             122/174
  Verifying        : gsm-1.0.19-6.el9.x86_64                                                                                                          123/174
  Verifying        : ruby-default-gems-3.0.7-165.el9_5.noarch                                                                                         124/174
  Verifying        : rubygem-io-console-0.5.7-165.el9_5.x86_64                                                                                        125/174
  Verifying        : opus-1.3.1-10.el9.x86_64                                                                                                         126/174
  Verifying        : libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64                                                                         127/174
  Verifying        : usbredir-0.13.0-2.el9.x86_64                                                                                                     128/174
  Verifying        : rubygem-rexml-3.2.5-165.el9_5.noarch                                                                                             129/174
  Verifying        : libogg-2:1.3.4-6.el9.x86_64                                                                                                      130/174
  Verifying        : boost-system-1.75.0-10.el9.x86_64                                                                                                131/174
  Verifying        : rubygem-psych-3.3.2-165.el9_5.x86_64                                                                                             132/174
  Verifying        : libXfixes-5.0.3-16.el9.x86_64                                                                                                    133/174
  Verifying        : qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7.x86_64                                                                              134/174
  Verifying        : qemu-kvm-device-display-virtio-gpu-pci-17:9.1.0-15.el9_6.7.x86_64                                                                135/174
  Verifying        : libasyncns-0.8-22.el9.x86_64                                                                                                     136/174
  Verifying        : libvorbis-1:1.3.7-5.el9.x86_64                                                                                                   137/174
  Verifying        : seabios-bin-1.16.3-4.el9.noarch                                                                                                  138/174
  Verifying        : nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64                                                                                       139/174
  Verifying        : gnutls-utils-3.8.3-6.el9.x86_64                                                                                                  140/174
  Verifying        : libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                                                                          141/174
  Verifying        : ruby-libs-3.0.7-165.el9_5.x86_64                                                                                                 142/174
  Verifying        : qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86_64                                                                                  143/174
  Verifying        : libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64                                                                            144/174
  Verifying        : libblkio-1.5.0-1.el9_4.x86_64                                                                                                    145/174
  Verifying        : mdevctl-1.1.0-4.el9.x86_64                                                                                                       146/174
  Verifying        : libsndfile-1.0.31-9.el9.x86_64                                                                                                   147/174
  Verifying        : python3-libvirt-10.10.0-1.el9.x86_64                                                                                             148/174
  Verifying        : mesa-libEGL-24.2.8-2.el9_6.x86_64                                                                                                149/174
  Verifying        : libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64                                                                              150/174
  Verifying        : mesa-filesystem-24.2.8-2.el9_6.x86_64                                                                                            151/174
  Verifying        : libvirt-daemon-driver-storage-scsi-10.10.0-7.6.el9_6.x86_64                                                                      152/174
  Verifying        : qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64                                                                                        153/174
  Verifying        : edk2-ovmf-20241117-2.el9.noarch                                                                                                  154/174
  Verifying        : libwayland-server-1.21.0-1.el9.x86_64                                                                                            155/174
  Verifying        : nbdkit-1.38.5-5.el9_6.x86_64                                                                                                     156/174
  Verifying        : librados2-2:16.2.4-5.el9.x86_64                                                                                                  157/174
  Verifying        : libvirt-daemon-driver-storage-10.10.0-7.6.el9_6.x86_64                                                                           158/174
  Verifying        : libxkbcommon-1.0.3-4.el9.x86_64                                                                                                  159/174
  Verifying        : qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64                                                                                     160/174
  Verifying        : libvirt-daemon-driver-storage-rbd-10.10.0-7.6.el9_6.x86_64                                                                       161/174
  Verifying        : librbd1-2:16.2.4-5.el9.x86_64                                                                                                    162/174
  Verifying        : libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                                                                           163/174
  Verifying        : qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_64                                                                                    164/174
  Verifying        : libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64                                                                                     165/174
  Verifying        : libfdt-1.6.0-7.el9.x86_64                                                                                                        166/174
  Verifying        : libvirt-10.10.0-7.6.el9_6.x86_64                                                                                                 167/174
  Verifying        : mesa-dri-drivers-24.2.8-2.el9_6.x86_64                                                                                           168/174
  Verifying        : nbdkit-basic-filters-1.38.5-5.el9_6.x86_64                                                                                       169/174
  Verifying        : pixman-0.40.0-6.el9_3.x86_64                                                                                                     170/174
  Verifying        : python3-lxml-4.6.5-3.el9.x86_64                                                                                                  171/174
  Verifying        : libxslt-1.1.34-13.el9_6.x86_64                                                                                                   172/174
  Verifying        : qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64                                                                                       173/174
  Verifying        : libX11-1.7.0-11.el9.x86_64                                                                                                       174/174

Installed:
  augeas-1.14.1-2.el9.x86_64                                                      augeas-libs-1.14.1-2.el9.x86_64
  boost-iostreams-1.75.0-10.el9.x86_64                                            boost-system-1.75.0-10.el9.x86_64
  boost-thread-1.75.0-10.el9.x86_64                                               bzip2-1.0.8-10.el9_5.x86_64
  capstone-4.0.2-10.el9.x86_64                                                    cyrus-sasl-gssapi-2.1.27-21.el9.x86_64
  daxctl-libs-78-2.el9.x86_64                                                     device-mapper-multipath-libs-0.8.7-35.el9_6.1.x86_64
  dmidecode-1:3.6-1.el9.x86_64                                                    dnsmasq-2.85-16.el9_4.x86_64
  edk2-ovmf-20241117-2.el9.noarch                                                 flac-libs-1.3.3-10.el9_2.1.x86_64
  gnutls-dane-3.8.3-6.el9.x86_64                                                  gnutls-utils-3.8.3-6.el9.x86_64
  gsm-1.0.19-6.el9.x86_64                                                         gssproxy-0.8.4-7.el9.x86_64
  ipxe-roms-qemu-20200823-9.git4bd064de.el9.noarch                                iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64
  iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64                  isns-utils-libs-0.101-4.el9.x86_64
  json-glib-1.6.6-1.el9.x86_64                                                    libX11-1.7.0-11.el9.x86_64
  libX11-common-1.7.0-11.el9.noarch                                               libX11-xcb-1.7.0-11.el9.x86_64
  libXau-1.0.9-8.el9.x86_64                                                       libXext-1.3.4-8.el9.x86_64
  libXfixes-5.0.3-16.el9.x86_64                                                   libXxf86vm-1.1.4-18.el9.x86_64
  libasyncns-0.8-22.el9.x86_64                                                    libblkio-1.5.0-1.el9_4.x86_64
  libbsd-0.12.2-1.el9.x86_64                                                      libdrm-2.4.123-2.el9.x86_64
  libepoxy-1.5.5-4.el9.x86_64                                                     libev-4.33-6.el9.x86_64
  libfdt-1.6.0-7.el9.x86_64                                                       libglvnd-1:1.3.4-1.el9.x86_64
  libglvnd-egl-1:1.3.4-1.el9.x86_64                                               libglvnd-glx-1:1.3.4-1.el9.x86_64
  libibverbs-54.0-1.el9.x86_64                                                    libmd-1.1.0-1.el9.x86_64
  libnbd-1.20.3-1.el9.x86_64                                                      libnfsidmap-1:2.5.4-34.el9.x86_64
  libogg-2:1.3.4-6.el9.x86_64                                                     libpcap-14:1.10.0-4.el9.x86_64
  libpciaccess-0.16-7.el9.x86_64                                                  libpmem-1.12.1-1.el9.x86_64
  librados2-2:16.2.4-5.el9.x86_64                                                 librbd1-2:16.2.4-5.el9.x86_64
  librdmacm-54.0-1.el9.x86_64                                                     libretls-3.8.1-1.el9.x86_64
  libslirp-4.4.0-8.el9.x86_64                                                     libsndfile-1.0.31-9.el9.x86_64
  libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.x86_64                              liburing-2.5-1.el9.x86_64
  libusbx-1.0.26-1.el9.x86_64                                                     libverto-libev-0.3.2-3.el9.x86_64
  libvirt-10.10.0-7.6.el9_6.x86_64                                                libvirt-client-10.10.0-7.6.el9_6.x86_64
  libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64                                    libvirt-daemon-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64                                  libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64                         libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64                          libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64                         libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64                           libvirt-daemon-driver-storage-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64                     libvirt-daemon-driver-storage-disk-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-storage-iscsi-10.10.0-7.6.el9_6.x86_64                    libvirt-daemon-driver-storage-logical-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-storage-mpath-10.10.0-7.6.el9_6.x86_64                    libvirt-daemon-driver-storage-rbd-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-driver-storage-scsi-10.10.0-7.6.el9_6.x86_64                     libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64                                     libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_6.x86_64
  libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64                                   libvirt-libs-10.10.0-7.6.el9_6.x86_64
  libvorbis-1:1.3.7-5.el9.x86_64                                                  libwayland-client-1.21.0-1.el9.x86_64
  libwayland-server-1.21.0-1.el9.x86_64                                           libxcb-1.13.1-9.el9.x86_64
  libxkbcommon-1.0.3-4.el9.x86_64                                                 libxshmfence-1.3-10.el9.x86_64
  libxslt-1.1.34-13.el9_6.x86_64                                                  lzop-1.04-8.el9.x86_64
  mdevctl-1.1.0-4.el9.x86_64                                                      mesa-dri-drivers-24.2.8-2.el9_6.x86_64
  mesa-filesystem-24.2.8-2.el9_6.x86_64                                           mesa-libEGL-24.2.8-2.el9_6.x86_64
  mesa-libGL-24.2.8-2.el9_6.x86_64                                                mesa-libgbm-24.2.8-2.el9_6.x86_64
  mesa-libglapi-24.2.8-2.el9_6.x86_64                                             nbdkit-1.38.5-5.el9_6.x86_64
  nbdkit-basic-filters-1.38.5-5.el9_6.x86_64                                      nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64
  nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64                                        nbdkit-selinux-1.38.5-5.el9_6.noarch
  nbdkit-server-1.38.5-5.el9_6.x86_64                                             nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64
  ndctl-libs-78-2.el9.x86_64                                                      netcat-1.229-1.el9.x86_64
  nfs-utils-1:2.5.4-34.el9.x86_64                                                 numad-0.5-37.20150602git.el9.x86_64
  opennebula-common-6.10.0.1-1.el9.noarch                                         opennebula-common-onecfg-6.10.0.1-1.el9.noarch
  opennebula-node-kvm-6.10.0.1-1.el9.noarch                                       opennebula-rubygems-6.10.0.1-1.el9.x86_64
  opus-1.3.1-10.el9.x86_64                                                        passt-0^20250217.ga1e48a0-10.el9_6.x86_64
  passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch                               pciutils-3.7.0-7.el9.x86_64
  pixman-0.40.0-6.el9_3.x86_64                                                    protobuf-c-1.3.3-13.el9.x86_64
  pulseaudio-libs-15.0-3.el9.x86_64                                               python3-cffi-1.14.5-5.el9.x86_64
  python3-cryptography-36.0.1-4.el9.x86_64                                        python3-libvirt-10.10.0-1.el9.x86_64
  python3-lxml-4.6.5-3.el9.x86_64                                                 python3-ply-3.11-14.el9.0.1.noarch
  python3-pycparser-2.20-6.el9.noarch                                             python3-pyyaml-5.4.1-6.el9.x86_64
  qemu-img-17:9.1.0-15.el9_6.7.x86_64                                             qemu-kvm-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64                                    qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_64                                   qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64                                        qemu-kvm-device-display-virtio-gpu-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-device-display-virtio-gpu-pci-17:9.1.0-15.el9_6.7.x86_64               qemu-kvm-device-display-virtio-vga-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7.x86_64                             qemu-kvm-device-usb-redirect-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64                                        qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64
  qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7.x86_64                             qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_64
  qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64                                       quota-1:4.09-4.el9.x86_64
  quota-nls-1:4.09-4.el9.noarch                                                   rpcbind-1.2.6-7.el9.x86_64
  rsync-3.2.5-3.el9.x86_64                                                        ruby-3.0.7-165.el9_5.x86_64
  ruby-default-gems-3.0.7-165.el9_5.noarch                                        ruby-libs-3.0.7-165.el9_5.x86_64
  rubygem-bigdecimal-3.0.0-165.el9_5.x86_64                                       rubygem-bundler-2.2.33-165.el9_5.noarch
  rubygem-io-console-0.5.7-165.el9_5.x86_64                                       rubygem-json-2.5.1-165.el9_5.x86_64
  rubygem-psych-3.3.2-165.el9_5.x86_64                                            rubygem-rdoc-6.3.4.1-165.el9_5.noarch
  rubygem-rexml-3.2.5-165.el9_5.noarch                                            rubygem-sqlite3-1.4.2-8.el9.x86_64
  rubygems-3.2.33-165.el9_5.noarch                                                scrub-2.6.1-4.el9.x86_64
  seabios-bin-1.16.3-4.el9.noarch                                                 seavgabios-bin-1.16.3-4.el9.noarch
  sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64                                           swtpm-0.8.0-2.el9_4.x86_64
  swtpm-libs-0.8.0-2.el9_4.x86_64                                                 swtpm-tools-0.8.0-2.el9_4.x86_64
  systemd-container-252-51.el9_6.1.x86_64                                         unbound-libs-1.16.2-19.el9_6.1.x86_64
  usbredir-0.13.0-2.el9.x86_64                                                    virtiofsd-1.13.2-1.el9_6.x86_64
  xkeyboard-config-2.33-2.el9.noarch                                              zstd-1.5.5-1.el9.x86_64

Complete!
```
Installation des dépendances additionnelles
```shell
#commande
sudo dnf install -y genisoimage

#résultat
Last metadata expiration check: 0:08:02 ago on Mon 15 Sep 2025 02:03:39 PM EDT.
Dependencies resolved.
==============================================================================================================================================================
 Package                                 Architecture                       Version                                    Repository                        Size
==============================================================================================================================================================
Installing:
 genisoimage                             x86_64                             1.1.11-48.el9                              epel                             324 k
Installing dependencies:
 libusal                                 x86_64                             1.1.11-48.el9                              epel                             137 k

Transaction Summary
==============================================================================================================================================================
Install  2 Packages

Total download size: 461 k
Installed size: 1.6 M
Downloading Packages:
(1/2): libusal-1.1.11-48.el9.x86_64.rpm                                                                                        17 kB/s | 137 kB     00:08
(2/2): genisoimage-1.1.11-48.el9.x86_64.rpm                                                                                    40 kB/s | 324 kB     00:08
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                          28 kB/s | 461 kB     00:16
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                      1/1
  Installing       : libusal-1.1.11-48.el9.x86_64                                                                                                         1/2
  Installing       : genisoimage-1.1.11-48.el9.x86_64                                                                                                     2/2
  Running scriptlet: genisoimage-1.1.11-48.el9.x86_64                                                                                                     2/2
  Verifying        : genisoimage-1.1.11-48.el9.x86_64                                                                                                     1/2
  Verifying        : libusal-1.1.11-48.el9.x86_64                                                                                                         2/2

Installed:
  genisoimage-1.1.11-48.el9.x86_64                                                libusal-1.1.11-48.el9.x86_64

Complete!
```
Démarrage du service libvirtd
```shell
#commande
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
#résultat
Created symlink /etc/systemd/system/multi-user.target.wants/libvirtd.service → /usr/lib/systemd/system/libvirtd.service.
Created symlink /etc/systemd/system/sockets.target.wants/libvirtd.socket → /usr/lib/systemd/system/libvirtd.socket.
Created symlink /etc/systemd/system/sockets.target.wants/libvirtd-ro.socket → /usr/lib/systemd/system/libvirtd-ro.socket.
Created symlink /etc/systemd/system/sockets.target.wants/libvirtd-admin.socket → /usr/lib/systemd/system/libvirtd-admin.socket.
```


#### B. Système ####
Ouverture Firewall
```shell
#commande
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --permanent --add-port=8472/udp

#résultat
success
success
```

Handle SSH

Création clé SSH
```shell
#commande
ssh-keygen -t Ed25519

#résultat
Generating public/private Ed25519 key pair.
Enter file in which to save the key (/home/oneadmin/.ssh/id_ed25519):
Created directory '/home/oneadmin/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/oneadmin/.ssh/id_ed25519
Your public key has been saved in /home/oneadmin/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:PQUJryXw8lW80Oh4eLrgZnjef1pylXj4mC+6D0GO2Q4 oneadmin@frontend.one
The key's randomart image is:
+--[ED25519 256]--+
|      . ...=.    |
|       o .+oo    |
|      . o+=...   |
|       oo%+..o . |
|        E+* o +  |
|      . .o o *   |
|     o . .+ = .  |
|    . =..  =o.   |
|     =. ..=*...  |
+----[SHA256]-----+
```
Ajout de la clé sur kvm1
```shell
#commande
ssh-copy-id -i ~/.ssh/id_ed25519 oneadmin@kvm1.one

#résultat
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/oneadmin/.ssh/id_ed25519.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
oneadmin@kvm1.one's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'oneadmin@kvm1.one'"
and check to make sure that only the key(s) you wanted were added.
```


Test ssh depuis frontend.one
```shell
#commande
ssh oneadmin@kvm1.one
Last login: Mon Sep 15 14:56:22 2025 from 10.3.1.10

#résultat
[oneadmin@kvm1 ~]$
```
```shell

```
Trust l'empreinte de kvm1 

```shell
#commande
ssh-keyscan -t ed25519 kvm1.one >> ~/.ssh/known_hosts 2>/dev/null
```
### 3. Réseau ###
#### C. Préparer le bridge réseau ####

Création et configuration du bridge Linux

```shell
#commandes
sudo vi /opt/vxlan.sh
```

contenu du fichier vxlan.sh
```shell
# création du bridge
ip link add name vxlan_bridge type bridge

# on allume le bridge
ip link set dev vxlan_bridge up

# on définit une IP sur cette interface bridge
ip addr add 10.220.220.201/24 dev vxlan_bridge

# ajout de l'interface bridge à la zone public de firewalld
firewall-cmd --add-interface=vxlan_bridge --zone=public --permanent

# activation du masquerading NAT dans cette zone
firewall-cmd --add-masquerade --permanent

# on reload le firewall pour que les deux commandes précédentes prennent effet
firewall-cmd --reload
```

rendre le script exécutable
```shell
#commandes
  sudo chmod +x /opt/vxlan.sh
```
Création d'un service pour le script
```shell
#commande
sudo vi /etc/systemd/system/vxlan.service

#contenu du fichier
[Unit]
Description=Setup VXLAN interface for ONE

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash /opt/vxlan.sh

[Install]
WantedBy=multi-user.target
```


Démarrage du script au démarrage
```shell
#commande
sudo systemctl daemon-reload
sudo systemctl start vxlan
sudo systemctl enable vxlan
```

## III. Utiliser la plateforme ##

Ping de la vm depuis kvm1
```shell
#commande
[jacques@kvm1 ~]$ ping 10.220.220.1

#résultat
PING 10.220.220.1 (10.220.220.1) 56(84) bytes of data.
64 bytes from 10.220.220.1: icmp_seq=1 ttl=64 time=19.6 ms
64 bytes from 10.220.220.1: icmp_seq=2 ttl=64 time=0.781 ms
64 bytes from 10.220.220.1: icmp_seq=3 ttl=64 time=0.810 ms
64 bytes from 10.220.220.1: icmp_seq=4 ttl=64 time=0.718 ms
64 bytes from 10.220.220.1: icmp_seq=5 ttl=64 time=0.975 ms
^C
--- 10.220.220.1 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4007ms
rtt min/avg/max/mdev = 0.718/4.570/19.568/7.499 ms
```

Connexion à la VM en SSH
```shell
#commande
eval $(ssh-agent)
```

```shell
#commande
ssh-add

#résultat
Identity added: /var/lib/one/.ssh/id_rsa (oneadmin@frontend)
```

```shell
#commande
ssh -J kvm1 root@10.220.220.1

#résultat
Warning: Permanently added '10.220.220.1' (ED25519) to the list of known hosts.
[root@localhost ~]#
```

Ajout de la route pour sortir vers internet
```bash
[root@localhost ~]# ip route add default via 10.220.220.201
[root@localhost ~]# ping 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=254 time=25.8 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=254 time=25.2 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=254 time=50.3 ms
^C
--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2006ms
rtt min/avg/max/mdev = 25.165/33.766/50.303/11.696 ms
[root@localhost ~]#

```
## IV. Ajout d'un noeud et VXLAN ##
### 1. Ajout d'un noeud ###
Paramétrage du second noeud en miroir du premier sauf les adresses ip
```shell
#commande
[jacques@kvm2 ~]$ nmcli

#résultat
enp0s3: connected to enp0s3
        "Intel 82540EM"
        ethernet (e1000), 08:00:27:3A:AB:66, hw, mtu 1500
        ip4 default, ip6 default
        inet4 10.0.2.15/24
        route4 10.0.2.0/24 metric 100
        route4 default via 10.0.2.2 metric 100
        inet6 fd17:625c:f037:2:a00:27ff:fe3a:ab66/64
        inet6 fe80::a00:27ff:fe3a:ab66/64
        route6 fe80::/64 metric 1024
        route6 fd17:625c:f037:2::/64 metric 100
        route6 default via fe80::2 metric 100

enp0s8: connected to enp0s8
        "Intel 82540EM"
        ethernet (e1000), 08:00:27:F6:17:44, hw, mtu 1500
        inet4 10.3.1.12/24
        route4 10.3.1.0/24 metric 101

vxlan_bridge: connected (externally) to vxlan_bridge
        "vxlan_bridge"
        bridge, 9A:E0:13:E1:B4:B4, sw, mtu 1500
        inet4 10.220.220.202/24
        route4 10.220.220.0/24 metric 0
        inet6 fe80::98e0:13ff:fee1:b4b4/64
        route6 fe80::/64 metric 256
```
### 2. VM sur le deuxième noeud ###
```shell
#commande
[oneadmin@frontend ~]$ ssh -J kvm2 root@10.220.220.2

#résultat
Warning: Permanently added '10.220.220.2' (ED25519) to the list of known hosts.
Activate the web console with: systemctl enable --now cockpit.socket

[root@localhost ~]#
```

### 3. Connectivité entre les VMs ###
```shell
[root@localhost ~]# ping 10.220.220.1
PING 10.220.220.1 (10.220.220.1) 56(84) bytes of data.
64 bytes from 10.220.220.1: icmp_seq=1 ttl=64 time=4.44 ms
64 bytes from 10.220.220.1: icmp_seq=2 ttl=64 time=0.941 ms
64 bytes from 10.220.220.1: icmp_seq=3 ttl=64 time=3.74 ms
^C
--- 10.220.220.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2194ms
rtt min/avg/max/mdev = 0.941/3.042/4.444/1.513 ms
[root@localhost ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 02:00:0a:dc:dc:02 brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    altname ens3
    inet 10.220.220.2/24 brd 10.220.220.255 scope global noprefixroute eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::aff:fedc:dc02/64 scope link
       valid_lft forever preferred_lft forever
[root@localhost ~]#
```

### 4. Inspection du trafic ###
Installation de tcpdump
```shell
#commande
[jacques@kvm1 ~]$ sudo dnf install tcpdump

#résultat
[sudo] password for jacques:
Last metadata expiration check: 2:28:07 ago on Wed Sep 17 09:07:16 2025.
Dependencies resolved.
==============================================================================================================================================================
 Package                            Architecture                      Version                                      Repository                            Size
==============================================================================================================================================================
Installing:
 tcpdump                            x86_64                            14:4.99.0-9.el9                              appstream                            542 k

Transaction Summary
==============================================================================================================================================================
Install  1 Package

Total download size: 542 k
Installed size: 1.4 M
Is this ok [y/N]: y
Downloading Packages:
tcpdump-4.99.0-9.el9.x86_64.rpm                                                                                               1.1 MB/s | 542 kB     00:00
--------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                         641 kB/s | 542 kB     00:00
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                      1/1
  Running scriptlet: tcpdump-14:4.99.0-9.el9.x86_64                                                                                                       1/1
  Installing       : tcpdump-14:4.99.0-9.el9.x86_64                                                                                                       1/1
  Running scriptlet: tcpdump-14:4.99.0-9.el9.x86_64                                                                                                       1/1
  Verifying        : tcpdump-14:4.99.0-9.el9.x86_64                                                                                                       1/1

Installed:
  tcpdump-14:4.99.0-9.el9.x86_64

Complete!
```
Utilisation du tcpdump sur enp0s8
```shell
#commande
sudo tcpdump -i enp0s8 -w yo.pcap

#résultat
dropped privs to tcpdump
tcpdump: listening on enp0s8, link-type EN10MB (Ethernet), snapshot length 262144 bytes

142 packets captured
145 packets received by filter
0 packets dropped by kernel
```
Analyse du tcpdump
```shell
#commande
 tcpdump -r yo.pcap

#résultat
reading from file yo.pcap, link-type EN10MB (Ethernet), snapshot length 262144
11:39:28.404096 IP kvm1.one.ssh > 10.3.1.254.49868: Flags [P.], seq 3433258688:3433258832, ack 3109231783, win 473, length 144
11:39:28.404279 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [.], ack 144, win 251, length 0
11:39:28.440321 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [P.], seq 4284412464:4284412532, ack 2166314589, win 251, length 68
11:39:28.440831 IP frontend.one.ssh > 10.3.1.254.49865: Flags [P.], seq 1:85, ack 68, win 494, length 84
11:39:28.481722 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [.], ack 85, win 251, length 0
11:39:28.504626 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [P.], seq 68:136, ack 85, win 251, length 68
11:39:28.504934 IP frontend.one.ssh > 10.3.1.254.49865: Flags [P.], seq 85:169, ack 136, win 494, length 84
11:39:28.545525 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [.], ack 169, win 250, length 0
11:39:30.975656 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 1788981575:1788981727, ack 224496297, win 476, options [nop,nop,TS val 4075900495 ecr 2958254884], length 152
11:39:30.976003 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 1:37, ack 152, win 666, options [nop,nop,TS val 2958264896 ecr 4075900495], length 36
11:39:30.977226 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 37, win 476, options [nop,nop,TS val 4075900496 ecr 2958264896], length 0
11:39:30.978319 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 37:121, ack 152, win 666, options [nop,nop,TS val 2958264898 ecr 4075900496], length 84
11:39:30.979132 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 121, win 476, options [nop,nop,TS val 4075900499 ecr 2958264898], length 0
11:39:31.476135 IP kvm1.one.33410 > 239.0.0.2.otv: OTV, flags [I] (0x08), overlay 0, instance 2
IP6 fe80::aff:fedc:dc01 > ff02::2: ICMP6, router solicitation, length 16
11:39:32.128557 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 3676633422:3676633574, ack 3130189186, win 476, options [nop,nop,TS val 688128363 ecr 3489093392], length 152
11:39:32.128921 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 1:37, ack 152, win 666, options [nop,nop,TS val 3489103401 ecr 688128363], length 36
11:39:32.129107 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 37, win 476, options [nop,nop,TS val 688128364 ecr 3489103401], length 0
11:39:32.129511 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 37:121, ack 152, win 666, options [nop,nop,TS val 3489103401 ecr 688128364], length 84
11:39:32.129760 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 121, win 476, options [nop,nop,TS val 688128364 ecr 3489103401], length 0
11:39:33.072241 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 57
11:39:36.262524 IP kvm2.one.41694 > frontend.one.tigv2: UDP, length 57
11:39:40.982529 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 152:304, ack 121, win 476, options [nop,nop,TS val 4075910502 ecr 2958264898], length 152
11:39:40.982819 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 121:157, ack 304, win 666, options [nop,nop,TS val 2958274903 ecr 4075910502], length 36
11:39:40.983643 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 157, win 476, options [nop,nop,TS val 4075910503 ecr 2958274903], length 0
11:39:40.984403 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 157:241, ack 304, win 666, options [nop,nop,TS val 2958274904 ecr 4075910503], length 84
11:39:40.985077 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 241, win 476, options [nop,nop,TS val 4075910505 ecr 2958274904], length 0
11:39:42.137068 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 152:304, ack 121, win 476, options [nop,nop,TS val 688138371 ecr 3489103401], length 152
11:39:42.137503 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 121:157, ack 304, win 666, options [nop,nop,TS val 3489113409 ecr 688138371], length 36
11:39:42.137923 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 157, win 476, options [nop,nop,TS val 688138372 ecr 3489113409], length 0
11:39:42.139046 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 157:241, ack 304, win 666, options [nop,nop,TS val 3489113411 ecr 688138372], length 84
11:39:42.139297 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 241, win 476, options [nop,nop,TS val 688138374 ecr 3489113411], length 0
11:39:43.384288 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0*- [0q] 1/0/2 PTR DESKTOP-HQPG8AH._dosvc._tcp.local. (278)
11:39:43.387549 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0*- [0q] 1/0/2 PTR DESKTOP-HQPG8AH._dosvc._tcp.local. (278)
11:39:43.391339 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:43.393437 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:43.645960 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:43.647720 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:43.900930 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:43.903482 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0 ANY (QM)? DESKTOP-HQPG8AH._dosvc._tcp.local. (51)
11:39:44.157819 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0*- [0q] 1/0/4 (Cache flush) PTR DESKTOP-HQPG8AH._dosvc._tcp.local. (343)
11:39:44.159329 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0*- [0q] 1/0/4 (Cache flush) PTR DESKTOP-HQPG8AH._dosvc._tcp.local. (343)
11:39:44.159934 IP 10.3.1.254.mdns > mdns.mcast.net.mdns: 0*- [0q] 1/0/3 (Cache flush) SRV DESKTOP-HQPG8AH.local.:7680 0 0 (279)
11:39:44.160953 IP6 fe80::e7c9:30d1:7215:1e7b.mdns > ff02::fb.mdns: 0*- [0q] 1/0/3 (Cache flush) SRV DESKTOP-HQPG8AH.local.:7680 0 0 (279)
11:39:48.151084 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 456
11:39:49.543680 IP kvm2.one.41694 > frontend.one.tigv2: UDP, length 452
11:39:50.990647 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 304:456, ack 241, win 476, options [nop,nop,TS val 4075920510 ecr 2958274904], length 152
11:39:50.990929 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 241:277, ack 456, win 666, options [nop,nop,TS val 2958284911 ecr 4075920510], length 36
11:39:50.991798 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 277, win 476, options [nop,nop,TS val 4075920511 ecr 2958284911], length 0
11:39:50.992993 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 277:361, ack 456, win 666, options [nop,nop,TS val 2958284913 ecr 4075920511], length 84
11:39:50.993613 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 361, win 476, options [nop,nop,TS val 4075920513 ecr 2958284913], length 0
11:39:52.145193 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 304:456, ack 241, win 476, options [nop,nop,TS val 688148380 ecr 3489113411], length 152
11:39:52.145585 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 241:277, ack 456, win 666, options [nop,nop,TS val 3489123417 ecr 688148380], length 36
11:39:52.145852 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 277, win 476, options [nop,nop,TS val 688148380 ecr 3489123417], length 0
11:39:52.146361 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 277:361, ack 456, win 666, options [nop,nop,TS val 3489123418 ecr 688148380], length 84
11:39:52.146578 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 361, win 476, options [nop,nop,TS val 688148381 ecr 3489123418], length 0
11:39:52.519954 IP kvm1.one.57374 > frontend.one.tigv2: Flags [S], seq 2287610389, win 64240, options [mss 1460,sackOK,TS val 2958286440 ecr 0,nop,wscale 7], length 0
11:39:52.520321 IP frontend.one.tigv2 > kvm1.one.57374: Flags [S.], seq 2037735382, ack 2287610390, win 65160, options [mss 1460,sackOK,TS val 4075922040 ecr 2958286440,nop,wscale 7], length 0
11:39:52.520358 IP kvm1.one.57374 > frontend.one.tigv2: Flags [.], ack 1, win 502, options [nop,nop,TS val 2958286440 ecr 4075922040], length 0
11:39:52.520449 IP kvm1.one.57374 > frontend.one.tigv2: Flags [P.], seq 1:183, ack 1, win 502, options [nop,nop,TS val 2958286440 ecr 4075922040], length 182
11:39:52.520468 IP kvm1.one.57374 > frontend.one.tigv2: Flags [F.], seq 183, ack 1, win 502, options [nop,nop,TS val 2958286440 ecr 4075922040], length 0
11:39:52.520796 IP frontend.one.tigv2 > kvm1.one.57374: Flags [.], ack 183, win 508, options [nop,nop,TS val 4075922040 ecr 2958286440], length 0
11:39:52.520851 IP frontend.one.tigv2 > kvm1.one.57374: Flags [F.], seq 1, ack 184, win 508, options [nop,nop,TS val 4075922041 ecr 2958286440], length 0
11:39:52.520866 IP kvm1.one.57374 > frontend.one.tigv2: Flags [.], ack 2, win 502, options [nop,nop,TS val 2958286441 ecr 4075922041], length 0
11:40:00.994232 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 456:608, ack 361, win 476, options [nop,nop,TS val 4075930514 ecr 2958284913], length 152
11:40:00.994402 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 361:397, ack 608, win 666, options [nop,nop,TS val 2958294914 ecr 4075930514], length 36
11:40:00.994843 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 397, win 476, options [nop,nop,TS val 4075930514 ecr 2958294914], length 0
11:40:00.995371 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 397:481, ack 608, win 666, options [nop,nop,TS val 2958294915 ecr 4075930514], length 84
11:40:00.995777 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 481, win 476, options [nop,nop,TS val 4075930515 ecr 2958294915], length 0
11:40:02.155651 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 456:608, ack 361, win 476, options [nop,nop,TS val 688158390 ecr 3489123418], length 152
11:40:02.156294 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 361:397, ack 608, win 666, options [nop,nop,TS val 3489133428 ecr 688158390], length 36
11:40:02.156702 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 397, win 476, options [nop,nop,TS val 688158391 ecr 3489133428], length 0
11:40:02.157758 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 397:481, ack 608, win 666, options [nop,nop,TS val 3489133429 ecr 688158391], length 84
11:40:02.158137 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 481, win 476, options [nop,nop,TS val 688158393 ecr 3489133429], length 0
11:40:03.078725 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 57
11:40:06.268359 IP kvm2.one.41694 > frontend.one.tigv2: UDP, length 57
11:40:11.002370 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 608:760, ack 481, win 476, options [nop,nop,TS val 4075940522 ecr 2958294915], length 152
11:40:11.002544 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 481:517, ack 760, win 666, options [nop,nop,TS val 2958304922 ecr 4075940522], length 36
11:40:11.002928 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 517, win 476, options [nop,nop,TS val 4075940523 ecr 2958304922], length 0
11:40:11.003367 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 517:601, ack 760, win 666, options [nop,nop,TS val 2958304923 ecr 4075940523], length 84
11:40:11.003783 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 601, win 476, options [nop,nop,TS val 4075940523 ecr 2958304923], length 0
11:40:12.164483 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 608:760, ack 481, win 476, options [nop,nop,TS val 688168399 ecr 3489133429], length 152
11:40:12.164815 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 481:517, ack 760, win 666, options [nop,nop,TS val 3489143437 ecr 688168399], length 36
11:40:12.165031 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 517, win 476, options [nop,nop,TS val 688168400 ecr 3489143437], length 0
11:40:12.165472 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 517:601, ack 760, win 666, options [nop,nop,TS val 3489143437 ecr 688168400], length 84
11:40:12.165684 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 601, win 476, options [nop,nop,TS val 688168400 ecr 3489143437], length 0
11:40:18.604533 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 460
11:40:20.094822 IP kvm2.one.41694 > frontend.one.tigv2: UDP, length 456
11:40:21.007500 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 760:912, ack 601, win 476, options [nop,nop,TS val 4075950527 ecr 2958304923], length 152
11:40:21.007814 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 601:637, ack 912, win 666, options [nop,nop,TS val 2958314928 ecr 4075950527], length 36
11:40:21.008254 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 637, win 476, options [nop,nop,TS val 4075950528 ecr 2958314928], length 0
11:40:21.009048 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 637:721, ack 912, win 666, options [nop,nop,TS val 2958314929 ecr 4075950528], length 84
11:40:21.009507 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 721, win 476, options [nop,nop,TS val 4075950529 ecr 2958314929], length 0
11:40:21.452411 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [P.], seq 1:49, ack 144, win 251, length 48
11:40:21.452747 IP kvm1.one.ssh > 10.3.1.254.49868: Flags [P.], seq 144:192, ack 49, win 473, length 48
11:40:21.494529 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [.], ack 192, win 251, length 0
11:40:21.520106 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [P.], seq 136:204, ack 169, win 250, length 68
11:40:21.520501 IP frontend.one.ssh > 10.3.1.254.49865: Flags [P.], seq 169:253, ack 204, win 494, length 84
11:40:21.560557 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [.], ack 253, win 250, length 0
11:40:21.584513 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [P.], seq 204:272, ack 253, win 250, length 68
11:40:21.584851 IP frontend.one.ssh > 10.3.1.254.49865: Flags [P.], seq 253:337, ack 272, win 494, length 84
11:40:21.624624 IP 10.3.1.254.49865 > frontend.one.ssh: Flags [.], ack 337, win 255, length 0
11:40:22.177110 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 760:912, ack 601, win 476, options [nop,nop,TS val 688178412 ecr 3489143437], length 152
11:40:22.177950 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 601:637, ack 912, win 666, options [nop,nop,TS val 3489153449 ecr 688178412], length 36
11:40:22.178392 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 637, win 476, options [nop,nop,TS val 688178413 ecr 3489153449], length 0
11:40:22.179702 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 637:721, ack 912, win 666, options [nop,nop,TS val 3489153451 ecr 688178413], length 84
11:40:22.180013 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 721, win 476, options [nop,nop,TS val 688178415 ecr 3489153451], length 0
11:40:26.298683 ARP, Request who-has kvm1.one (08:00:27:8a:74:86 (oui Unknown)) tell 10.3.1.254, length 46
11:40:26.298694 ARP, Reply kvm1.one is-at 08:00:27:8a:74:86 (oui Unknown), length 28
11:40:26.639314 ARP, Request who-has 10.3.1.254 tell frontend.one, length 46
11:40:26.639316 ARP, Reply 10.3.1.254 is-at 0a:00:27:00:00:11 (oui Unknown), length 46
11:40:26.714074 ARP, Request who-has 10.3.1.254 tell kvm1.one, length 28
11:40:26.714553 ARP, Reply 10.3.1.254 is-at 0a:00:27:00:00:11 (oui Unknown), length 46
11:40:31.018925 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 912:1064, ack 721, win 476, options [nop,nop,TS val 4075960538 ecr 2958314929], length 152
11:40:31.019362 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 721:757, ack 1064, win 666, options [nop,nop,TS val 2958324939 ecr 4075960538], length 36
11:40:31.020259 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 757, win 476, options [nop,nop,TS val 4075960540 ecr 2958324939], length 0
11:40:31.020789 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 757:841, ack 1064, win 666, options [nop,nop,TS val 2958324941 ecr 4075960540], length 84
11:40:31.021474 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 841, win 476, options [nop,nop,TS val 4075960541 ecr 2958324941], length 0
11:40:32.187365 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 912:1064, ack 721, win 476, options [nop,nop,TS val 688188422 ecr 3489153451], length 152
11:40:32.187824 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 721:757, ack 1064, win 666, options [nop,nop,TS val 3489163459 ecr 688188422], length 36
11:40:32.188277 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 757, win 476, options [nop,nop,TS val 688188423 ecr 3489163459], length 0
11:40:32.189516 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 757:841, ack 1064, win 666, options [nop,nop,TS val 3489163461 ecr 688188423], length 84
11:40:32.189782 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 841, win 476, options [nop,nop,TS val 688188424 ecr 3489163461], length 0
11:40:33.096413 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 57
11:40:36.314101 IP kvm2.one.41694 > frontend.one.tigv2: UDP, length 57
11:40:41.032073 IP frontend.one.58334 > kvm1.one.ssh: Flags [P.], seq 1064:1216, ack 841, win 476, options [nop,nop,TS val 4075970552 ecr 2958324941], length 152
11:40:41.032222 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 841:877, ack 1216, win 666, options [nop,nop,TS val 2958334952 ecr 4075970552], length 36
11:40:41.032440 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 877, win 476, options [nop,nop,TS val 4075970552 ecr 2958334952], length 0
11:40:41.032775 IP kvm1.one.ssh > frontend.one.58334: Flags [P.], seq 877:961, ack 1216, win 666, options [nop,nop,TS val 2958334953 ecr 4075970552], length 84
11:40:41.032954 IP frontend.one.58334 > kvm1.one.ssh: Flags [.], ack 961, win 476, options [nop,nop,TS val 4075970553 ecr 2958334953], length 0
11:40:42.200797 IP frontend.one.53806 > kvm2.one.ssh: Flags [P.], seq 1064:1216, ack 841, win 476, options [nop,nop,TS val 688198435 ecr 3489163461], length 152
11:40:42.201303 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 841:877, ack 1216, win 666, options [nop,nop,TS val 3489173473 ecr 688198435], length 36
11:40:42.201651 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 877, win 476, options [nop,nop,TS val 688198436 ecr 3489173473], length 0
11:40:42.202530 IP kvm2.one.ssh > frontend.one.53806: Flags [P.], seq 877:961, ack 1216, win 666, options [nop,nop,TS val 3489173474 ecr 688198436], length 84
11:40:42.202887 IP frontend.one.53806 > kvm2.one.ssh: Flags [.], ack 961, win 476, options [nop,nop,TS val 688198437 ecr 3489173474], length 0
11:40:43.943400 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [P.], seq 49:529, ack 192, win 251, length 480
11:40:43.944367 IP kvm1.one.ssh > 10.3.1.254.49868: Flags [P.], seq 192:528, ack 529, win 470, length 336
11:40:43.952343 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [P.], seq 529:625, ack 528, win 250, length 96
11:40:43.959741 IP kvm1.one.ssh > 10.3.1.254.49868: Flags [P.], seq 528:784, ack 625, win 470, length 256
11:40:43.987034 IP 10.3.1.254.49868 > kvm1.one.ssh: Flags [P.], seq 625:673, ack 784, win 511, length 48
11:40:44.028344 IP kvm1.one.ssh > 10.3.1.254.49868: Flags [.], ack 673, win 470, length 0
11:40:46.482817 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 250
11:40:49.097621 IP kvm1.one.38103 > frontend.one.tigv2: UDP, length 456
```
Utilisation du tcpdump sur vxlan_bridge
```shell
#commande
sudo tcpdump -i vxlan_bridge -w dumpvxlan_bridge.txt

#résultat
dropped privs to tcpdump
tcpdump: listening on vxlan_bridge, link-type EN10MB (Ethernet), snapshot length 262144 bytes
3 packets captured
3 packets received by filter
0 packets dropped by kernel
```
Analyse du tcpdump
```shell
#commande
tcpdump -r dumpvxlan_bridge.txt

#résultat
reading from file dumpvxlan_bridge.txt, link-type EN10MB (Ethernet), snapshot length 262144
11:46:51.394961 IP kvm1.one.44998 > 10.220.220.1.ssh: Flags [P.], seq 4180633226:4180633278, ack 2081368838, win 548, options [nop,nop,TS val 899786913 ecr 3166256753], length 52
11:46:51.396136 IP 10.220.220.1.ssh > kvm1.one.44998: Flags [P.], seq 1:37, ack 52, win 249, options [nop,nop,TS val 3166266760 ecr 899786913], length 36
11:46:51.396166 IP kvm1.one.44998 > 10.220.220.1.ssh: Flags [.], ack 37, win 548, options [nop,nop,TS val 899786914 ecr 3166266760], length 0
```














```shell
#commande


#résultat

```