FROM debian

WORKDIR /servers

RUN apt-get update \
   && apt-get install -y wget libcurl4 \
    && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu

RUN wget -O bds-down.tar.gz https://github.com/heaveless/bds-downloader/releases/latest/download/bds-down-1.0.0-linux-amd64.tar.gz \
    && tar -xvzf bds-down.tar.gz --strip-components=1 -C /usr/bin \
    && rm bds-down.tar.gz \
    && chmod +x /usr/bin/bds-down

RUN bds-down -y

EXPOSE 19132/udp

ENTRYPOINT ["./bedrock_server"]
