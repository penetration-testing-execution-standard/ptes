#!/bin/bash

while [ 1 ];do

file2cable -i eth0 -f arp-replay
file2cable -i eth0 -f arp-gateway

sleep 2

done
