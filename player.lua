function make_player()
	player = {
		x = 24,
		y = 60,
		dy = -1, --fall speed
		rise = 2,
		fall = 3,
		dead = 4,
		speed = 2,
		score = 0,
	};
end

function move_and_listen_to_player()
	gravity = 0.15;
	player.dy += gravity;

	if (btnp(2)) then player.dy -= 1.5;

	player.y += player.dy;
end

function draw_player()
	if (game_over) then
		spr(player.dead, player.x, player.y);
	elseif (player.dy < 0) then
		spr(player.rise, player.x, player.y);
	else
 	 spr(player.fall, player.x, player.y )
	end
end
