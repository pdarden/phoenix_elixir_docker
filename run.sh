#!/bin/sh
set -e

# Wait for Postgres to become available.
echo "Checking for Postgres..."
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# Start the web server
echo "iex -S mix phx.server"
iex -S mix phx.server
