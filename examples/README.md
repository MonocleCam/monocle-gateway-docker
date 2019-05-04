<center><a href="https://MonocleCam.com" target="_blank"><img src="http://static.monoclecam.com/banner.gif" style="max-width: 100%; max-height: 100px;"/></a></center>

## Monocle Gateway Container Networking

This project provides examples of running the **Monocle Gateway** container using the following container networking modes/drivers.

- Bridge networking
- Host networking (**PREFERRED**)
- Macvlan networking

It is important to understand the networking requirements of **Monocle Gateway** and to make the appopriate decision on which networking mode will work for your environment.  On startup the **Monocle Gateway** service attempts to auto-detect the server's IP address.  It then sends this private IP address to the **Monocle** cloud platform to create a unique DNS record for this **Monocle Gateway** instance.  It is important that the IP address that gets detected and registered is the correct local/private IP address on your network that Alexa devices can access.  Additionally, the **Monocle Gateway** service listens on TCP port 443 for secure communications with the Alexa devices.  Unfortunately only TCP port 443 can be used due to fixed requirements defined by Amazon for the Alexa Camera Controller interfaces.  The **Monocle Gateway** service must also be able to communicate out from the container to the vairous IP cameras on your private/local network.  Finally, the **Monocle Gateway** service supports an internal RTSP proxy server that can dynamically assign and listen on various UDP inbound ports for IP camera streams for certain stream configurtations.

---

### Bridge Networking
 
This is the default networking mode/driver that most containers use when launched using Docker.  This mode, however, is _NOT THE PREFERRED_ mode for use with Monocle Gateway.   Using bridge mode requires that the container explicitly expose individual TCP/UPD ports from the container to the host's network interface.   The Moncole Gateway supports a RTSP proxy server that can dynamically assign UDP ports to IP camera streams for certain stream configurtations.  While we can designate and asign a reserved pool of UDP ports we cannot guarnatee that the internal proxy server will honor or stay confined to the assumed address pool.  

**Note:**  Bridge mode will not work with a Monocle Gateway container if port 443 is already consumed or in use by another application on the container host.   

**Note:**  Bridge mode requires that you include a custom `monocle.properties` file in your `/etc/monocle` configuation directory that overrides the Monocle Gateway's IP address detection logic and specifies the IP address of the container host. 

<a href="bridge-network">&gt;&gt; Examples using **BRIDGE** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/bridge/

---

### Bridge Networking (Routed)
 
This used the default networking mode/driver that most containers use when launched using Docker.  However, we are going to create a new docker network for use with Monocle Gateway, and other containers, that we can route traffic to directly.   This will **NOT** require the container explicitly expose individual TCP/UPD ports from the container to the host's network interface.   Clients comunicate with the docker container directly.

**Note:**  This requires that you add a [static route](https://kb.netgear.com/24226/What-are-static-routes-and-how-do-they-work-with-my-NETGEAR-router) on your network router, where the next-hop is your docker host, and the subnet is the docker network subnet. 

#### [How to add a Static Route on Home WiFi Router](https://youtu.be/MXcab7uhrLk?t=84)
 - See your routers guide or documentation for the paticulars on how to setup a static route on your make & model of router.

#### [How to add a Static Route on a Ubiquiti Edge Router](https://community.ubnt.com/t5/EdgeRouter/static-routing-thru-CLI/td-p/770666)

  - set protocols static route **DOCKER-ROUTABLE-NETWORK** / **SUBNET** next-hop **YOUR-DOCKER-HOST-IP** 
  - Example IPv4: set protocols static route 172.10.0.0/16 next-hop 192.168.1.20
  - Example IPv6: set protocols static route 2001:db8:1::/64 next-hop 2600:1600:4820:3456:3666:45fe:ffc3:67ce

```
configure
set protocols static route 172.10.0.0/16 next-hop 192.168.1.20
set protocols static route 2001:db8:1::/64 next-hop 2600:1600:4820:3456:3666:45fe:ffc3:67ce
commit
save
exit
```

<a href="bridge-routed-network">&gt;&gt; Examples using **BRIDGE-ROUTED** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://en.wikipedia.org/wiki/Static_routing

---

### Host Networking

As long as port 443 is not already in use on your system by another service or application, host networking is the preferred mode for a Monocle Gateway container.   Host mode simply allows the container to share the network interface of the container host system.  Thus it will use the same IP address as the host and listen to TCP/UDP ports directly on the host network interface.  If TCP port 443 is already in use or if using host mode is not acceptable for your environment, then please see the MACVLAN networking section of this page.  

**Note:**  Host mode will not work with a Monocle Gateway container if port 443 is already consumed or in use by another application on the container host.   

<a href="host-network">&gt;&gt; Examples using **HOST** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/host/

---

### MACVLAN Networking

If TCP port 443 is already in use by another application or service on your container host, or if you prefer or need to assign a dedicated/static IP address to the Monocle Gateway container, the MACVLAN networking mode is the best choice. 

**Note:**  If unable to use HOST networking mode, this is the best alternative; however, it does require a bit more sophisticated configuration and understanding of the networking layer.

<a href="macvlan-network">&gt;&gt; Examples using **MACVLAN** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/macvlan/
