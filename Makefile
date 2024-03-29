# Makefile to build the virtual environment and run common commands.

.PHONY: help
# Automatically parse recipes and their comments to display available commands.
# Ref: https://stackoverflow.com/a/35730928
# List the available commands.
help:
	@awk '/^#/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t

host = "servers"
.PHONY: install
# Install LAMP on the servers in hosts or specify a server with the host= argument.
install:
	ansible-playbook playbooks/install.yaml -l ${host}

host = "servers"
.PHONY: update
# Update the packages on the servers in hosts or specify a server with the host= argument.
update:
	ansible-playbook playbooks/update_os.yaml

blog_url = ""
host = ""
.PHONY: add-blog
# Add a blog to the specified server.
add-blog:
	@if [ ${blog_url} = "" ] || [ ${host} = "" ]; then \
		echo - Please specify the host and URL of the blog you want to add. \
		&& echo - "E.g. 'make add-blog blog_url=domain.tld host=wp-serv-1'" \
		&& exit 1;\
	fi
	ansible-playbook playbooks/add_blog.yaml -l ${host} --extra-vars "blog_url=${blog_url}"

blog_url = ""
host = ""
.PHONY: remove-blog
# Remove a blog from the specified server.
remove-blog:
	@if [ ${blog_url} = "" ] || [ ${host} = "" ]; then \
		echo - Please specify the host and URL of the blog you want to remove. \
		&& echo - "E.g. 'make remove-blog blog_url=domain.tld host=wp-serv-1'" \
		&& exit 1;\
	fi
	ansible-playbook playbooks/remove_blog.yaml -l ${host} --extra-vars "blog_url=${blog_url}"

.PHONY: clean
# Remove the .devenv, .direnv, and .venv folders.
clean:
	@rm -rf .devenv .direnv .venv
	@direnv reload

.PHONY: gc
# Removes old devenv generations.
gc:
	@devenv gc
