{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        substitutions."~/github" = "github.com";
      };
    };
  };
}
