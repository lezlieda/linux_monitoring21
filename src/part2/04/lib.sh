#!/usr/bin/bash

function generate_ip {
    local ip=""
    for i in {1..4} ; do
        ip="$ip.$(( RANDOM % 256 ))"
    done
    echo "${ip:1}"
}

responces=(200 201 400 401 403 404 500 501 502 503)
methods=("GET" "POST" "PUT" "PATCH" "DELETE")
urls=(
    "http://www.google.com"
    "http://www.youtube.com"
    "http://www.facebook.com"
    "http://www.instagram.com"
    "http://www.twitter.com"
    "http://www.baidu.com"
    "http://www.wikipedia.org"
    "http://www.yahoo.com"
    "http://www.yandex.ru"
    "http://www.whatsapp.com"
    "http://www.xvideos.com"
    "http://www.amazon.com"
    "http://www.tiktok.com"
    "http://www.pornhub.com"
    "http://www.xnxx.com"
    "http://www.live.com"
    "http://www.yahoo.co.jp"
    "http://www.reddit.com"
    "http://www.docomo.ne.jp"
    "http://www.linkedin.com"
    "http://www.openai.com"
    "http://www.office.com"
    "http://www.xhamster.com"
    "http://www.netflix.com"
    "http://www.dzen.ru"
    "http://www.microsoftonline.com"
    "http://www.bing.com"
    "http://www.bilibili.com"
)

files=(
    "index.html"
    "chinese_accident.mp4"
    "your_mom.jpg"
    "grandma.rar"
    "scam.pdf"
    "cat.png"
    "definitely_not_a_virus.exe"
)

agents=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14.1; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)"
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)"
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)"
    "Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/5.0)"
    "Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)"
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)"
    "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko"
    "Mozilla/5.0 (Windows NT 6.2; Trident/7.0; rv:11.0) like Gecko"
    "Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko"
    "Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/118.0.2088.76"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/118.0.2088.76"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 OPR/105.0.0.0"
    "Mozilla/5.0 (Windows NT 10.0; WOW64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 OPR/105.0.0.0"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 OPR/105.0.0.0"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 OPR/105.0.0.0"
)


function generate_date {
    local today=$( date +%F )
    echo $( shuf -n 1 -i $( date -d "2018-11-16" +%s )-$( date -d $today +%s )\
    | xargs -I {} date -d "@{}" +"%d/%b/%Y" )
}

function generate_date_time {
    local date=$1
    local total=$2
    local current=$3
    local time=$(( 86399/$total*$current ))
    printf "[%s:%02d:%02d:%02d %s]" "$date" "$(( time / 3600 ))"\
           "$(( (time % 3600) / 60 ))" "$(( time % 60 ))" "$( date +%z )"
}
