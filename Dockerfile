ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    && apt-get purge -y && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

COPY config .

ARG ACCOUNT
ARG USERMAIL
ARG USER

RUN git config --global user.name ${USER} \
    && git config --global user.email ${USERMAIL} \
    && mkdir --parents $HOME/.ssh && mv ./config $HOME/.ssh/ \
    && ssh-keygen -t rsa -b 4096 -N "" -C "${USERMAIL}" -f $HOME/.ssh/id_rsa_${ACCOUNT}

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bash"]
