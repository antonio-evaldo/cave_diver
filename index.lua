function _init()
	game_over = false;
	make_player();
	make_cave();
end

function _update()
	move_and_listen_to_player();
	move_cave();
end

function _draw()
	cls(12); --clear screen
	draw_player();
	draw_cave();
end
