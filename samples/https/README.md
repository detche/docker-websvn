# HTTPS example via Caddy

This folder contains an example of setup that can be used to:

* Expose a single SVN repository publicly,
* Handle HTTPS via automatic certificate generation.

This is done thanks to Caddy.

We build the Caddy image from the content of the `https-proxy` folder and use
that image inside our compose file.

## Running the sample

* Create the `caddy_data` volume for persistent HTTPS data: `sudo docker volume create caddy_data`,
* Start the services: `sudo docker compose up -d`

