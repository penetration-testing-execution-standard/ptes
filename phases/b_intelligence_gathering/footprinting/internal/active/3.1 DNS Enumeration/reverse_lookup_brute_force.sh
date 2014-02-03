
#!/bin/bash

for ip in $(seq 00 255); do dig 192.168.15.$ip | grep "domain name pointer" ;done
