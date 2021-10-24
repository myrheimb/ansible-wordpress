# Ansible WordPress

Quickly set up one or more LAMP servers designed to host multiple WordPress blogs.
The current configuration is for Ubuntu servers.

## Get started

- Clone the repo `git clone https://github.com/myrheimb/ansible-wordpress.git`.
- In the `hosts` file change the following:
  - `YOUR_SERVER_HOSTNAME`
  - `YOUR_SERVER_IP_ADDRESS`
  - `/PATH/TO/YOUR/SSH/KEY`
  - Any other `[servers:vars]` that might differ from your setup or preference.
- Run `make install` to install LAMP on all servers or specify a single server with the `host=HOST` argument.
- To add a blog, run `make add-blog blog_url=DOMAIN.COM host=HOST`.
- To remove a blog, run `make remove-blog blog_url=DOMAIN.COM host=HOST`.

**Note:** While there are some settings in these playbooks and templates for the sake of security, I highly recommend that you tighten it further if you plan on using this repo to add servers and WordPress blogs in production.

### Available `make` commands:
```
help           List the available commands.
install        Install LAMP on the servers in hosts or specify a server with the host= argument.
update         Update the packages on the servers in hosts or specify a server with the host= argument.
add-blog       Add a blog to the specified server.
remove-blog    Remove a blog from the specified server.
install-venv   Set up a virtual environment and install the Python dependencies.
update-venv    Update and lock version pins for the Python dependencies.
clean          Remove .venv and any .pyc files.
```
