pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function init_game()
	game_over = false
	make_player()
	make_cave()
end

function _init()
	init_game()
end

function _update()
	if not game_over then
		move_and_listen_to_player()
		move_cave()
		check_hit()
	else
		if btn(❎) then
			init_game()
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
		print("game over!", 44, 44, 0)
		print("your score:" .. player.score, 34, 54, 0)
		print("press ❎ to play again!", 18, 72, 0)
	end
end
-->8
function make_player()
	player = {
		x = 24,
		y = 60,
		dy = -1, -- fall speed
		sprites = {
			rise = 2,
			fall = 3,
			dead = 4
		},
		speed = 2,
		score = 0
	}
end

function move_and_listen_to_player()
	local gravity = 0.15
	player.dy += gravity

	if btnp(2) then
		player.dy -= 1.5
		sfx(0)
	end

	player.y += player.dy

	player.score += player.speed
end

function check_hit()
	local hit = false

	for i = player.x + 2, player.x + 5 do
		local top_column_below_player = columns[i + 1].top_height >= player.y
		local bottom_column_above_player = (128 - columns[i + 1].bottom_height) <= player.y + 8

		if top_column_below_player or bottom_column_above_player then
			game_over = true
			sfx(1)
		end
	end
end

function draw_player()
	if game_over then
		spr(player.sprites.dead, player.x, player.y)
	elseif (player.dy < 0) then
		spr(player.sprites.rise, player.x, player.y)
	else
		spr(player.sprites.fall, player.x, player.y)
	end
end
-->8
function make_cave()
	columns = {
		{ top_height = 30, bottom_height = 30 }
	}

	column_width = 2

	for i = 1, 128 / column_width do
		add_cave_column()
	end
end

function add_cave_column()
	local last_column = columns[#columns]

	local new_column = {
		top_height = mid(10, last_column.top_height + get_height_variation(), 55),
		bottom_height = mid(10, last_column.bottom_height + get_height_variation(), 55)
	}

	for i = 1, column_width do
		add(columns, new_column)
	end
end

function get_height_variation()
	-- -3 a 3
	return -3 + flr(rnd(7))
end

function move_cave()
	for i = 1, column_width * player.speed do
		del(columns, columns[1])
	end

	for i = 1, player.speed do
		add_cave_column()
	end
end

function draw_cave()
	local cave_color = 1

	for i = 1, #columns do
		line(
			i - 1, 0,
			i - 1, columns[i].top_height,
			cave_color
		)

		line(
			i - 1, 127,
			i - 1, 127 - columns[i].bottom_height,
			cave_color
		)
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
__sfx__
0004000013050160501b0001b0001e0000200001000010000600000000090000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000000000
00080000320500000027050000001b050000000a0500a0500a0500a0500a0500a0500a0500a0500a0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
