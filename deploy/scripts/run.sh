echo "current path is ${PWD}, executing run.sh";

echo "UID = ${UID}";

grep ${UID} /etc/passwd

if [ $? -ne 0 ]; then
  echo "creating user: hostuser"

  useradd -u ${UID} hostuser
  chown -R hostuser:hostuser /app
  sed -i "s/www-data/hostuser/" /usr/local/etc/php-fpm.d/php-fpm.conf
fi

echo "running composer";
su -c "composer dump-autoload" hostuser;
su -c "composer install --working-dir=/app" hostuser;

echo "setting files permissions";
chown -R hostuser:hostuser /app;

echo "starting supervisor";
service supervisor start;
echo "supervisor booted";

echo "running cron";
service cron start;

echo "cron running";
crontab -u hostuser - < /app/deploy/cron/crontab

php-fpm --nodaemonize --fpm-config /usr/local/etc/php-fpm.d/php-fpm.conf;
