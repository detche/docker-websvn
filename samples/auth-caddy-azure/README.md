# Authentication and HTTPS example via Caddy + Caddy security

This folder contains an example of setup that can be used to:

* Expose a single SVN repository,
* Secure the SVN viewer application behind an Azure AD authentication,
* Handle HTTPS via automatic certificate generation.

This is done thanks to Caddy and the Caddy-security module.

We build the Caddy image from the content of the `auth-proxy` folder and use
that image inside our compose file.

## Registration on Azure

Sample of Azure app registration that can be created to work with our setup:

* Create an "app registration" on Azure AD,
* Add a "Web" redirect URI to `https://your.domain.example.com/authportal/oauth2/azure/authorization-code-callback`,
* Create a "Client secret" and keep its value around,
* Fill in the docker compose environment variables with these:
  * Tenant ID: `Directory (tenant) id` value on registration's Overview page,
  * Client ID: `Application (client) id` value on registration's Overview page,
  * Client secret: The value of the secret you created.
