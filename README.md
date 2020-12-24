![docker build automated](https://img.shields.io/docker/cloud/automated/dotriver/dokuwiki)
![docker build status](https://img.shields.io/docker/cloud/build/dotriver/dokuwiki)
![docker build status](https://img.shields.io/docker/cloud/pulls/dotriver/dokuwiki)

# Dokuwiki on Alpine Linux + S6 Overlay

# Auto configuration parameters :

- TITLE=Title of the Dokuwiki
- ADMIN_USERNAME=admin
- ADMIN_FULLNAME=admin smith jr
- ADMIN_EMAIL=smith.admin.jr@test.com
- ADMIN_PASSWORD=password

- ACL_POLICY=open
- ALLOW_REG=FALSE                 (allow users to register themselves)
- LICENSE=gnufdl
- SEND_USAGE_DATA=TRUE
- APP_LANGUAGE=en

- USE_LDAP=TRUE                   (use ldap to authenticate)
- LDAP_BASE_DN=dc=example,dc=com
- LDAP_HOST=fd
- LDAP_ADMIN_PASS=password
- LDAP_ADMIN_GROUP=admin          (the ldap group containing etherpad admins)

# Send usage data

Once a month send anonymous usage data to the DokuWiki developers. Usage data sent :
* DokuWiki version
* PHP version
* Template used
* Plugins used
* Webserver used
* Operating system
* Language
* More info : http://www.dokuwiki.org/popularity

# Initial ACL policy

### Open wiki
* Parameter : open
* read, write, upload for everyone

### Public wiki
* Parameter : public
* read for everyone, write and upload for registered users

### Closed wiki
* Parameter : closed
* read, write, upload for registered users

# Licence parameters

### CC0 1.0 Universal
* Parameter : cc-zero
* More info : http://creativecommons.org/publicdomain/zero/1.0/

### Public Domain
* Parameter : publicdomain
* More info : http://creativecommons.org/licenses/publicdomain/

### CC Attribution 4.0 International
* Parameter : cc-by
* More info : http://creativecommons.org/licenses/by/4.0/

### CC Attribution-Share Alike 4.0 International
* Parameter : cc-by-sa
* More info : http://creativecommons.org/licenses/by-sa/4.0/

### GNU Free Documentation License 1.3
* Parameter : gnufdl
* More info : http://www.gnu.org/licenses/fdl-1.3.html

### CC Attribution-Noncommercial 4.0 International
* Parameter : cc-by-nc
* More info : http://creativecommons.org/licenses/by-nc/4.0/

### CC Attribution-Noncommercial-Share Alike 4.0 International
* Parameter : cc-by-nc-sa
* More info : http://creativecommons.org/licenses/by-nc-sa/4.0/

# Compose file example

```
version: '3.1'

services:

  dokuwiki:
    image: dotriver/dokuwiki
    environment:
        - TITLE=Test title
        - ADMIN_USERNAME=admin
        - ADMIN_FULLNAME=test admin
        - ADMIN_EMAIL=test.admin@test.com
        - ADMIN_PASSWORD=password

        - ACL_POLICY=open
        - ALLOW_REG=FALSE
        - LICENSE=gnufdl
        - SEND_USAGE_DATA=TRUE
        - APP_LANGUAGE=en

        - USE_LDAP=TRUE
        - LDAP_BASE_DN=dc=example,dc=com
        - LDAP_HOST=fd
        - LDAP_ADMIN_PASS=password
        - LDAP_ADMIN_GROUP=admin
    ports:
      - 8080:80
    volumes:
      - /tmp/dokuwiki:/var/www/dokuwiki/
    networks:
      default:
    deploy:
      resources:
        limits:
          memory: 256M
      restart_policy:
        condition: on-failure
      mode: global

  fd:
    image: dotriver/fusiondirectory
    ports:
      - "8081:80"
    environment:
      DOMAIN: example.com
      ADMIN_PASS: password
      CONFIG_PASS: password
    volumes:
      - openldap-data:/var/lib/openldap/
      - openldap-config:/etc/openldap/

volumes:
    mariadb-data:
    mariadb-config:
    openldap-config:
    openldap-data:

```