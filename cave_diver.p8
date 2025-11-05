pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
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

-->8
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

	if (btnp(2)) then
		player.dy -= 1.5;
	end

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

-->8
function make_cave()
	time_counter = 0;
	
	columns = {
		{ top = 30, bottom = 30 }
	};

	column_width = 2;

	for i=1,128/column_width do
		add_cave_column();
	end
end

function add_cave_column()
	local min_height = 10;

	-- local new_bottom_height = flr(rnd(20));

	local new_column = {
		top = columns[#columns].top + -3 + rnd(6),
		bottom = columns[#columns].bottom + -3 + rnd(6)
	};

	for i=1,column_width do
		add(columns, new_column);
	end
end

function move_cave()
	time_counter += 1;

	if (time_counter % 2) then
		-- delete first column
		for i=1,column_width do
			del(columns, columns[1]);
		end

		add_cave_column();
	end
end

function draw_cave()
	local cave_color = 1;

	for i=1,#columns do
		line(
			i-1, 0,
			i-1, columns[i].top,
			cave_color
		);

		line(
			i-1, 127,
			i-1, 127 - columns[i].bottom,
			cave_color
		);
	end
end

__gfx__
0000000000000000009aa700009aa700008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000111110009aaaa7009aaaa70088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700017771009a1aa1a79a1aa1a7889889880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000017171009aaaaaaa9aaaaaaa888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000017771009a1111aa9aa11aaa888998880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700017171009aa11aaa9aa11aaa889889880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000111110009aaaaa009aaaaa0088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000099990000999900008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
