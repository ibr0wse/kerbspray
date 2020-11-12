# Kerbspray
## Simple Wrapper to incorporate [Greenwolf's spray.sh](https://github.com/Greenwolf/Spray) functionality with [Ropnop's kerbrute](https://github.com/ropnop/kerbrute)

### Requirements
- golang
- kerbrute

Usage: kerbspray.sh <domain> <usernameList> <passwordList> <LockoutThreshold> <LockoutResetTimerInMinutes>
Example: kerbspray.sh domain.ca users.txt passwords.txt 2 60
