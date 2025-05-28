{
  environment.etc.issue.source = ./marker2.txt;

  # FIXME: Fix issue output on tty1

  # services.getty = {
  #   extraArgs = [ "-I" (builtins.readFile ./marker.txt) ];
  # };
}
