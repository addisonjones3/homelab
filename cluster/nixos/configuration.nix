# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, meta, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = meta.hostname; # Define your hostname.
  networking.hostName = meta.hostname; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Fixes for longhorn
  # systemd.tmpfiles.rules = [
  #   "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  # ];
  # virtualisation.docker.logDriver = "json-file";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  #   tokenFile = /var/lib/rancher/k3s/server/token;
  #   extraFlags = toString ([
  #     "--write-kubeconfig-mode \"0644\""
  #     "--cluster-init"
  #     "--disable servicelb"
  #     "--disable traefik"
  #     "--disable local-storage"
  #   ] ++ (if meta.hostname == "homelab-0" then [ ] else [
  #     "--server https://homelab-0:6443"
  #   ]));
  #   clusterInit = (meta.hostname == "homelab-0");
  # };

  # services.openiscsi = {
  #   enable = true;
  #   name = "iqn.2016-04.com.open-iscsi:${meta.hostname}";
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.addisonjones3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    # Created using mkpasswd
    hashedPassword = "$6$xMAzKowk9bsuqI9x$3PjBCGKMFFxVzjauvfx/Rcvdm.kKyXFBpJWNnPQwQgtVA0w/MYK6LGFPWon3SWNTh/Yqo4vtjqppiyTUanI6J/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZ+m9rz8YsMBHqovU8rmNoDYfZ3gEk4Fx9/yu087ebWdxaSghe98+ncu67CkopOmH5NeuCjqwxFxgFHkylY121VPM7Dv8Dk3om5mxlcWmWg8XeQJnz344VNp7MTWaYOe3rcK+KaO5ClpAFht9YkIopBNgPpfZDeuzhlawHqTF6ZNPapbExddndMPnAWnJ8m0//jpC1Mq1+P3V+0LL8sVIP+xpdxnVMOo2cJbCmFp+cxVNJPxnF6O7K0onvbvNTjDe7A7rx9X2rYnsCJ4VYv1hF08dkih7FniTrmeiLklEaUiVRCt9CkMIQ1qLD3ocgV4TmeD2lVCHpE3utB4iWQC4yO4y5cm+auecjikrGOLt8/siemTc7tEBCFePpdqq4o/pAdi7VqKE5vJQ4SytkbujeAyddiiJVgrAUmFafbH4fKeNCnJO/xbW26uXCHKfI9dTzhzNEb7NMpAZ4dJShRzWbwMjubr27CTVcr0V+4xfM5pGgLJc/O3v8AaXndnDlUcgpETrQ+ONxrlzoBJhq5fOAW1ShFW9A+V4pl4E5p/P4P/Vz0+D7KriXtK3Qcvm5ItSJD+R5NCjvHXLTN6mj/eg6xn47QFSCn0bU8BZyp41ObPzBan0jfqA7FFaMptuFAZYh8ad8JJJYNf1ypwbx/rSMViSaNjlX6GRE2JLdXh0Xiw== addison.jones3@gmail.com"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    k3s
    cifs-utils
    nfs-utils
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
