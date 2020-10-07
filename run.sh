totalarg=$#
if [ $totalarg -eq 1 ]
then
        echo "database configuration"
        file=$1
        i=1;
        while read line; do
                echo "$line"
                sc[$i]="$line"
                i=$((i+1))
        done <$file
	mkdir ~/temp/${sc[1]}
	mkdir ~/temp/${sc[1]}/config
	mkdir ~/temp/${sc[1]}/data
	cp -u ~/deployment/mdb.cnf ~/temp/${sc[1]}/config/mdb.cnf
	#rm ~/temp/${sc[1]}/config/mdb.cnf
	

	docker kill ${sc[1]}
	docker rm ${sc[1]}
	sudo docker run -d --name=${sc[1]} -p ${sc[2]}:3306 -e TZ=Asia/Kolkata --restart=always \
	    -v ~/temp/${sc[1]}/config:/etc/mysql/conf.d \
	     -v ~/temp/${sc[1]}/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=${sc[3]} mariadb
else
	echo  "dbconfig file missing"
fi
