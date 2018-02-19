## Why? 
Lately I wanted to run HASS on my home server vs Raspberry PI due to performance issues, unfortunately my Z-Wave controller is GPIO based one (RaZberry). I didn't want to spend another 50+ euro on a USB Z-Wave controller, so I could pass it through to VM. Solution? Serial interface over TCP/IP. Now I have Raspberry PI running as Z-Wave gateway and HASS connects to it via TCP/IP. From HASS perspective, Z-Wave controller is attached to underlying host. What happens in background: 

- ser2net is running on Raspberry PI, exposing RasZberry serial interface to the network
- In HASS Docker container socat service is running, connecting to Raspberry PI serial interface and creating virtual /dev/ttyUSB0
- HASS Z-Wave configure to use /dev/ttyUSB0


## Installation
### On raspberry pi:

- Install ser2net: ``` apt-get install ser2net ```
- Edit ser2net config: ``` nano /etc/ser2net.conf ```
- Paste at the end of config: ```3333:raw:0:/dev/ttyAMA0:115200 8DATABITS NONE 1STOPBIT```
- Restart ser2net ``` systemctl restart ser2net ```

### HASS Docker container with socat

- ``` docker run -d --name="home-assistant" -v /YOUR/CONFIG/LOCATION:/config -v /etc/localtime:/etc/localtime:ro --net=host -e ZWAVE_HOST_IP="IP_OF_RASPBERRY_PI" -e ZWAVE_HOST_PORT="3333" registry.gitlab.com/lamp0chka/hass ```