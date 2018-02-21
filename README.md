SEGR5910 Guestbook Application
==============================

This project uses Docker to deploy a sample Guestbook application with primary and replica Redis servers. 


Prerequisites
-------------

You will need to have the following installed:

_Git_
Type the following into the command shell to verify:
`git version`
If not installed, click here for [download instructions] (https://git-scm.com/downloads)

_Docker_ 
Type the following into the command shell to verify:
`docker version`
If not installed, click here for [download instructions](https://docs.docker.com/install/)

_Ubuntu_
To see if installed, enter the following in the command shell: 
`docker images` 
(If installed, 'ubuntu' will be listed under REPOSITORY.)

If Ubuntu is not installed, run the following in the command shell: 
`docker pull ubuntu`


Getting Started
---------------

Clone this repository.
In the command shell, cd into desired location and enter the following:
`git clone https://github.com/a-grieco/SEGR5910.git`


Deployment
----------

In the command shell cd into the cloned repository:
`cd SEGR5910`

Run the following inside the SEGR5910 directory:
`docker-compose up`

When loading is complete, go to localhost:3000 in your browser.
The sample application should be running.


### Acknowledgments

Ed and Greg pointed me in all the right directions,
face-palmed graciously when I took many wrong ones,
and offered help when I got stuck.