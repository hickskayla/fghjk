#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/hickskayla/fghjk/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="d5bcb493-4c12-41b0-aace-f57577fd9a98"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
