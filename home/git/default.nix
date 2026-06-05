{ vars, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name  = "${vars.username}";
      user.email = "${vars.email}";

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lg = "log --oneline --graph --all";
      };

      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
      };
      color = {
        ui = "auto";
      };
    };
  };
}