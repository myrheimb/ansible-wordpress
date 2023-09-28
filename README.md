# Ansible WordPress

Quickly set up one or more LAMP servers designed to host multiple WordPress blogs.
The current configuration is for Ubuntu servers.

## Requirements
- [Nix](https://nixos.org/download#download-nix)
- [devenv](https://devenv.sh/getting-started)
- [direnv](https://direnv.net/docs/installation.html)

## Setting up
Clone and `cd` into the repo, write `direnv allow`, hit enter, and watch the magic happen!
Devenv will automatically take care of setting up everything as [Nix derivations](https://zero-to-nix.com/concepts/derivations), create a Python virtual environment, activate it, and install the packages specified in the `pyproject.toml` file.

This project will be completely isolated and not make any global changes.

## Usage
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
help          List the available commands.
install       Install LAMP on the servers in hosts or specify a server with the host= argument.
update        Update the packages on the servers in hosts or specify a server with the host= argument.
add-blog      Add a blog to the specified server.
remove-blog   Remove a blog from the specified server.
clean         Remove the .devenv, .direnv, and .venv folders.
gc            Removes old devenv generations.
```

### Add or update Python packages
To add a new Python package, simply write `poetry add package`, and poetry will add it to the `pyproject.toml` file, resolve dependencies in `poetry.lock`, and install the package in the virtual environment.
Similarly, writing `poetry remove package` will do the reverse.

If you want to update a package version, you can write `poetry add package@latest`.
