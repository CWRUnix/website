{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  # https://devenv.sh/basics/
  # Rec just means "recursive" and is a special Nix function that allows you to access variables defined in the same scope.
  env = {
    GREET = "devenv";
    DB_PASSWORD = "password";
    DB_USER = "postgres";
    DB_PORT = 5432;
    DB_NAME = "cwrunix";
    #DATABASE_URL = "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_CONTAINER_NAME}:${DB_PORT}/${DB_NAME}";
    DATABASE_URL =
      let
        postgres = config.services.postgres;
        database = builtins.elemAt (config.services.postgres.initialDatabases) 0;
      in
      "postgresql://${database.user}:${database.pass}@localhost:${toString postgres.port}/${database.name}";
  };

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
  ];

  # https://devenv.sh/languages/
  languages.javascript = {
    enable = true;
    pnpm.enable = true;
  };
  languages.typescript.enable = true;

  # Launches on `devenv up`
  # https://devenv.sh/processes/
  processes = {
    serve-website = {
      exec = "pnpm install && pnpm build && pnpx serve out";
      process-compose = {
        depends_on.postgres.condition = "process_healthy";
        readiness_probe = {
          http_get = {
            host = "localhost";
            scheme = "http";
            path = "/";
            port = 3000;
          };
          initial_delay_seconds = 1;
        };
      };
    };
  };

  # Launches in the background on `devenv up`
  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    listen_addresses = "*"; # Listen on all available network interfaces. This is only for developers, so we are not concerned about database security.
    # https://devenv.sh/reference/options/#servicespostgreslisten_addresses
    initialDatabases = [
      {
        name = config.env.DB_NAME;
        user = config.env.DB_USER;
        pass = config.env.DB_PASSWORD;
      }
    ];
    port = config.env.DB_PORT;
  };

  # Create bash scripts here.
  # "Define scripts that can be invoked inside the environment, using all the packages and environment variables."
  # https://devenv.sh/scripts/
  # Running `hello` will run the script
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  # This is run on `devenv shell`, or if you have direnv enabled, it will run when you `cd` into the directory.
  enterShell = ''
    hello
    git --version
    pnpm install
  '';

  # "Form dependencies between automation code, executed in parallel and written in your favorite language."
  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # Runs on `devenv test`. Will run after `devenv up`.
  # Runtime tests should go here, commmit tests should go in the git-hooks.
  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
    pnpm build
  '';

  # Runs on commit. Prevents commits if the tests fail.
  # Pick from builtin and language-specific linters and formatters using git-hooks.nix; https://github.com/cachix/git-hooks.nix?tab=readme-ov-file#hooks
  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    # lint shell scripts (need to figure out how to ignore)
    #shellcheck.enable = true;
    # format code
    biome = {
      enable = true;
      settings = {
        configPath = "./biome.jsonc";
      };
    };
    # typecheck
    typecheck = {
      enable = true;
      name = "Typescript typecheck";
      entry = "pnpm tsc --noEmit";
      pass_filenames = false;
      types = [
        "ts"
        "tsx"
      ];
    };
  };

  # See full reference at https://devenv.sh/reference/options/

  # dotenv integration
  #dotenv.enable = true;
}
