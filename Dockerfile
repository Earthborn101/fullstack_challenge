FROM bitwalker/alpine-elixir-phoenix:latest

COPY mix.exs .
COPY mix.lock .

RUN mkdir assets

COPY assets/package.json assets
COPY assets/package-lock.json assets

COPY . $HOME

CMD mix deps.get && cd assets && npm install && cd .. && mix ecto.create && mix ecto.migrate && mix phx.server