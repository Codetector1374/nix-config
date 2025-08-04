{
  config,
  lib,
  pkgs,
  ...
} : {

  hardware.sane = {
    enable = true;
    brscan4.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gscan2pdf
  ];

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "brother-scanner-udev";
      text = builtins.readFile ../etc/98-scanner-udev.rules;
      destination = "/etc/udev/rules.d/98-scanner-udev.rules";
    })
  ];
}
