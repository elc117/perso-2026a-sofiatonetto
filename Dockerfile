FROM haskell:9.8.4

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

COPY . .

RUN cabal update && \
    cabal build && \
    cp "$(cabal list-bin bolsistas)" /usr/local/bin/bolsistas

EXPOSE 3000

CMD ["bolsistas"]