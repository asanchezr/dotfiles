FROM bash:5

LABEL maintainer="Alejandro Sanchez <emailforasr@gmail.com>"

ENV VERSION 0.1.0

# Optional Configuration Parameter
ARG SYSTEM_TZ

# Default Settings (for optional Parameter)
ENV SYSTEM_TZ ${SYSTEM_TZ:-America/Vancouver}

ENV SERVICE_USER bashuser
ENV SERVICE_HOME /home/${SERVICE_USER}

RUN \
  adduser -h ${SERVICE_HOME} -s /bin/bash -u 1000 -D ${SERVICE_USER} && \
  apk add --no-cache \
    bash-completion \
    dumb-init \
    git \
    tzdata && \
  cp /usr/share/zoneinfo/${SYSTEM_TZ} /etc/localtime && \
  echo "${SYSTEM_TZ}" > /etc/TZ && \
  git clone --depth=1 https://github.com/asanchezr/bash-git-prompt.git /tmp/bash-git-prompt && \
  cp -R /tmp/bash-git-prompt /root/.bash-git-prompt && \
  cp -R /tmp/bash-git-prompt ${SERVICE_HOME}/.bash-git-prompt && \
  echo -e "\n# Load git-prompt\n[ -f /root/.bash-git-prompt/git-prompt.sh  ] && source /root/.bash-git-prompt/git-prompt.sh" >> /root/.bashrc && \
  echo -e "\n# Load bash-completion\n[ -f /usr/share/bash-completion/bash_completion  ] && source /usr/share/bash-completion/bash_completion" >> /root/.bashrc && \
  chown -R ${SERVICE_USER}:${SERVICE_USER} ${SERVICE_HOME} && \
  sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
  apk del git tzdata && \
  rm -rf /tmp/{.}* /tmp/*

USER ${SERVICE_USER}

WORKDIR ${SERVICE_HOME}

RUN \
  echo -e "\n# Load git-prompt\n[ -f ${SERVICE_HOME}/.bash-git-prompt/git-prompt.sh  ] && source /root/.bash-git-prompt/git-prompt.sh" >> ${SERVICE_HOME}/.bashrc && \
  echo -e "\n# Load bash-completion\n[ -f /usr/share/bash-completion/bash_completion  ] && source /usr/share/bash-completion/bash_completion" >> ${SERVICE_HOME}/.bashrc

ENTRYPOINT [ "/usr/bin/dumb-init", "bash" ]