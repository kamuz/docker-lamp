# LAMP for WordPress and Laravel

It's very simple server LAMP based on files *Dockerfile* and *docker-compose.yml* for Laravel and WordPress with WP-CLI, Composer, phpMyAdmin and MailHog.

## Install Laravel

Setup Docker:

```
git clone git@github.com:kamuz/docker-lamp.git laravel
cd laravel/
docker-compose up -d
```

- Apache - http://localhost:8000/
- phpMyAdmin - http://localhost:8080/
- MailHog - http://localhost:8025/

```
sudo chown -R $USER:$USER www
docker ps
docker exec -it lamp_apache bash
composer --version
composer create-project --prefer-dist laravel/laravel .
```

*.htaccess*

```
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_URI} !^/public/
    RewriteRule ^(.*)$ /public/$1 [L,QSA]
</IfModule>
```

Check Laravel with SQlite - http://localhost:8000/

Setup MySQL and MailHog:

*.env*

```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=lamp
DB_USERNAME=lamp
DB_PASSWORD=lamp

MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
```

Run migrations:

```
php artisan migrate
```

Check Laravel with MySQL - http://localhost:8000/

Go to Tinker:

```
php artisan tinker
```

Sending test email:

```
use Illuminate\Support\Facades\Mail;

Mail::raw('This is a test email', function ($message) {
    $message->to('recipient@example.com')
            ->subject('Test Email')
            ->from('your-email@example.com');
});
```

Check Email - http://localhost:8025/

## Install WordPress

Setup Docker:

```
git clone git@github.com:kamuz/docker-lamp.git wordpress
cd wordpress/
docker-compose up -d
```

- Apache - http://localhost:8000/
- phpMyAdmin - http://localhost:8080/
- MailHog - http://localhost:8025/

```
sudo chown -R $USER:$USER www
docker ps
docker exec -it -u www-data lamp_apache bash
wp --version
php -d memory_limit=256M /usr/local/bin/wp core download
```

Run WordPress installation - http://localhost:8000/ with next DB credentials:

```
DB_NAME=lamp
DB_USER=lamp
DB_PASSWORD=lamp
DB_HOST=db
```

Send test email:

```
wp plugin install wp-mail-smtp --activate

wp config set WPMS_ON true --raw
wp config set WPMS_MAILER smtp
wp config set WPMS_SMTP_HOST mailhog
wp config set WPMS_SMTP_PORT 1025
wp config set WPMS_SSL ''
wp config set WPMS_SMTP_AUTH false --raw
wp config set WPMS_SMTP_AUTOTLS false --raw
wp config set WPMS_SMTP_USER ''
wp config set WPMS_SMTP_PASS ''

wp eval 'wp_mail("test@example.com", "Test Email", "This is a test email from WordPress.");'
```
