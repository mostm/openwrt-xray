openwrt-xray
------------

Install
-------
1. Drop the files onto OpenWRT (22.03 and higher) router
2. Run `install_xray.sh`: `chmod +x /root/install_xray.sh && /root/install_xray.sh`
3. Configure this installation:
- Edit this rule in `/etc/xray/startup.sh`: `iptables -t mangle -A XRAY -d 1.1.1.1 -j RETURN` to match your public static IP address
- In `/root/xray_config/04_outbounds.json` add your connection details
- You can optionally add excluding/blocking rules to `startup.sh`, see possible additions in `fwd_functions.sh` beside it.
4. Enable the `xray` service in LuCI (System -> Startup, it should be at the end of the list) and reboot your router.

(In case it fails to work, you may disable the service and reboot the router again to revert the effects)

crontab
-------
I've added these in my crontab for more stable work of router:
```
0 20 * * 0 /sbin/reboot # Reboots device at 1:00 AM UTC+5 every week
59 19 * * * /bin/bash /root/restart_xray.sh # Restarts Xray at 0:59 AM UTC+5 every day
0 * * * * /usr/sbin/logrotate -s /usr/share/logrotate/status /etc/logrotate.conf # Run logrotate every hour
```