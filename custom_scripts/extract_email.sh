#!/bin/bash
offlineimap -c ~/email/.offlineimaprc
cd ~/email/tmp/
#munpack ~/email/tmp/s.larasti/new/*
ripmime -v --no-doublecr -i ~/email/tmp/s.larasti/new/ -d ~/email/tmp/
mv *.TXT ~/ranch/
cd ~/ranch
#&& zip $(date +%Y-%m-%d).zip *.TXT

for f in *.TXT
do
  echo "Importing price update "$f" for ranch family"
  source ~/tmp/.env && cd /home/ubuntu/sprinkles/current && RAILS_ENV=production bundle exec rake sprinkles:import:rm_price_data FILE_PATH=/home/ubuntu/ranch/"$f" >> /tmp/import-$(date +%Y-%m-%d).log
done

rm ~/email/tmp/s.larasti/new/*
rm ~/ranch/*
