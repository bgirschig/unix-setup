# cron jobs

Schedule jobs on regular intervals (minimum of 1 minute)

## Install
cron is likely already installed, but in case it's not:

```bash
apt-get install cron
```

## view current cron file
```bash
crontab -l
```

## edit cron jobs
```bash
crontab -e
```

## syntax
```
#   .---------------- minute (0 - 59)
#   |  .------------- hour (0 - 23)
#   |  |  .---------- day of month (1 - 31)
#   |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
#   |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
#   |  |  |  |  |
#   *  *  *  *  *  user command to be executed
```

## examples
```
# run `something.sh` every day at 22:00
00 22 * * * /root/scripts/somthing.sh >> something.log

# run `something.sh` every 6 hours
00 */6 * * * /root/scripts/somthing.sh

# run `something.sh` every minute on monday
* * * * mon /root/scripts/somthing.sh

# run on the dirst day of every month
0 0 1 * * /root/scripts/something.sh
```
