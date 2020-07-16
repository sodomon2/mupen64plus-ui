--[[--
 @package   Mupen64plus+UI
 @filename  inteface.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.07.2020 19:00:09 -04
]]

function ui.menu_help_button:on_button_press_event()
   ui.about_window:run()
   ui.about_window:hide()
end

function ui.menu_file_quit:on_button_press_event()
   Gtk.main_quit()
end

function ui.btn_preferences:on_clicked()
   ui.window_preferences:show()
end

function ui.btn_cancel_preferences:on_clicked()
   ui.window_preferences:hide()
end

ui.time.label = os.date("%Y-%m-%d %H:%M:%S")
GLib.timeout_add_seconds(
    GLib.PRIORITY_DEFAULT, 1,
   function()
        ui.time.label = os.date("%Y-%m-%d %H:%M:%S")
    return true
end
)

function ui.btn_accept_preferences:on_clicked()
	roms_view()
  ui.window_preferences:hide()
end

--que hacer cuando cierren la ventana principal
function ui.main_window:on_destroy()
    Gtk.main_quit()         --Cierro la ventana
end
