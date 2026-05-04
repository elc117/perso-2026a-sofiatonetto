FROM haskell:9.4

RUN apt-get update -o Acquire::Check-Valid-Until=false && apt-get install -y \
    libpq-dev \
    postgresql-client

WORKDIR /app

COPY bolsistas.cabal ./
RUN cabal update && cabal build --only-dependencies -j4

COPY . .
RUN cabal build -j4
RUN cp $(cabal list-bin bolsistas) /app/bolsistas-exe

EXPOSE 3000

CMD ["/app/bolsistas-exe"]