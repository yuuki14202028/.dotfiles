
{pkgs, ...}: let
  patched-idea = pkgs.jetbrains.idea-ultimate;
  requiredLibPath = with pkgs; lib.makeLibraryPath [
    libGL
    udev
    flite
    alsa-lib
  ];
  idea = pkgs.symlinkJoin {
    name = "idea-ultimate-wrapped";
    paths = [patched-idea];
    buildInputs = [pkgs.makeWrapper];
    postBuild = let
      desktopEntryPath = "/share/applications/idea-ultimate.desktop";
      path = "/bin/idea-ultimate";
    in
    ''
    if [[ -L "$out/share/applications" ]]; then
      rm "$out/share/applications"
      mkdir "$out/share/applications"
    else
      rm "$out${desktopEntryPath}"
    fi

    sed -e "s|Exec=${patched-idea + path}|Exec=$out${path}|" \
      "${patched-idea + desktopEntryPath}" \
      > "$out${desktopEntryPath}"
    
    wrapProgram "$out${path}" \
      --prefix LD_LIBRARY_PATH : ${requiredLibPath}
    '';
  };
in {
  home.packages = with pkgs; [
    android-studio
    jetbrains.webstorm
    jetbrains.rust-rover
  ] ++ [idea];
}
