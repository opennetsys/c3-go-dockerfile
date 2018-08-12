# c3-go Dockerfile

> Run a C3 node as a Docker container

## Instructions

### Docker config

Enable a proxy IP `123.123.123.123`

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

Help:

```bash
make help
```

## License

MIT
