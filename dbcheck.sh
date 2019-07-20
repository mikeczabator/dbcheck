 #!/bin/bash

USER=root
PASS=nov2018
MEMSQLPATH=memsql

hosts=(
	3.123.130.192:3310
	3.123.130.192:3306
 	3.123.130.192:3307
	3.123.130.192:3308
	3.123.130.192:3309
	127.0.0.1:3306
	127.0.0.1:3307
)


for h in "${hosts[@]}"; do
	HOST="$(cut -d':' -f1 <<<"$h")"
	PORT="$(cut -d':' -f2 <<<"$h")"
	$MEMSQLPATH -h$HOST -P$PORT -u$USER -p$PASS -e "select (1)" > /dev/null 2> /dev/null

	if [ $? -eq 0 ]
        then
                echo "$h is reachable"
        else
		echo $(tput setaf 1)$(tput setab 7)SERVER UNREACHABLE: $h$(tput sgr 0)
 	fi
done
