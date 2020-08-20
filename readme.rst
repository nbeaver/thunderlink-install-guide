.. -*- coding: utf-8 -*-

Installing and configuring Thunderlink on Linux
===============================================

:Author: Nathaniel Beaver
:Date: $Date: 2019-06-05 (Wednesday, 5 June 2019) $
:Copyright: This document has been placed in the public domain.

Detailed instructions
---------------------

#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Get an example Thunderlink and test it directly.

   Right-click an email and choose "ThunderLink..." > "thunderlink".
   This will save it to the clipboard.
   It should look something like this::

       thunderlink://messageid=123456.789012@example.com

   or this as a clickable URL:

   `<thunderlink://messageid=123456.789012@example.com>`_

   Next, test the thunderlink URL directly from the command line like this::

       $ thunderbird -thunderlink 'thunderlink://messageid=123456.789012@example.com'

   If this works, proceed to the next step
   to start registering the ``thunderlink://`` URL scheme.

#. Check if the ``thunderlink://`` protocol is already registered.

   For GNOME 3, use ``gio``::

       $ gio mime x-scheme-handler/thunderlink
       No default applications for “x-scheme-handler/thunderlink”

   For KDE Plasma 5, use ``ktraderclient5``::

       $ ktraderclient5 --mimetype 'x-scheme-handler/thunderlink'
       mimetype is : x-scheme-handler/thunderlink
       got 0 offers.

   For all FreeDesktop-conformant desktops, use``xdg-mime``::

       $ xdg-mime query default x-scheme-handler/thunderlink
       $ echo $?
       4

   Blank output and a non-zero error code from ``xdg-mime``
   mean it's not registered.

#. Install the desktop file.

   Either via ``desktop-file-install``::

       $ desktop-file-install --dir=$HOME/.local/share/applications/ thunderbird-thunderlink-handler.desktop

   or manually copy the ``thunderbird-thunderlink-handler.desktop`` file
   to the proper directory,
   which should be ``~/.local/share/applications/``::

       $ cp thunderbird-thunderlink-handler.desktop ~/.local/share/applications/

   These are the important lines in the desktop file::

       Exec=thunderbird -thunderlink %u
       MimeType=x-scheme-handler/thunderlink

#. Make the desktop file executable.

   ::

       $ chmod +x $HOME/.local/share/applications/thunderbird-thunderlink-handler.desktop

   This is necessary `because of security precautions`_.

   .. _because of security precautions: https://askubuntu.com/questions/419610/permission-of-a-desktop-file

#. Run some commands to register the ``x-scheme-handler/thunderlink`` mimetype
   to the ``thunderbird-thunderlink-handler.desktop`` file.

   Using ``gio``::

       $ gio mime x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop
       Set thunderbird-thunderlink-handler.desktop as the default for x-scheme-handler/thunderlink

   Using ``xdg-mime``::

       $ XDG_UTILS_DEBUG_LEVEL=2 xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'

   On my machine, these commands add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

   to the configuration file ``~/.config/mimeapps.list``
   under the ``[Added Associations]`` section.

#. Check if it was successfully registered::

       $ gio mime x-scheme-handler/thunderlink
       Default application for “x-scheme-handler/thunderlink”: thunderbird-thunderlink-handler.desktop
       Registered applications:
       	thunderbird-thunderlink-handler.desktop
       Recommended applications:
       	thunderbird-thunderlink-handler.desktop

   If you don't have ``gio``, use ``xdg-mime`` instead::

       $ xdg-mime query default x-scheme-handler/thunderlink
       thunderbird-thunderlink-handler.desktop
       $ echo $?
       0

#. Try opening a thunderlink directly with Thunderbird again::

       $ thunderbird -thunderlink 'thunderlink://messageid=123456.789012@example.com'

   and then with ``xdg-open`` to test the desktop file::

       $ xdg-open 'thunderlink://messageid=123456.789012@example.com'

#. Finally, some applications read ``mimeinfo.cache``
   instead of ``mimeapps.list``, so regenerate the cache
   with ``update-desktop-database``.

   ::

       $ update-desktop-database ~/.local/share/applications

Troubleshooting
---------------

Some applications use the old location for ``mimeapps.list``
instead of ``~/.config/``.
To fix this, edit this file with a text editor::

    $ edit ~/.local/share/applications/mimeapps.list

and manually add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

under the "[Default Applications]" group.
(This location is listed as "`for compatibility, deprecated`_"
by the FreeDesktop standard.)

.. _for compatibility, deprecated: https://standards.freedesktop.org/mime-apps-spec/1.0.1/ar01s02.html

There is also an `even older deprecated file`_ called ``defaults.list``
that is still used by some applications.
Handle this in the same way; edit this file with a text editor::

    $ edit ~/.local/share/applications/defaults.list

and manually add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

under the "[Default Applications]" group.

.. _even older deprecated file: https://lists.freedesktop.org/archives/xdg/2014-February/013177.html


Sources
-------

- http://edoceo.com/howto/xfce-custom-uri-handler
- https://github.com/mikehardy/thunderlink
- https://addons.thunderbird.net/en-US/thunderbird/addon/thunderlink/

Related
-------

- https://askubuntu.com/questions/162268/adding-x-scheme-handler-without-a-popup-in-firefox
- https://askubuntu.com/questions/514125/url-protocol-handlers-in-basic-ubuntu-desktop
- https://fredrik.wendt.se/2014/11/08/uri-scheme-desktop-entry/
- https://lists.freedesktop.org/archives/xdg/2010-October/011641.html
- https://unix.stackexchange.com/questions/38650/adding-bindings-for-ed2k-links-with-xdg-open
- https://unix.stackexchange.com/questions/497146/create-a-custom-url-protocol-handler
- https://unix.stackexchange.com/questions/55214/how-to-override-the-gnome-3-ssh-handler/100736
