# keystore install writeup

## setup gopass

*On Server*

- create gopass_user
- create dir
- git init --bare

*On client*

- create gopass ssh.pub for gopass user
- rollout ssh.pubkey to server
- install gopass 
    - check './gopass_install.sh' 
    - or https://github.com/gopasspw/gopass directly
- install apt dependencies:
    - sudo apt install gpg python3-ykman yubikey-manager scdaemon  pcsc-tools
- create gpg key
    - RSA 2048 >=10y
- setup gopass
    - gpg --list-secret-keys
    - gopass init <keyID>
    - gopass config -> look for mount path
    - cd <mount-path>
    - ls-remote <server+path> no output = OK
    - git remote add origin <server+path>
    - git pull origin main/master

** gopass should now be setup with remote ** 

to test it 

- gopass insert hello/test
- gopass sync
- gopass show hello/test

## setup yubikey

- gpg --list-secret-keys
- backup
    - gpg --export-secret-key --armor > gpg_backup.asc
    - chmod 600 gpg_backup.asc

## setup gpg to listen to the right port/smartcard if there are two

```shell
# insert the key and look for it (Reader: <card-name>)
pcsc_scan
# if more than one smart card reader
cat > ~/.gnupg/scdaemon.conf << 'EOF'
disable-ccid
pcsc-shared
reader-port "<card-name>"
EOF
# reset gpg
sudo systemctl restart pcscd && gpgconf --kill all
```

## gpg & card setup

- gpg --card-status
- move subkeys to card
    - gpg --list-secret-keys
    - gpg --edit-key <keyID>
    - gpg 
        - addkey (: RSA & SIGN)
        - addkey (: RSA & ENC)
        - save
        - key 1
        - keytocard -> right slot
        - key 2 (maybe have to unselect key 1)
        - keytocard -> same
        - save
