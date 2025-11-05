function _init()
	game_over = false;
	make_player();
	make_cave();
end

function _update()
	move_player();
	move_cave();
end

function _draw()
	cls(12); --clear screen
	draw_player();
	draw_cave();
end
