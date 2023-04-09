echo "current path is ${PWD}, executing run.sh";

echo "UID = ${UID}";

sed -i "s/www-data/dev/" /usr/local/etc/php-fpm.d/php-fpm.conf

echo "running composer";
su -c "composer dump-autoload" dev;
su -c "composer install --working-dir=/app" dev;

echo "setting files permissions";
chown -R dev:dev /app;

echo "starting supervisor";
service supervisor start;
echo "supervisor booted";

echo "running cron";
service cron start;

echo "cron running";
crontab -u dev - < /app/deploy/cron/crontab

php-fpm --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/php-fpm.conf;
