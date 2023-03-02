# Authentication and HTTPS example via Caddy + Caddy security

This folder contains an example of setup that can be used to:

* Expose a single SVN repository,
* Secure the SVN viewer application behind an Azure AD authentication,
* Handle HTTPS via automatic certificate generation.

This is done thanks to Caddy and the Caddy-security module.

We build the Caddy image from the content of the `auth-proxy` folder and use
that image inside our compose file.

