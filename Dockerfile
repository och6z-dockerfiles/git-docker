ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    #pwgen \
    openssh-client \
    && apt-get purge -y && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

COPY config .

ARG ACCOUNT
ARG USERMAIL
ARG USER
#ARG PWLEN

RUN mkdir --parents $HOME/.ssh && mv ./config $HOME/.ssh/ \
    && touch $HOME/.ssh/passphrase_${ACCOUNT} \
    && dd if=/dev/urandom bs=32 count=1 2>/dev/null | sha256sum -b | sed 's/ .*//' > $HOME/.ssh/passphrase_${ACCOUNT} \
    && ssh-keygen -t rsa -b 4096 -N $(cat $HOME/.ssh/passphrase_${ACCOUNT}) -C "${USERMAIL}" -f $HOME/.ssh/id_rsa_${ACCOUNT} \
    && git config --global user.name ${USER} \
    && git config --global user.email ${USERMAIL}

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bash"]
