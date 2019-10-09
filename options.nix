{ options, config, lib, ... }:

with lib;

let
  date = { config, ... }: {
    options = {
      day = mkOption {
        type = types.int;
        description = "Date day";
      };

      month = mkOption {
        type = types.int;
        description = "Date month";
      };

      year = mkOption {
        type = types.int;
        description = "Date year";
      };

      full = mkOption {
        type = types.str;
        description = "Full date representation";
        internal = true;
        default = "${toString config.day}-${toString config.month}-${toString config.year}";
      };
    };
  };

  workOptions.options = {
    description = mkOption {
      type = types.str;
      description = "Work description";
    };

    hours = mkOption {
      type = types.nullOr types.int;
      description = "Work hours";
      default = null;
    };

    amount = mkOption {
      type = types.nullOr types.int;
      description = "Work amount";
      default = null;
    };
  };
in {
  options = {
    index = mkOption {
      description = "Sequence number of invoice";
      type = types.int;
    };

    ref = mkOption {
      description = "Invoice reference";
      type = types.str;
    };

    name = mkOption {
      description = "Company name";
      type = types.str;
    };

    email = mkOption {
      description = "Company email address";
      type = types.str;
    };

    phone = mkOption {
      description = "Company phone number";
      type = types.str;
    };

    taxId = mkOption {
      description = "Company tax id";
      type = types.str;
    };

    account = {
      iban = mkOption {
        description = "Company bank account iban";
        type = types.str;
      };

      bic = mkOption {
        description = "Comapny bank account bic";
        type = types.str;
      };
    };

    address = {
      street = mkOption {
        description = "Company address street";
        type = types.str;
      };

      city = mkOption {
        description = "Company city";
        type = types.str;
      };

      country = mkOption {
        description = "Company country";
        type = types.str;
      };
    };

    date = mkOption {
      description = "Date when invoice was issued";
      type = types.submodule date;
    };

    due = mkOption {
      description = "Due date";
      type = types.submodule date;
    };

    dateOfService = {
      start = mkOption {
        description = "Start date of service";
        type = types.submodule date;
      };

      end = mkOption {
        description = "End date of service";
        type = types.submodule date;
      };
    };

    to = mkOption {
      description = "Customer details";
      type = types.listOf types.str;
      default = [];
    };

    hourlyRate = mkOption {
      description = "Hourly rate";
      type = types.int;
      default = 20;
    };

    work = mkOption {
      description = "List of work items";
      type = types.listOf (types.submodule workOptions);
      default = [];
    };

    extra = mkOption {
      description = "Extra subscript";
      type = types.listOf types.str;
      default = [];
    };

    signature = mkOption {
      description = "Path to signature file";
      type = types.nullOr types.path;
      default = null;
    };

    lang = mkOption {
      description = "Invoice language";
      type = types.enum [ "en" "sl" ];
      default = "en";
    };
  };

  config = {
    ref = mkDefault "${toString config.date.year}-${fixedWidthNumber 2 config.index}"; 
    due = {
      year = mkDefault config.date.year;
      month = mkDefault config.date.month;
    };
    dateOfService = {
      start = {
        year = mkDefault config.date.year;
        month = mkDefault config.date.month;
      };
      end = {
        year = mkDefault config.date.year;
        month = mkDefault config.date.month;
      };
    };  
  };
}
