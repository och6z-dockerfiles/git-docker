# Git
```bash
docker build \
    --no-cache \
    --build-arg IMAGE=och6z/tor-proxy \
    --build-arg IMAGE_VERSION=latest \
    --build-arg ACCOUNT=docker \
    --build-arg USERMAIL=usermail@usermail \
    --build-arg USER=user@user \
    --file Dockerfile \
    --tag image-name:latest .
```
```bash
xhost +local:docker
```
```bash
docker run \
    --interactive \
    --tty \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --env DISPLAY=unix$DISPLAY \
    --name container-name och6z/git
```
