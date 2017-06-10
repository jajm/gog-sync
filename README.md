# GOG.com synchronization tool

This tool allows you to synchronize your games files (installers, extras) on a
local hard drive to make sure you always have a local copy of what you bought on
GOG.com

# Requirements

* Perl (>= 5.14) and the following modules:
    * Modern::Perl
    * LWP::UserAgent
    * HTTP::Request
    * YAML
    * JSON
    * Number::Bytes::Human
* [aria2] (a command-line download manager)

# Quick start

1. `git clone https://github.com/jajm/gog-sync.git`
2. `cd gog-sync`
3. `cp config.yaml.orig config.yaml`
4. Edit config.yaml according to comments in that file
5. Run `bin/size` to check that your config file is correct and to estimate the
   total size of your collection
6. Run `bin/gog-to-aria2 > downloads.list` to create a file suitable for [aria2]
7. Run `aria2c -i downloads.list` to start the downloads

[aria2]: https://aria2.github.io/

# License

MIT
