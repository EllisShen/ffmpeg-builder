# ffmpeg-builder
ffmpeg build for CentOS and OS X

CentOS Deendencies
==================

Before building the ffmpeg, install below required tools

Set up system::

    $ yum install autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel


Build for CentOS
==================

Specify build location by passing it to centOS.sh::

    $ sh centOS.sh /home/XXXX

After rebuilt, compiled excutable binaries are available at::

    $ ~/bin
