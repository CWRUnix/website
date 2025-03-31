{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.javascript.pnpm.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # Does not seem to work :(
  #services.postgres.enable = true;
 
  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  # Not working right now 
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
    pnpm build
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    # lint shell scripts (need to figure out how to ignore)
    #shellcheck.enable = true;
    # format code
    biome.enable = true;
    # typecheck
    typecheck = {
      enable = true;
      name = "Typescript typecheck";
      entry = "pnpm tsc --noEmit";
      pass_filenames = false;
    };
  };

  # See full reference at https://devenv.sh/reference/options/

  # dotenv integration
  dotenv.enable = true;
}
