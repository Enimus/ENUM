CPUMiner-Multi
==============

###NOTE: Wolf's cpuminer-multi is no longer maintained - please use https://github.com/genesismining/sgminer-gm.

This is a multi-threaded CPU miner, fork of [LucasJones](//github.com/lucasjones)' cpuminer-multi.

#### Table of contents

* [Algorithms](#algorithms)
* [Dependencies](#dependencies)
* [Download](#download)
* [Build](#build)
* [Usage instructions](#usage-instructions)
* [Donations](#donations)
* [Credits](#credits)
* [License](#license)

Algorithms
==========
#### Currently supported
 * ✓ __cryptonight__ (Bytecoin [BCN], Monero)

Dependencies
============
* libcurl			http://curl.haxx.se/libcurl/
* jansson			http://www.digip.org/jansson/ (jansson is included in-tree)

Download
========
* For binary releases, see Bitcointalk thread: https://bitcointalk.org/index.php?topic=632724
* Git tree:   https://github.com/wolf9466/cpuminer-multi
* Clone with `git clone https://github.com/wolf9466/cpuminer-multi`

Build
=====

#### Basic *nix build instructions:
 * ./autogen.sh	# only needed if building from git repo
 * Optimal GCC flags are built in - you only need to use -march=native if you want it
  * # Use -march=native if building for a single machine
 * With AES-NI:
 * CFLAGS="*-march=native*" ./configure
 * Without AES-NI:
 * CFLAGS="*-march=native*" ./configure --disable-aes-ni
 
 * make

#### Architecture-specific notes:
 * CryptoNight works only on x86 and x86-64.
 * If you don't have AES-NI, it's slower. A lot slower, around 1/3rd the speed. This implementation is deprecated and will not be improved.

Usage instructions
==================
Run "minerd --help" to see options.

Example command line
==================
./minerd -a cryptonight -o stratum+tcp://mine.moneropool.com:3333 -p x -u 42QWoLF7pdwMcTXDviJvNkWEHJ4TXnMBh2Cx6HNkVAW57E48Zfw6wLwDUYFDYJAqY7PLJUTz9cHWB5C4wUA7UJPu5wPf4sZ -t `nproc`

### Connecting through a proxy

Use the --proxy option.

To use a SOCKS proxy, add a socks4:// or socks5:// prefix to the proxy host  
Protocols socks4a and socks5h, allowing remote name resolving, are also available since libcurl 7.18.0.

If no protocol is specified, the proxy is assumed to be a HTTP proxy.  
When the --proxy option is not used, the program honors the http_proxy and all_proxy environment variables.

Donations
=========
Donations for the work done in this fork are accepted at
* XMR: `42QWoLF7pdwMcTXDviJvNkWEHJ4TXnMBh2Cx6HNkVAW57E48Zfw6wLwDUYFDYJAqY7PLJUTz9cHWB5C4wUA7UJPu5wPf4sZ`
* BTC: `1WoLFumNUvjCgaCyjFzvFrbGfDddYrKNR`

Credits
=======
This faster CPUMiner-multi was forked from LucasJones', and has been developed by Wolf.
Special thanks to Intel for helping me with the usage of the AESKEYGENASSIST instruction, which I used to replace the calls to the slow, unoptimized oaes_lib.
Special thanks also to dga for his code with that loop - since it runs over 500,000 times per hash, it's extremely important.

License
=======
GPLv2.  See COPYING for details.
