This Dockerfile builds an Alpine-bases image for ebusd including the Weishaupt message-definitions.                                                         

The image is a multistage build:
* first stage builds the ebusd binaries
* second stage the  resulting image.
