#!/bin/sh

# Download and install V2Ray
bash <(curl -L -s https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
  "inbounds": [
    {
    "port":41233,
	"listen": "0.0.0.0", 
      "tag": "VLESS-in", 
      "protocol": "shadowsocks",  
       "settings": {
        "method": "chacha20-ietf-poly1305",
        "password": "$PASSWORD"
      }, 
      "streamSettings": {
        "network": "tcp"
      },
      "sniffing": {
        "enabled": true, 
        "destOverride": ["http", "tls"]
      }
    }
  ], 
  "outbounds": [
    {
      "protocol": "freedom", 
      "settings": { }, 
      "tag": "direct"
    }, 
    {
      "protocol": "blackhole", 
      "settings": { }, 
      "tag": "blocked"
    }
  ], 
  "dns": {
    "servers": [
      "https+local://1.1.1.1/dns-query",
	  "1.1.1.1",
	  "1.0.0.1",
	  "8.8.8.8",
	  "8.8.4.4",
	  "localhost"
    ]
  },
  "routing": {
    "domainStrategy": "AsIs",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "VLESS-in"
        ],
        "outboundTag": "direct"
      }
    ]
  }
}
EOF

# Run V2Ray
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
