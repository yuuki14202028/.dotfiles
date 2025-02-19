{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "yuuki14202028";
    userEmail = "yuuki14202028@gmail.com";
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview]; # オススメ
    settings = {
      editor = "nvim";
    };
  };
}
