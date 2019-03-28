<center><a href="https://MonocleCam.com" target="_blank"><img src="http://static.monoclecam.com/banner.gif" style="max-width: 100%; max-height: 100px;"/></a></center>

## Monocle Gateway Container HOST Networking

The following examples are for using the HOST networking mode/driver for the **Monocle Gateway** Docker container.  
For other networking modes, please see: [Monocle Gateway Container Networking](../)

---

### Overview

As long as port 443 is not already in use on your system by another service or application, host networking is the preferred mode for a Monocle Gateway container.   Host mode simply allows the container to share the network interface of the container host system.  Thus it will use the same IP address as the host and listen to TCP/UDP ports directly on the host network interface.  If TCP port 443 is already in use or if using host mode is not acceptable for your environment, then please see the MACVLAN networking section of this page.  

**Note:**  Host mode will not work with a Monocle Gateway container if port 443 is already consumed or in use by another application on the container host.   

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/host/

---

### Prerequsites

The following examples assume that you have created a `/etc/monocle` directory on your host container which Docker will mount as
a path inside the newly created container instance.  This allows you to place important/required configuration files intended for 
the **Monocle Gateway** service in a location outside the container instance such that it is durable and persists external to  
the container instance.  This allows you to easily upgrade and destroy/re-create Monocle Gateway container instances without
having to manually configure each new/upgraded instance.   

Prior to launching a **Monocle Gateway** instance, you should have acquired a `monocle.token` file containing your Monocle API 
access token.  You must save the `monocle.token` file to the aforementioned `/etc/monocle` directory on your host container.

See:  http://monoclecam.com/monocle-api-token

---

### Creating a new container instance using `docker-compose`

The included [`docker-compose.yml`](docker-compose.yml) file can be used directly and does not require any modifications.
```
version: '3.4'

services:
  monocle-gateway:
    container_name: monocle-gateway
    hostname: monocle-gateway
    image: monoclecam/monocle-gateway
    restart: always
    volumes:
      - /etc/monocle:/etc/monocle
    network_mode: host
```

Download the [`docker-compose.yml`](docker-compose.yml) and then use the following command to launch the **Monocle Gateway** Docker container:
```
docker-compose up -d
```

You can also use the following command to stop and remove the **Monocle Gateway** Docker container instance:
```
docker-compose down
```


---

### Creating a new container instance from the `docker` command line.
The following command serves as an example of how to launch a [**Monocle Gateway**](https://monoclecam.com/monocle-gateway) service container instance directly from the `docker` command line.

```
docker run                           \
  -it                                \
  --detach                           \
  --network host                     \
  --restart=always                   \
  --volume /etc/monocle:/etc/monocle \
  --name=monocle-gateway             \
  monoclecam/monocle-gateway
```
