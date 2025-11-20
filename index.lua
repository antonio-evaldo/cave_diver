#include player.lua
#include cave.lua

function _init()
	game_over = false
	make_player()
	make_cave()
end

function _update()
	if not game_over then
		move_and_listen_to_player()
		move_cave()
	end

	check_hit()
end

function _draw()
	--clear screen
	cls(12)
	draw_player()
	draw_cave()
end