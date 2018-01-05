FROM alpine

RUN apk update upgrade
RUN apk add nginx php7 php7-curl php7-fpm php7-mbstring php7-ctype php7-json php7-session php7-openssl
RUN adduser -D -g 'www' www

ADD nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /run/nginx
ADD grav-skeleton-learn2-with-git-sync-site.zip grav-skeleton-learn2-with-git-sync-site.zip
RUN unzip -q /grav-skeleton-learn2-with-git-sync-site.zip
RUN mv /grav-skeleton-learn2-with-git-sync-site /var/www/grav
RUN mkdir /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled
ADD grav-site.nginx.conf /etc/nginx/sites-available/grav-site
RUN ln -s /etc/nginx/sites-available/grav-site /etc/nginx/sites-enabled/grav-site
ADD www.conf /etc/php7/php-fpm.d/www.conf

# Add admin account just so I don't have to keep filling out the form
ADD admin.yaml /var/www/grav/user/accounts/admin.yaml

# Turn on processing of Twig in page content so we can use our remote markdown
# rendering plugin
ADD system.yaml /var/www/grav/user/config/system.yaml

# This adds a "twig" call to our remote markdown plugin {{ example() }}
ADD chapter.md /var/www/grav/user/pages/01.basics/chapter.md

# This is the quick and dirty plugin I wrote to render remote markdown
COPY RemoteMarkdown /var/www/grav/user/plugins/RemoteMarkdown

RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /var/www
#RUN ./bin/gpm install admin
CMD php-fpm7 ; nginx -g 'daemon off;'
