# How to add dev to a server - Rocky Linux

## Download this bash script to the server

```
curl -o add_dev_user.sh https://raw.githubusercontent.com/sky-lester/add-dev-to-server/refs/heads/main/add_dev_user.sh
```

## Make it executable

```
sudo chmod +x add_dev_user.sh
```

## Run command and enter the dev's ssh

```
./add_dev_user.sh <name> <server-user>
```
