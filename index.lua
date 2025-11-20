--cave diver
--by antonio evaldo

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
		check_hit()
	else
		if btn(❎) then
			_init()
		end
	end
end

function _draw()
	cls(12)
	draw_player()
	draw_cave()

	if not game_over then
		print("score:" .. player.score, 2, 2, 7)
	else
		print("game over!", 44, 44, 7)
		print("your score:" .. player.score, 34, 54, 7)
		print("press ❎ to play again!", 18, 72, 7)
	end
end