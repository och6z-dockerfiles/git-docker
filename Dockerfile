ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    #ca-certificates \
    git \
    pwgen \
    openssh-client \
    && apt-get purge -y && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ARG USER
ARG USERMAIL
ARG PWLEN

RUN mkdir --parents /root/.ssh && touch /root/.ssh/passphrase_docker \
    && pwgen -s ${PWLEN} -1 > /root/.ssh/passphrase_docker \
    && ssh-keygen -t rsa -b 4096 -N $(cat /root/.ssh/passphrase_docker) -C "${USERMAIL}" -f /root/.ssh/id_rsa_docker \
    && git config --global user.name ${USER} \
    && git config --global user.email ${USERMAIL}

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bash"]
