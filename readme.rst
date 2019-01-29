#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Check if the protocol is already registered::

       $ gio mime x-scheme-handler/thunderlink
       No default applications for “x-scheme-handler/thunderlink”

   If you don't have ``gio``, use ``xdg-mime`` instead::

       $ xdg-mime query default x-scheme-handler/thunderlink
       $ echo $?
       4

   Blank output and a non-zero error code from ``xdg-mime``
   mean it's not registered.

#. Copy ``thunderbird-thunderlink-handler.desktop`` to the proper directory::

       $ cp thunderbird-thunderlink-handler.desktop ~/.local/share/applications/

   Most important lines::

       Exec=thunderbird -thunderlink %u
       MimeType=x-scheme-handler/thunderlink

#. Run some commands to register the ``x-scheme-handler/thunderlink`` mimetype
   with the ``thunderbird-thunderlink-handler.desktop`` file.

   ::

       $ XDG_UTILS_DEBUG_LEVEL=2 xdg-mime default 'thunderbird-thunderlink-handler.desktop' 'x-scheme-handler/thunderlink'
       $ gio mime x-scheme-handler/myscheme2 myscheme2-handler.desktop
       Set myscheme2-handler.desktop as the default for x-scheme-handler/myscheme2

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

#. Try opening one directly with Thunderbird::

       $ thunderbird -thunderlink 'thunderlink://messageid=950124.162336@example.com'

   and then with the wrapper script::

       $ xdg-open 'thunderlink://messageid=950124.162336@example.com'

Sources:

https://github.com/poohsen/thunderlink

http://edoceo.com/howto/xfce-custom-uri-handler

https://askubuntu.com/questions/162268/adding-x-scheme-handler-without-a-popup-in-firefox

Trouble shooting:

Some applications use deprecated locations of ``mimeapps.list``.
For example, you can try editing these files:

- ``~/.local/share/applications/mimeapps.list``
- ``~/.local/share/applications/defaults.list``

and add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

.. TODO: should this go under the ``[Added Associations]`` section or the ``[Default Applications]`` section?
.. TODO: should this go under ``[Default Applications]`` section since there is no other?

.. TODO: find official source for deprecation. Maybe this: https://lists.freedesktop.org/archives/xdg/2014-February/013177.html
