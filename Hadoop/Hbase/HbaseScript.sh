#!/bin/bash
## first we need to create an table before running the script.

for i in {1..10} 
do
        ## to clean the file
        > cmd.txt

        timeofdump=$(date | awk '{print $4}')

        wordCloud=(
        "['mystery', 1, 'lynette', 1, 'begin', 1, 'police', 1, 'dawson', 1, 'podcasthighlighted', 1]",
        "['robbing', 1, 'requires', 1, 'skill', 1, 'apparently', 1, 'everyones', 1, 'cupoftea', 1]",
        "['gold', 1, 'colony', 1, 'india', 1, 'british', 1, 'relation', 1, 'sexual', 1, 'royal', 1, 'stolen', 1, 'around', 1, 'country', 1, 'half', 1, 'thief', 1, 'lunchbox', 1, 'samesex', 1, 'illegal', 1, 'world', 1, 'former', 1]",
        "['life', 1, 'last', 1, 'turned', 1, 'cryptocurrencies', 1, 'savin', 1, 'investment', 1, 'crashed', 1, 'year', 1, 'bitcoin', 1, 'month', 1]",
        "['category', 1, 'strengthen', 1, 'equivalent', 1, 'hurricane', 1, 'typhoon', 1, 'expected', 1, 'atlantic', 1, 'super', 1, 'mangkhut', 1, 'currently', 1, 'next', 1]"
        "['national', 1, 'draw', 1, 'rally', 1, 'million', 1, 'catalonia', 1]",
        "['shine', 1, 'asks', 1, 'relationship', 1, 'osaka', 1, 'hanoi', 1, 'bizarre', 1, 'open', 1, 'meat', 1, 'samesex', 1, 'vietnamese', 1, 'country', 1, 'time', 1, 'people', 1, 'crime', 1, 'capital', 1, 'naomi', 1, 'still', 1, 'final', 1]",
        "['blockchain', 1, 'token', 2, 'toto', 2, 'based', 1, 'erc', 1, 'ethereum', 1, 'tourist', 1, 'touristtoken', 1]",
        "['colleague', 1, 'arab', 1, 'supreme', 1, 'appearing', 1, 'criticise', 1, 'india', 1, 'offensive', 1, 'arrested', 1, 'tigress', 1, 'authority', 1, 'planet', 1, 'video', 1, 'understand', 1, 'rejected', 1, 'female', 1, 'eating', 1, 'breakfast', 1, 'stop', 1, 'court', 1, 'appeal', 1, 'dont', 2, 'ranger', 1, 'forest', 1, 'never', 1, 'killing', 1, 'pluto', 1, 'culture', 1, 'scientist', 1, 'saudi', 1, 'argue', 1, 'downgraded', 1, 'definitely', 1]",
        "['billion', 1, 'sold', 1, 'here', 1, 'apple', 1, 'launch', 1, 'money', 1, 'since', 1, 'iphones', 1, 'phone', 1, 'much', 1, 'iphone', 1, 'look', 1]",
        "['shine', 1, 'osaka', 1, 'planet', 1, 'bizarre', 1, 'open', 1, 'never', 1, 'pluto', 1, 'downgraded', 1, 'scientist', 1, 'time', 1, 'naomi', 1, 'argue', 1, 'final', 1, 'definitely', 1]",
        "['shine', 1, 'osaka', 1, 'open', 1, 'bizarre', 1, 'final', 1, 'naomi', 1, 'time', 1, 'look', 1, 'japanese', 1]",
        "['category', 1, 'draw', 1, 'strengthen', 1, 'equivalent', 1, 'hurricane', 1, 'typhoon', 1, 'expected', 1, 'atlantic', 1, 'super', 1, 'national', 1, 'million', 1, 'currently', 1, 'next', 1, 'mangkhut', 1, 'rally', 1, 'catalonia', 1]",
        "['category', 1, 'apologises', 1, 'strengthen', 1, 'university', 1, 'hurricane',1, 'equivalent', 1, 'female', 1, 'expected', 1, 'typhoon', 1, 'super', 1, 'medical', 1, 'atlantic', 1, 'exam', 1, 'tokyo', 1, 'currently', 1, 'next', 1, 'mangkhut', 1, 'score', 1, 'changing', 1],"
        )

        user_popularity=(
        "['AnsisEgle', 17]",
        "['rezainth3works', 0]",
        "['O7fgetV93wRnqE5', 65, 'ablakelock9', 51]",
        "['MaSiya001', 134]",
        "['CynthanyA', 47]",
        "['donnareh', 235, 'schroddybach', 46, 'jeff69516970', 0]",
        "['KojLt', 77]",
        "['KojLt', 181, 'KojLt', 133, 'LinaVegaAbad', 29]",
        "['KojLt', 80, 'KojLt', 39, '_EdwardBaumann_', 0]",
        "['KojLt', 142, 'KojLt', 57, 'KojLt', 16]",
        "['EsQKlrtlle', 664, 'SouzaEluam', 50]",
        "['Dominica_Mora', 182, 'davoyager', 49],"
        )

        word=`echo ${wordCloud[$(shuf -i 0-11 -n 1)]} | sed 's/.$//'`
        user=`echo ${user_popularity[$(shuf -i 0-11 -n 1)]} | sed 's/.$//'`
		
		echo "put 'tweetscount2','$timeofdump','cf:business','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:entertainment','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:health','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:politics','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:sports','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:technology','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:twitterforiphone','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:twitterforwebclient','$(shuf -i 0-4 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:twitterforothers','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:twitterforandroid','$(shuf -i 0-4 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:twitterforlite','$(shuf -i 0-3 -n 1)'" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:wordcloud',\"$word\"" >> /home/centos/cmd.txt
        echo "put 'tweetscount2','$timeofdump','cf:user_popularity',\"$user\"" >> /home/centos/cmd.txt
        echo "exit" >> /home/centos/cmd.txt

        ## hbase call
        hbase shell /home/centos/cmd.txt
        sleep 3s
done