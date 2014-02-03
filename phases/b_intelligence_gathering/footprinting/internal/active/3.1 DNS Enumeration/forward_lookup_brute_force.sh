
#!/bin/bash

for name in $(cat dns-names.txt);do
host $name.master.thinc.local |grep "has address"|cut -d" " -f4
done
