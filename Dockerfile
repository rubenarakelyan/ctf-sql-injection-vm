FROM ubuntu:17.04
MAINTAINER Ruben Arakelyan <ruben@ra.me.uk>
# Set shell to bash
SHELL ["/bin/bash", "-c"]
# Update packages
RUN apt-get update && apt-get -y upgrade
# Install helper packages
RUN apt-get -y install dirmngr curl
# Install RVM, ruby 2.4.0 and bundler
# `/bin/bash -l -c` is used here because `source /etc/profile.d/rvm.sh` won't work
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm reload && rvm install 2.4.0"
RUN /bin/bash -l -c "gem install bundler"
# Install packages used by the web app
RUN apt-get -y install nginx
# TODO: Install useful tools
RUN apt-get -y install net-tools nano
# Copy the notes app into the container
COPY notes_app /var/www/notes_app/
# Copy the nginx config and remove the default site
COPY notes_app.nginx.conf /etc/nginx/sites-available/notes_app
RUN ln -s /etc/nginx/sites-available/notes_app /etc/nginx/sites-enabled
RUN rm /etc/nginx/sites-enabled/default
# Set up the site
WORKDIR /var/www/notes_app
RUN chmod +x startup.sh
RUN /bin/bash -l -c "bundle"
# Start everything up
CMD ["/bin/bash", "-l", "-c", "/var/www/notes_app/startup.sh"]
EXPOSE 80
