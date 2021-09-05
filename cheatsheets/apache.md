# Apache cheatsheet

## configuration files
Different configuration files are stored in `/etc/apache2/*-available`
- `/etc/apache2/conf-available`:  System configurations
- `/etc/apache2/sites-available`: Sites config (ports, local directory, etc...)
- `/etc/apache2/mod-available`:   Modules/addons (eg. php, etc...)

To enable/disable configurations, use the following commands:
- `a2enconf` / `a2disconf`: toggle a configuration
- `a2enmod` / `a2dismod`:   toggle a module
- `a2ensite` / `a2dissite`: toggle a site (virtual host)

## status
to get the current status of the apache service, run
`systemctl status apache2.service`

## logs
logs can be found in the `/var/log/apache2/` (unless configured otherwise) 
for a convenient live-view, filtering, syntax highlighting, etc, you can use:
```
lnav /var/log/apache2/
```  
