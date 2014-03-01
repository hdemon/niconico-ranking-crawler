#!/bin/sh
export PATH=$PATH:/usr/ruby/bin

su app
cd /home/app
git clone https://github.com/hdemon/yukkuri-ranking-aggregator.git
cd yukkuri-ranking-aggregator
bundle install -j4

echo "10 17 * * * /bin/bash -l -c 'cd /home/app/yukkuri-ranking-aggregator && bundle exec rake crawl:daily >> /var/log/cron_log.log 2>&1'" >> /var/spool/cron/crontabs/app
cron