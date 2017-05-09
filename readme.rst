#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Check if the protocol is already registered::

       $ gvfs-mime --query x-scheme-handler/thunderlink

#. Copy ``thunderbird-thunderlink-handler.desktop`` to the proper directory::

       $ cp thunderbird-thunderlink-handler.desktop ~/.local/share/applications/

   Most important lines::

       Exec=icedove -thunderlink %
       MimeType=x-scheme-handler/thunderlink

#. Edit ``~/.local/share/applications/mimeapps.list``

#. Add this line::

       x-scheme-handler/thunderlink=thunderbird-thunderlink-handler.desktop

#. Check if it was successfully registered::

      $ gvfs-mime --query x-scheme-handler/thunderlink
      $ icedove -thunderlink thunderlink://messageid=950124.162336@example.com
      $ xdg-open thunderlink://messageid=950124.162336@example.com

https://github.com/poohsen/thunderlink

http://edoceo.com/howto/xfce-custom-uri-handler
