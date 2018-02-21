# SEGR5910 Guestbook Application

This will deploy the sample Guestbook application using Docker. 
...What will this do for you

### Prerequisites

You will need Docker installed [instructions here](https://docs.docker.com/install/).
You will need to have Ubuntu saved as an image
(if not, run the command `docker pull ubuntu`)

## Getting Started

clone my repo

REMEMBER TO CHANGE BASE IMAGE BACK TO UBUNTU

~~~~
DOCKERFILE
things
~~~~

`docker build . -t [image name]`

`docker run -it -p 0.0.0.0:3000:3000 [image name]`

Example:

`docker build . -t guestbook`

`docker run -it -p 0.0.0.0:3000:3000 guestbook`