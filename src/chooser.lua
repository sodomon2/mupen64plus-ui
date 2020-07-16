--[[--
 @package   Mupen64plus+UI
 @filename  chooser.lua
 @version   1.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      16.07.2020 18:44:48 -04
]]

function ui.btn_preferences_core:on_clicked()
  ui.chooser_core:run()
  ui.chooser_core:hide()
end

function ui.btn_chooser_core_close:on_clicked()
  ui.chooser_core:hide()
end

function ui.btn_chooser_core_open:on_clicked()
  core = ui.chooser_core:get_filename(chooser)
  ui.entry_core.text = core
  ui.chooser_core:hide()
end 

function ui.btn_preferences_config:on_clicked()
  ui.chooser_config:run()
  ui.chooser_config:hide()
end

function ui.btn_chooser_config_close:on_clicked()
  ui.chooser_config:hide()
end

function ui.btn_chooser_config_open:on_clicked()
  config = ui.chooser_config:get_filename(chooser)
  ui.entry_config.text = config
  ui.chooser_config:hide()
end 

function ui.btn_preferences_plugins:on_clicked()
  ui.chooser_plugins:run()
  ui.chooser_plugins:hide()
end

function ui.btn_chooser_plugins_close:on_clicked()
  ui.chooser_plugins:hide()
end

function ui.btn_chooser_plugins_open:on_clicked()
  plugins = ui.chooser_plugins:get_filename(chooser)
  ui.entry_plugins.text = plugins
  ui.chooser_plugins:hide()
end 


function ui.btn_preferences_roms:on_clicked()
  ui.chooser_roms:run()
  ui.chooser_roms:hide()
end

function ui.btn_chooser_roms_close:on_clicked()
  ui.chooser_roms:hide()
end

function ui.btn_chooser_roms_open:on_clicked()
  roms = ui.chooser_roms:get_filename(chooser)
  ui.entry_games.text = roms
  ui.chooser_roms:hide()
end 

