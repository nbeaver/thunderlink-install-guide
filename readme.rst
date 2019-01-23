#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Check if the protocol is already registered::

       $ gio mime x-scheme-handler/thunderlink
       No default applications for “x-scheme-handler/thunderlink”

#. Copy ``thunderbird-thunderlink-handler.desktop`` to the proper directory::

       $ cp thunderbird-thunderlink-handler.desktop ~/.local/share/applications/

   Most important lines::

       Exec=thunderbird -thunderlink %u
       MimeType=x-scheme-handler/thunderlink

#. Edit ``~/.local/share/applications/mimeapps.list``

#. Add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

#. Just in case, edit ``~/.local/share/applications/defaults.list``
   and add the same line.

   This file is officially deprecated,
   but some applications use it anyway.

.. TODO: just use ``xdg-mime default x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop`` instead?
.. TODO: just use ``gio mime x-scheme-handler/thunderlink thunderbird-thunderlink-handler.desktop`` instead?

#. Check if it was successfully registered::

       $ gio mime x-scheme-handler/thunderlink
       Default application for “x-scheme-handler/thunderlink”: thunderbird-thunderlink-handler.desktop
       Registered applications:
       	thunderbird-thunderlink-handler.desktop
       Recommended applications:
       	thunderbird-thunderlink-handler.desktop

#. Try opening some::

       $ thunderbird -thunderlink thunderlink://messageid=950124.162336@example.com
       $ xdg-open thunderlink://messageid=950124.162336@example.com

Sources:

https://github.com/poohsen/thunderlink

http://edoceo.com/howto/xfce-custom-uri-handler

https://askubuntu.com/questions/162268/adding-x-scheme-handler-without-a-popup-in-firefox
