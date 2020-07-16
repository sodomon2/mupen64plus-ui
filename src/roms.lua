--[[--
 @package   Mupen64plus+UI
 @filename  roms.lua
 @version   1.1
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.07.2020 18:56:22 -04
]]

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
