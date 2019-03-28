<center><a href="https://MonocleCam.com" target="_blank"><img src="http://static.monoclecam.com/banner.gif" style="max-width: 100%; max-height: 100px;"/></a></center>

## Monocle Gateway Container Networking

This project provides the following examples of running the **Monocle Gateway** container under various container networking modes.

- Bridge networking
- Host networking (**PREFERRED**)
- Macvlan networking

It is important to understand the networking requirements of Monocle Gateway and to make the appopriate decision on which networking mode will work for your environment.  On startup the Monocle Gateway service attempt to auto-detect the server's IP address.  It then sends this private IP address to the Monocle cloud to create a unique DNS record for this gateway instance.  It is important that the IP address that gets registered is the correct local IP address that Alexa devices can access on your private network.  Additionally, the Monocle Gateway service hosts access on TCP port 443 for secure communications with the Alexa devices.  The Monocle Gateway service must also be able to communicate out to the vairous IP cameras on your private/local network.  Finally, The Moncole Gateway supports a RTSP proxy server that can dynamically assign UDP ports to IP camera streams for certain stream configurtations.  

---

### Bridge Networking
 
This is the default networking mode/driver that most containers use when launched using Docker.  This mode, however, is _NOT THE PREFERRED_ mode for use with Monocle Gateway.   Using bridge mode requires that the container explicitly expose individual TCP/UPD ports from the container to the host's network interface.   The Moncole Gateway supports a RTSP proxy server that can dynamically assign UDP ports to IP camera streams for certain stream configurtations.  While we can designate and asign a reserved pool of UDP ports we cannot guarnatee that the internal proxy server will honor or stay confined to the assumed address pool.  

**Note:**  Bridge mode will not work with a Monocle Gateway container if port 443 is already consumed or in use by another application on the container host.   

**Note:**  Bridge mode requires that you include a custom `monocle.properties` file in your `/etc/monocle` configuation directory that overrides the Monocle Gateway's IP address detection logic and specifies the IP address of the container host. 

<a href="bridge-network">Examples using **BRIDGE** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/bridge/


---

### Host Networking

As long as port 443 is not already in use on your system by another service or applicafion, host networking is the preferred mode for a Monocle Gateway container.   Host mode simply allows the container to share the network interface of the container host system.  Thus it will use the same IP address as the host and listen to TCP/UDP ports directly on the host network interface.  If TCP port 443 is already in use or if using host mode is not acceptable for your environment, then please see the MACVLAN networking section of this page.  

**Note:**  Host mode will not work with a Monocle Gateway container if port 443 is already consumed or in use by another application on the container host.   

<a href="host-network">Examples using **HOST** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/host/

---

### MACVLAN Networking

**Note:**  If unable to use HOST networking mode, this is the best alternative; however, it does require a bit more sophisticated configuration and understanding of the networking layer.

<a href="macvlan-network">Examples using **MACVLAN** mode networking with Monocle Gateway</a>

> Additional information about this networking mode can be found here:
https://docs.docker.com/network/macvlan/


