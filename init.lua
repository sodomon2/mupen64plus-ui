#!/usr/bin/lua5.3
--------------------------------------------------------------------------------
--Mupen64plus+UI
--------------------------------------------------------------------------------

--[[--
 @package   Mupen64plus+UI
 @filename  init.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      15:40:38 -04 2019
]]


local lgi       = require('lgi')            -- requiero esta libreria que me permitira usar GTK

local GObject   = lgi.GObject               -- parte de lgi
local GLib      = lgi.GLib                  -- para el treeview
local Gtk       = lgi.require('Gtk', '3.0') -- el objeto GTK

local assert    = lgi.assert
local builder   = Gtk.Builder()

assert(builder:add_from_file('vistas/mupen64plus+ui.ui'),"error al cargar el archivo") -- hago un debugger, si este archivo existe (true) enlaso el archivo ejemplo.ui, si no existe (false) imprimo un error
local ui = builder.objects

local  main_window          = ui.main_window  -- invoco la ventana con el id main_window
local  about_window         = ui.about_window                           -- invoco al boton con el id btn_correr
local  window_preferences   = ui.window_preferences                          -- invoco al boton con el id btn_correr

function ui.menu_help_button:on_button_press_event()
   about_window:run()
   about_window:hide()
end

function ui.menu_file_quit:on_button_press_event()
   Gtk.main_quit()
end

function ui.btn_preferences:on_clicked()
   window_preferences:show()
end

function ui.btn_cancel_preferences:on_clicked()
   window_preferences:hide()
end

--que hacer cuando cierren la ventana principal
function main_window:on_destroy()
    Gtk.main_quit()         --Cierro la ventana
end

ui.time.label = os.date("%Y-%m-%d %H:%M:%S")
GLib.timeout_add_seconds(
    GLib.PRIORITY_DEFAULT, 1,
   function()
        ui.time.label = os.date("%Y-%m-%d %H:%M:%S")
    return true
end
)

main_window:show_all()
Gtk.main()