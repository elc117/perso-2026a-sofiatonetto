FROM haskell:9.8.4

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    pkg-config \
 && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN cabal update && \
    cabal build && \
    cp "$(cabal list-bin bolsistas)" /usr/local/bin/bolsistas

EXPOSE 3000

CMD ["bolsistas"]