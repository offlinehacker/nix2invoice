{ pkgs ? import <nixpkgs> {}
, lib ? pkgs.lib
, invoices ? import ../. { inherit pkgs; }}:

with lib;

let
  invoices-2019 = import ./invoices-2019.nix { inherit pkgs invoices; };
in rec {
  invoices = invoices-2019;

  all = pkgs.linkFarm "invoices" (mapAttrsToList (name: invoice: {
    name = "${name}.pdf";
    path = "${invoice}/invoice.pdf";
  }) invoices);
}
