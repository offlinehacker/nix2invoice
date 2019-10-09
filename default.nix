{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

let
  mkInvoice = import ./invoice.nix {
    inherit (pkgs) lib runCommand texlive;
  };
in {
  inherit mkInvoice;
}
