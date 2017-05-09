
#. Install Thunderlink add-on:

   https://addons.mozilla.org/en-Us/thunderbird/addon/thunderlink/

#. Check if it's already registered::

       $ gvfs-mime --query x-scheme-handler/thunderlink

#. Copy the ``icedove-tl.desktop`` file to proper directory in home directory::

       $ cp icedove-tl.desktop ~/.local/share/applications/

   Most important lines::

       Exec=icedove -thunderlink %
       MimeType=x-scheme-handler/thunderlink

#. Edit ``~/.local/share/applications/mimeapps.list``

#. Add this line::

       x-scheme-handler/thunderlink=icedove-tl.desktop

#. Check if it was successfully registered::

      $ gvfs-mime --query x-scheme-handler/thunderlink
      $ icedove -thunderlink thunderlink://messageid=950124.162336@example.com
      $ xdg-open thunderlink://messageid=950124.162336@example.com

https://github.com/poohsen/thunderlink

http://edoceo.com/howto/xfce-custom-uri-handler
