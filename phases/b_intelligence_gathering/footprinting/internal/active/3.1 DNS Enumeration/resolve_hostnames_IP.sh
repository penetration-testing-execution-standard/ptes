
#!/bin/bash

# 192.168.0.0 - 192.168.255.255
for ip in $(seq 00 255); do host 192.168.255.$ip | grep "domain name pointer" ;done
