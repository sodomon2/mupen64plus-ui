#!/usr/bin/lua5.1
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

local roms_select = nil

function get_roms()
  local selection = ui.tree_roms:get_selection()
  selection.mode = 'SINGLE'
   local rom, iter = selection:get_selected()
   if rom and iter then
      roms_select = rom:get_value(iter, 0):get_string()
   end
   return roms_select
end

function run_game(roms_select)
	local ok, err = print('error')
	if (not ok) then
		return false, err
	end
	roms_select = nil
	return true
end 

function ui.btn_play:on_clicked()
	local rom = get_roms()
	if ( not rom ) then
		print('Seleccione un rom de la lista')
	else
		roms_game = run_game(roms)
		os.execute("mupen64plus " .. get_roms() )
	end
end

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

--que hacer cuando cierren la ventana principal
function ui.main_window:on_destroy()
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

function rom_directory(directory)
    local pfile = assert(io.popen(("find '%s' -mindepth 1 -maxdepth 1 -printf '%%f\\0'"):format(directory), 'r'))
    local list = pfile:read('*a')
    pfile:close()

    local folders = {}

    for filename in string.gmatch(list, '[^%z]+') do
        table.insert(folders, filename)
    end

    return folders
end

for _, item in pairs(rom_directory("/")) do
	ui.list_roms:append({ item })
end

function roms_view()
	if ( ui.entry_games.text ~= "" ) then
		ui.list_roms:clear()
		for i, v in ipairs(rom_directory(ui.entry_games.text)) do
			ui.list_roms:append({ v })
		end
	end
end

function ui.btn_accept_preferences:on_clicked()
	roms_view()
  ui.window_preferences:hide()
  ui.entry_games.text = ui.entry_games.text
end

ui.main_window:show_all()
Gtk.main()
