{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
    users.groups = {
        plugdev = {
            gid = 1099;
        };
        dialout = {
            gid = 27;
        };
    };

    services.udev.packages = [
        (pkgs.writeTextFile {
            name = "usb-debugger-udev";
            text = builtins.readFile ../etc/99-jtag-udev.rules;
            destination = "/etc/udev/rules.d/99-jtag-udev.rules";
        })
    ];
}