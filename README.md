# c3-go Dockerfile

> Run a C3 node as a Docker container

## Instructions

### Docker config

Enable proxy IP `123.123.123.123`

```bash
make localhostproxy
```

Configure `daemon.json` to include the private registry as insecured (momentarily).

```json
{
  "insecure-registries" : [
    "123.123.123.123:5000"
  ]
}
```

- Linux
  - `/etc/docker/daemon.json`
- macOS
  - `~/.docker/daemon.json`

Restart the docker daemon after configuring `daemon.json`

Build docker image:

```bash
make build
```

Push image

```bash
make push CONTAINERID=0fa30a2beed2 IMAGEID=hello-world
```

Pull image

```bash
make pull CONTAINERID=0fa30a2beed2 IMAGEID=QmcZy3suMS5ZyxmpSxfcc4V3ET1MPrwbsAs1twfsDpEyFW
```

### Connecting to peer

```bash
c3-go node start --pem priv.pem --uri /ip4/0.0.0.0/tcp/9005 --data-dir ~/.c3 --peer "/ip4/127.0.0.1/tcp/3330/ipfs/QmU7XFuAxfv4zmvUEzRpQKfDU1SJSbrE9HQjTwGz5fbeHw"
```

## License

MIT
