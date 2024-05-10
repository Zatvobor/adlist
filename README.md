## adlist

This is a quite simple utility for managing `NXDOMAIN` static DNS records driven by RouterOS.
You will be able to specify as many `hosts` files you have and get a sorted and uniq bundle as a `.auto.rsc` script.

The resulted bundle has a form:

```
:do {
  :local hosts {"example.com";"example2.com";"example3.com";};
  :foreach host in=$hosts do={
    :do { /ip/dns/static add name=$host type=NXDOMAIN comment=unified } on-error={ :nothing };
  }
}

```

I've added a `submodule` [which contains a curated list](https://github.com/StevenBlack/hosts) of hosts, in case if you don't have any.

See `mkadlist.sh` before you hit it and change it for your needs.
