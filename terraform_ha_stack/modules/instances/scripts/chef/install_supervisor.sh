#!/bin/bash
SUPER_CONFIG="/usr/lib/systemd/system/supervisord.service"
if [[ ! -f "$SUPER_CONFIG" ]]; then
    sudo yum -y update && sudo yum install python3-setuptools
    sudo easy_install supervisor
    sudo mkdir -p /etc/supervisor/conf.d
    sudo echo_supervisord_conf >  /etc/supervisord.conf
    sudo echo "files = /etc/supervisor/conf.d/*.conf" >> /etc/supervisord.conf
    sudo cp -a  /tmp/chef/supervisord /usr/lib/systemd/system/supervisord.service
    systemctl daemon-reload
    systemctl enable supervisord
    systemctl start supervisord.service
    systemctl status supervisord.service
elif [[ -f $SUPER_CONFIG ]]; then
    systemctl enable supervisord
    systemctl start supervisord.service
    echo "$SUPER_CONFIG Installation already running, No installation required" 1>&2
fi

