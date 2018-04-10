# Distributed tail -F /var/log/messages docker container

## What's that?

This is companion material to the Linux Journal article.
This container will run all the necessary steps to build the hub.

## Build

docker build .

## Run

docker run -p 55556:5556 -p 55559:5559 -p 5514:514/udp -it <image>

## Usage

### Subscribe to websocket

```
wscat --connect 'ws://127.0.0.1:55556/index?subscribe=true&query=true'
```

### Send syslog message to container

```
logger -d -n 127.0.0.1 -P 5514 -t test test
```

## Demo

![demo](demo.gif)
