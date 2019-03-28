<center><a href="https://MonocleCam.com" target="_blank"><img src="http://static.monoclecam.com/banner.gif" style="max-width: 100%; max-height: 100px;"/></a></center>

# Monocle Gateway

The [**Monocle Gateway**](https://monoclecam.com/monocle-gateway) service is a small service that runs inside your local/private network to facilitate discovery, secure communication and automation between your IP cameras and the [**Monocle**](https://monoclecam.com) cloud service/platform.  

<center><a href="http://static.monoclecam.com/monocle-gateway-diagram-wide.png" target="_blank"><img src="http://static.monoclecam.com/monocle-gateway-diagram-wide.png" style="max-width: 800px; max-height: 400px;"/></a></center>

More information about the [**Monocle**](https://monoclecam.com) IP camera cloud service/platform can be found here:
* [https://monoclecam.com](https://monoclecam.com)

More information about the [**Monocle Gateway**](https://monoclecam.com/monocle-gateway) service can be found here:
* [https://monoclecam.com/monocle-gateway](https://monoclecam.com/monocle-gateway)

---

# Docker Container

This is the **official** Docker image for the [**Monocle Gateway**](https://monoclecam.com/monocle-gateway) service.

### Prerequisites

T.B.D


### Networking Considerations

This project provides examples of running the **Monocle Gateway** container using the following container networking modes/drivers.

- Bridge networking
- Host networking (**PREFERRED**)
- Macvlan networking

It is important to understand the networking requirements of **Monocle Gateway** and to make the appropriate decision on which networking mode will work for your environment.  On startup the **Monocle Gateway** service attempts to auto-detect the server's IP address.  It then sends this private IP address to the **Monocle** cloud platform to create a unique DNS record for this **Monocle Gateway** instance.  It is important that the IP address that gets detected and registered is the correct local/private IP address on your network that Alexa devices can access.  Additionally, the **Monocle Gateway** service listens on TCP port 443 for secure communications with the Alexa devices.  Unfortunately only TCP port 443 can be used due to fixed requirements defined by Amazon for the Alexa Camera Controller interfaces.  The **Monocle Gateway** service must also be able to communicate out from the container to the various IP cameras on your private/local network.  Finally, the **Monocle Gateway** service supports an internal RTSP proxy server that can dynamically assign and listen on various UDP inbound ports for IP camera streams for certain stream configurations.

<a href="https://github.com/MonocleCam/monocle-gateway-docker/tree/master/examples">&gt;&gt; More details on the various networking modes for the Monocle Gateway Docker container.</a>


### Creating a new container instance using `docker-compose`
T.B.D

### Creating a new container instance from the `docker` command line.
The following command serves as an example of how to launch a [**Monocle Gateway**](https://monoclecam.com/monocle-gateway) service container instance.

```
docker run                           \
  -it                                \
  -d                                 \
  -p 443:443/tcp                     \
  --restart=always                   \
  --volume /etc/monocle:/etc/monocle \
  --name=monocle-gateway             \
  monoclecam/monocle-gateway
```

**Note** the command argument ` --volume /etc/monocle:/etc/monocle`.  This instruction is passing the `/etc/monocle` directory located on the container host to be mounted as a path inside the newly created container instance.  This allows you to place important configuration files intended for the Monocle Gateway service in a location outside the container instance such that it is durable and persists outside the container instance.  This allows you to easily upgrade and destroy/re-create Monocle Gateway container instances without having to perform instance configuration each time.   

