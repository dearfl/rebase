FROM docker.io/alpine:3.22

LABEL \
  "name"="Rebase Local Branch" \
  "repository"="https://github.com/dearfl/rebase" \
  "maintainer"="dearfl <i@flr.me>"

RUN apk add --no-cache \
			bash \
			git \
			openssh-client && \
		echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
