ARG BASE_VERSION
FROM cimg/python:${BASE_VERSION}
ARG PKG_VERSION
LABEL version ${BASE_VERSION}_${PKG_VERSION}
ARG DEBIAN_FRONTEND=noninteractive

################
# SYSTEM SETUP #
################
RUN echo "*** install system build dependencies ***"
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  gifsicle \
  git \
  libjpeg-progs \
  optipng \
  python3-setuptools \
  python3-venv \
  unrar \
  && rm -rf /var/lib/apt/lists/*

USER circleci
RUN pip install -U poetry
COPY ci ci

USER root
RUN ci/mozjpeg.sh
RUN ci/pngout.sh
USER circleci
