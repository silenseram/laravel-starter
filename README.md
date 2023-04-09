## About package

This is simple laravel starter with configured and deploy-ready docker.

### Built-in Features:

- Volumes on code folders, which brings good development experience
- Docker containerization. All you need for deploy is download code and run "docker-compose up".
- Configured PHP-FPM and PHP.
- Configured supervisor, crontab, nginx.
- Configured postgres database with pgadmin.

### Installation

1. Download the starter code
```bash
$ git clone https://github.com/silenseram/laravel-starter
```

2. Go to downloaded project and run init command
```bash
$ make init
```

3. Run project and enjoy!
```bash
$ make up
```

4. If necessary, you can make proxy from domain to 8080 (or whatever port you choose for php application), by using nginx config from ```deploy/external/nginx/www.conf```


### Tips

 - To enter the php container run `make phpsh`