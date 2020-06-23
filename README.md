# Git
```bash
docker build \
    --no-cache \
    --build-arg DEBIAN_VERSION=stable-slim \
    --build-arg ACCOUNT=github \
    --build-arg USERMAIL=usermail@usermail \
    --build-arg USER=user@user \
    --build-arg PWLEN=15 \
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
