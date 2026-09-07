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

## create gpg keys and yubikey setup
### create gpg key

- gpg --full-generate-key
    - RSA 2048 
- create 3 subkeys (also RSA)
- gpg --list-secret-keys
- gpg --export-secret-key --armor <keyID> > gpg_backup.asc
- chmod 600 gpg_backup.asc
- gpg --export --armor <kid> > gpg.pub.asc

## gpg to card setup

- gpg --card-status
- start with backup key
- move subkeys to card
    - gpg --list-secret-keys
    - gpg --edit-key <keyID>
    - gpg 
        - addkey (: RSA & SIGN)
        - addkey (: RSA & ENC)
        - addkey (: RSA & SIGN)
        - save
        - backup again !!! (b4 moving keys -> leaves only stubs)
        - key 1
        - keytocard -> right slot
        - key 2 (maybe have to unselect key 1)
        - keytocard -> same
        - save
- reset keys: 
    - gpg --delete-secret-and-public-key <kid>
    - gpg import <backup_file>
    - gpg --list-secret-keys
    - gpg --edit-key <keyID>
    - gpg 
        - key 1
        - keytocard -> right slot
        - key 2 (maybe have to unselect key 1)
        - keytocard -> same
        - save

## Setup gopass

- setup gopass
    - gpg --list-secret-keys
    - gopass init <keyID>
    - gopass config -> look for mount path
    - cd <mount-path>
    - git ls-remote <server+path> no output = OK
    - git remote add origin <server+path>
    - git pull/push origin main/master

** gopass should now be setup with remote ** 

to test it 

- gopass insert hello/test
- gopass sync
- gopass show hello/test


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


## Note: 
if main key is lost -> insert backup card 
```shell
gpg --delete-secret-and-public-key <kid>

gpg --import public-key.asc

gpg --card-status   
```

this should recreate the stubs 

