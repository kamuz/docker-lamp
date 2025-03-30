# LAMP config for WordPress and Laravel based on Docker

### Install Laravel

Setup Docker:

```
git clone git@github.com:kamuz/docker-lamp.git laravel
cd laravel/
docker-compose up -d
```

- Apache - http://localhost:8000/
- phpMyAdmin - http://localhost:8080/ (`lamp` / `lamp`)
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

### Install WordPress

Setup Docker:

```
git clone git@github.com:kamuz/docker-lamp.git wordpress
cd wordpress/
docker-compose up -d
```

- Apache - http://localhost:8000/
- phpMyAdmin - http://localhost:8080/ (`lamp` / `lamp`)
- MailHog - http://localhost:8025/

```
sudo chown -R $USER:$USER www
docker ps
docker exec -it lamp_apache bash