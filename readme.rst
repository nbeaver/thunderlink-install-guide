Installing and configuring Thunderlink on Linux
===============================================

#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Get an example Thunderlink and test it directly.

   Right-click an email and choose "ThunderLink..." > "thunderlink".
   This will save it to the clipboard.
   It should look something like this::

       thunderlink://messageid=123456.789012@example.com

   Next, test the thunderlink URL directly from the command line like this::

       $ thunderbird -thunderlink 'thunderlink://messageid=123456.789012@example.com'

   If this works, proceed to the next step
   to start registering the ``thunderlink://`` URL scheme.

#. Check if the ``thunderlink://`` protocol is already registered::

       $ gio mime x-scheme-handler/thunderlink
       No default applications for “x-scheme-handler/thunderlink”

   If you don't have ``gio``, use ``xdg-mime`` instead::

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

#. Run some commands to register the ``x-scheme-handler/thunderlink`` mimetype
   to the ``thunderbird-thunderlink-handler.desktop`` file.

   Using ``gio``::

       $ gio mime x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop
       Set thunderbird-thunderlink-handler.desktop as the default for x-scheme-handler/thunderlink

   Using ``xdg-mime``::

       $ XDG_UTILS_DEBUG_LEVEL=2 xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'

   On my machine, these commands add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

   to the configuration file ``~/.local/share/applications/mimeapps.list``
   under the ``[Added Associations]`` section.

   .. TODO: is this necessary? update-desktop-database ~/.local/share/applications

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

Sources:

https://github.com/poohsen/thunderlink

http://edoceo.com/howto/xfce-custom-uri-handler

https://askubuntu.com/questions/162268/adding-x-scheme-handler-without-a-popup-in-firefox

Troubleshooting:

Some applications use deprecated locations of ``mimeapps.list``.
For example, you can try editing these files:

- ``~/.local/share/applications/mimeapps.list``
- ``~/.local/share/applications/defaults.list``

and add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

.. TODO: should this go under the ``[Added Associations]`` section or the ``[Default Applications]`` section?
.. TODO: should this go under ``[Default Applications]`` section since there is no other?

.. TODO: find official source for deprecation. Maybe this: https://lists.freedesktop.org/archives/xdg/2014-February/013177.html
