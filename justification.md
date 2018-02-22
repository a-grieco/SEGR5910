Why use Docker/Containers?
--------------------------

According to the IniTech team’s specifications, they want to avoid a Platform as a Service offering so that they can have more flexibility in their deployment. Choosing a container technology like Docker will allow the team a higher degree of flexibility in deployment and may allow them to have more control over the application behavior (setting the number of instances, determining how to scale, etc.) based on the container Orchestrator used. (Docker works with a number of different container Orchestration tools.) 

Using Docker containers also allows more flexibility if the IniTech team ever needed to switch providers. As opposed to using a traditional Platform as a Service which requires building solutions that fit into the provider’s model and can cause a ‘lock in’ to their service; Docker containers can be configured to whatever model meets the needs of the particular application being deployed independent of provider requirements. 

Finally, using containers removes some of the complexity that would be involved in employing other alternatives to the Platform as a Service model. For example, deploying using Virtual Machines is a heavyweight process that requires managing and configuring VM instances in order for the application behave as needed (availability, handling peak loads, etc.) without over- or under-provisioning. In contrast, containers are lightweight and allow developers to set up the deployment simply by defining application requirements. Even more extreme, containers avoid having to build from scratch as would be the case moving toward an Infrastructure as a Service model; which would be a drastic change and a much larger undertaking.


Implementation and Lessons Learned
----------------------------------

To deploy the example-webapp, I used Docker Compose (per Greg’s strong recommendation). This allows running multi-container Docker applications: in this case, one container for the web application and two for the redis master and replica servers.

The Dockerfile and initialization script are set up in the same way as the in-class demo. For the Dockerfile, in addition to what is listed in the demo, it retrieves the example web application needed from the corrected go-file version in the SEGR 5910 class repository (the same wget step done manually in the demo) and retrieves and installs redis. (I had a lot of help from Ed figuring out how the Dockerfile setup works.)

The Docker Compose solution adds a docker-compose.yml. This is set to the most recent version of the file format (version 3). The file defines three services: ‘webapp’, ‘redis-master’, and ‘redis-slave’. The first service names the example-webapp built by the Dockerfile in the current directory (hence ‘build: .’) and exposes ports 3000:3000 as required by the application. The latter two services name redis primary (master) and replica (slave) servers to match the application’s calls to ‘redis-master:6379’ and ‘redis-slave:6379’ in the main.go file. As mentioned in the assignment instructions, the command ‘redis-server --slaveof redis-master 6379’ is used to connect the replica redis server to the primary redis server on port 6379 (again, synonymous with the port indicated in the application’s Go file).

Once all the files are in place, deployment simply requires entering the command: ‘docker-compose up’ from in the root of the directory containing the docker-compose.yml file. Further, after the initial solution has been built, tweaking and making changes is much easier and faster than loading Docker containers outside of Docker Compose. Instead of reloading everything from the base image upwards, it will reuse containers and only worry about the portions that have changed.


How to improve and/or extend the solution if given more time
------------------------------------------------------------

I signed up for an account with Docker Cloud and if I had more time, I would push the application image to a registry and try to set up the service to be scalable. It doesn’t seem like the first step in this process would be too difficult, but I don’t trust that I have enough time to be able to make sure I can get it to work.

From what I can tell from the documentation, for basic scalability, it seems all that needs to be done at this point is to tag the image, initialize Docker Swarm, and then deploy the stack using a modified docker-compose.yml. In addition, the modifications needed for basic scaling seem fairly straightforward (provided you know what the application requirements are). It would simply add requirements for the number of instances, how much CPU to use, when to replicate, etc. This would simply be the addition of a couple lines of code under the indicated services. 

In the demo, they added the following lines to the .yml file under service in order to “[ru]n 5 instances of that image as a service called web, limiting each one to use, at most, 10% of the CPU (across all cores), and 50MB of RAM” and to “[i]mmediately restart containers if one fails.”

> deploy:  
>       replicas: 5  
>       resources:  
>         limits:  
>           cpus: "0.1"  
>           memory: 50M  
>       restart_policy:  
>         condition: on-failure  

This doesn’t seem too painful a step to be able to achieve scaling *manually*: by defining the number of instances for each of the services in the application. However, this is only one step toward being able to deploy the application in a means that is *production*-worthy. This doesn’t handle elastic/automatic scaling in the way that you would expect a proper Orchestrator to manage. It looks like there are several ways to do this: namely going the route of using Docker Swarm to set up containers on VMs to ultimately have more control over the infrastructure portion of deployment, or going in the direction of allowing cloud providers to do that sort of heavy lifting. That would take quite a bit more work than slightly modifying the .yml.
