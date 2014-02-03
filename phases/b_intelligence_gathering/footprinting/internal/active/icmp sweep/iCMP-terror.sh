#!/bin/bash

for i in `seq 0 255`
do
ip=192.168.15.$i
ping -b -c 1 $ip | grep "64 bytes" | awk '{print $4}' | cut -d: -f1
done
