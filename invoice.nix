{ lib, runCommand, texlive }:

{

# Invoice input attrs
  config

}:

with lib;

let
  input = (evalModules { modules = [ ./options.nix config ]; }).config;

  i18n = import (./i18n + "/${input.lang}.nix");

  clsFile = builtins.toFile "invoice.cls" (import ./invoice.cls.nix {
    inherit lib input i18n;
  });

  texFile = builtins.toFile "${input.ref}.nix" (import ./template.tex.nix {
    inherit lib input i18n;
  });

in runCommand "invoice-${input.ref}" {
  buildInputs = [ texlive.combined.scheme-full ];
} ''
  mkdir $out
  cd $out
  mkdir images
  cp ${clsFile} $out/invoice.cls
  cp ${texFile} $out/invoice.tex
  ${optionalString (input.signature != null) ''
  cp ${input.signature} images/signature.png
  ''}
  pdflatex -synctex=1 -interaction=nonstopmode $out/invoice.tex
''
