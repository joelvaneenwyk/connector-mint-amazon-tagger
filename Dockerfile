FROM ubuntu:22.04

LABEL maintainer="jeff.prouty@gmail.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Add Chrome repo.
RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub \
    && gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub \
    && echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        google-chrome-stable \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN pip3 install --upgrade pip

COPY . /var/app
WORKDIR /var/app

RUN pip3 install -r /var/app/requirements/base.txt -r /var/app/requirements/ubuntu.txt

CMD ["python3", "-m", "mintamazontagger.cli", "--headless"]
