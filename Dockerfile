# Pull image from: https://hub.docker.com/r/thomasweise/docker-texlive-full
FROM thomasweise/docker-texlive-full

# This removes errors with dialog interactions
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory to /utils
WORKDIR /utils

# Ensure environment is up to date
RUN apt-get update

# Add debian packages necessary
RUN apt-get install -f -y  build-essential
RUN apt-get install -f -y  graphviz
RUN apt-get install -f -y  python3
RUN apt-get install -f -y  python3-pip

# Install pandoc
COPY ./pandoc-2.14.2-1-amd64.deb .

RUN dpkg -i ./pandoc-2.14.2-1-amd64.deb

# Add the eisvogel template
COPY ./pandoc-latex-template/eisvogel.tex .

RUN mkdir -p /usr/share/pandoc/data/templates

RUN cp -n ./eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

# Add python requirements
RUN ln -s /usr/bin/python3 /usr/bin/python

ADD ./requirements.txt ./
RUN python3 -m pip install -r requirements.txt
