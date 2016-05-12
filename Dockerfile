FROM ubuntu

RUN apt-get update && apt-get install git ssh -y && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD entrypoint.sh /entrypoint.sh

VOLUME /srv/gitrepo

ENV SECRET_KEY_LOCATION /run/secrets/git/id.rsa
ENV GIT_BRANCH master
ENV DELAY 5

ENTRYPOINT ["/entrypoint.sh"]