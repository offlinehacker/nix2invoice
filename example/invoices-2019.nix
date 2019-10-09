{ pkgs ? import <nixpkgs> {}
, invoices ? import ../. { inherit pkgs; }}:

let
  base = {
    date.year = 2019;
  };
in {
  "2019-01" = invoices.mkInvoice {
    config = {
      imports = [base ./momcorp.nix ./acme.nix];

      config = {
        index = 1;
        date = { day = 10; month = 9; };
        due = { day = 15; month = 9; };
        dateOfService.start = { day = 1; month = 8; };
        dateOfService.end = { day = 31; month = 8; };
        work = [{
          description = "Development and maintainence of robots.";
          hours = 160;
        }];
      };
    };
  };

  "2019-02" = invoices.mkInvoice {
    config = {
      imports = [base ./momcorp.nix ./wayne.nix];

      config = {
        index = 2;
        date = { day = 9; month = 10; };
        due = { day = 15; month = 10; };
        dateOfService.start = { day = 1; month = 9; };
        dateOfService.end = { day = 30; month = 9; };
        work = [{
          description = "Development and research of BAT related stuff.";
          amount = 1000000;
        }];
      };
    };
  };
}
