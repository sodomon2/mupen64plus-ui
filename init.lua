#!/usr/bin/lua5.1
--------------------------------------------------------------------------------
--Mupen64plus+UI
--------------------------------------------------------------------------------

--[[--
 @package   Mupen64plus+UI
 @filename  init.lua
 @version   1.1
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      15:40:38 -04 2019
]]


lgi       = require('lgi')            -- requiero esta libreria que me permitira usar GTK
GObject   = lgi.GObject               -- parte de lgi
GLib      = lgi.GLib                  -- para el treeview
Gtk       = lgi.require('Gtk', '3.0') -- el objeto GTK

assert    = lgi.assert
builder   = Gtk.Builder()

assert(builder:add_from_file('vistas/mupen64plus+ui.ui'),"error al cargar el archivo") -- hago un debugger, si este archivo existe (true) enlaso el archivo ejemplo.ui, si no existe (false) imprimo un error
ui = builder.objects

require('src.chooser')
require('src.roms')
require('src.interface')

ui.main_window:show_all()
Gtk.main()
