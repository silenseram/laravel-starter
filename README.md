## About package

This is simple laravel starter with configured and deploy-ready docker.

###Built-in Features:

- Volumes on code folders, which brings good development experience
- Docker containerization. All you need for deploy is download code and run "docker-compose up".
- Configured PHP-FPM and PHP.
- Configured supervisor, crontab, nginx.
- Configured mysql (mariadb) database.

###Installation

1. Download the starter code
```bash
$ git clone https://github.com/silenseram/laravel-starter
```

2. Run docker-compose
```bash
$ docker-compose up -d
```

3. If necessary, you can make proxy from domain to 6006 (or whatever port you choose for php application), by using nginx config from ```deploy/external/nginx/www.conf```
