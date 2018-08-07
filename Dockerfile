# Based on https://hub.docker.com/r/teaegg/alpine-scrapyd/~/dockerfile

FROM python:3.7-alpine3.8

RUN \
  apk --update --no-cache add \
    libxslt \
    libxml2 \
    libpq && \
  apk --no-cache --virtual .build-packages add \
    git \
    build-base \
    libxslt-dev \
    libxml2-dev \
    libffi-dev \
    python-dev \
    postgresql-dev && \
  pip install \
    git+https://github.com/scrapy/scrapy.git \
    git+https://github.com/scrapy/scrapyd.git \
    git+https://github.com/scrapy/scrapyd-client.git \
    git+https://github.com/scrapinghub/scrapy-splash.git \
    simplejson \
    psycopg2 && \
  apk del .build-packages && \
  rm -rf /root/.cache

EXPOSE 6800

CMD ['scrapyd']
