# Docker image for WebSVN

Docker image for an easy installation of [WebSVN](https://websvnphp.github.io/),
which is a software that allows to display the content of one or multiple SVN
repositories on a web page.

Source code of this image is available on
[GitHub](https://github.com/detche/docker-websvn).

## Features

This image features:

* WebSVN served by an embedded HTTP server:
    * SVN repositories accessed via filesystem (docker mounts or volumes)
    * Customization of the 'About' message

WebSVN is configured using near-default values. Feel free to submit a PR in
order to add further configurability.

Refer to [WebSVN's website](https://websvnphp.github.io/) for the full list of
features of the software itself.

## Non-features

This image serves as a SVN repository viewer only, it does not
include a full SVN server installation nor does it allow participation on the
underlying repositories.

Additionally, those features will not be added to this image:

* HTTPS
* Authentication/authorization

Those are best handled externally, refer to [samples](#Samples) for examples.

## Usage

Mount the individual SVN repositories under path `/repos` within container.
WebSVN is configured to expose all of its subfolders as repositories.

### Example: single repository

```
docker run --rm -p 80:80 \
    -e ABOUT_MESSAGE="This is the source code of my software." \
    -v /path/to/your/repo:/repos/PUBLIC_NAME:ro \
    detche/websvn:2.8.1 
```

Your repository would be available as `PUBLIC_NAME` on the WebSVN interface.

### Example: multiple repositories

```
docker run --rm -p 80:80 \
    -e ABOUT_MESSAGE="Welcome to our SVN repositories." \
    -v /path/to/your/first/repo:/repos/REPO1:ro \
    -v /path/to/your/second/repo:/repos/REPO2:ro \
    detche/websvn:2.8.1 
```

### Example: exposing directly the parent of one to multiple repositories

```
docker run --rm -p 80:80 \
    -e ABOUT_MESSAGE="Welcome to our SVN repositories." \
    -v /home/svn/repos:/repos:ro \
    detche/websvn:2.8.1 
```

All repositories within `/home/svn/repos` would be published identified by their
folder name.

Because the `/repos` folder is pre-created within the image, you also can use
the `--mount` flag:

```
docker run --rm -p 80:80 \
    -e ABOUT_MESSAGE="Welcome to our SVN repositories." \
    --mount type=bind,source=/home/svn/repos,target=/repos,readonly \
    detche/websvn:2.8.1 
```

## Samples

Sample(s) on how to add HTTPS and/or authentication above this image:

* [HTTPS via Caddy automatic certificates](https://github.com/detche/docker-websvb/tree/master/samples/https)
* [HTTPS + Authentication via Caddy, Caddy Security and Azure AD](https://github.com/detche/docker-websvb/tree/master/samples/auth-caddy-azure)

