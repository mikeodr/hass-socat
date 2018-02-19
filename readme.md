## Why? 

Already had z-wave controller in my raspberry, unfortunaly it is GPIO based one. Didn't want to spend another 50+ euro. Solution? Serial interface over TCP/IP. 


## Installation
### On raspberry pi:

- Install ser2net: ``` apt-get install ser2net ```
- Edit ser2net config: ``` nano /etc/ser2net.conf ```
- Paste at the end of config: ```3333:raw:0:/dev/ttyAMA0:115200 8DATABITS NONE 1STOPBIT```
- Restart ser2net ``` systemctl restart ser2net ```

### HASS Docker container with socat
- TODO