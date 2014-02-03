
#!/usr/bin/bash

for ip in $(grep open 139.txt | cut -d" " -f2); do nmap -p 1-65535 $ip > $ip.network_sweep.txt;done
