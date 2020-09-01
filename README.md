Markdown Wiki
=============

A small script that uses [`pandoc`](http://pandoc.org/) to generate static html sites
out of a file hierarchy of [markdown](https://de.wikipedia.org/wiki/Markdown) files.
It uses only html and CSS.
A useful editor to write Markdown files is [MarkdownPad](http://markdownpad.com/).

The generated Wiki looks like:

![WikiPreview](wiki_example.png)



Quick start guide
-----------------

First you have to ensure that `pandoc` is installed.
Use the following commands for e.g. on ubuntu:

~~~~~~
sudo apt install -y pandoc
~~~~~~

To install the needed files into the user local binary folder:

~~~~~~
./install.sh
~~~~~~

Or provide a custom installation path:

~~~~~~
sudo ./install.sh /usr/bin
~~~~~~

To generate the Webpage into the folder `/share/data/wiki/`
if the source wiki folder is at `/var/www/html/wiki/` you call the script as follows:

~~~~~~
mdwiki.sh /share/data/wiki/ /var/www/html/wiki/
~~~~~~



Source File Structure
---------------------

The main feature of this script is to process a whole folder structure of markdown and other files
and generates the same folder structure under the destination path
but with all markdown files (`.md`) converted to HTML.
All other files are simply copied.

Each markdown file needs one single special line for the title at the top of the file:

~~~~~~
% My Files Title
~~~~~~

This title is later used for the link name in the navigation list.

In addition each folder (also the root) needs an `index.md` file.
Contains the same title line and possible additional generic content that is relevant for this folder.
Usually those files are simply empty except the tile line which defines the displayed name of this sub-page.

Ensure all file names contain no spaces!



Example file structure
----------------------

~~~~~~
wiki
|- index.md
|- tools
|  |- index.md
|  |- tmux.md
|  +- bash.md
+- others
   |- index.md
   |- dos.md
   +- example.png
~~~~~~



Serve the webpage
-----------------

To serve the generated webpage e.g. [`lighttpd`](https://www.lighttpd.net/) can be used.

~~~~~~
sudo apt install -y lighttpd
sudo rm -f /var/www/html/index.lighttpd.html
~~~~~~

Change the config file as follows:

~~~~~~
sudo nano /etc/lighttpd/lighttpd.conf
~~~~~~

~~~~~~
server.follow-symlink = "enable"
index-file.names            = ( "index.html" )
static-file.exclude-extensions = ( ".pl", ".fcgi" )
~~~~~~

And restart the service:

~~~~~~
sudo systemctl restart lighttpd
~~~~~~

Now everything under `/var/www/html/` is shared on the port `80`.
So for example generate your wiki in the folder: `/var/www/html/wiki/`.



Re-generate the wiki each day
-----------------------------

A simple use case for this script is to have a wiki folder with markdown and other files
that is converted to a static webpage each day and is served as described before.
A simple way to achieve this is to use an systemd-timer unit.
An example already exist in the files `markdown-wiki.service` and `markdown-wiki.timer`.
You simply have to adapt all the paths in the `.service` file
and use the following script to install and activate the timer unit.

~~~~~~
sudo ./install-timer.sh
~~~~~~

To trigger the generation manually you can use:

~~~~~~
sudo systemctl start markdown-wiki.service
~~~~~~



License
-------

MIT



Versioning
----------

There exists no version numbers, releases, tags or branches.
The master should be considered the current stable release.
All other existing branches are feature/development branches and are considered unstable.



Author Information
------------------

Christian Lang
[lang.chr86@gmail.com](mailto:lang.chr86@gmail.com)
