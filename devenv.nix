# devenv.nix
{ ... }:

{
  name = "Ansible Wordpress";

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.poetry = {
    enable = true;
    activate.enable = true;
    install.enable = true;
    install.quiet = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
