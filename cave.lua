#include player.lua

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
	-- -3 a 3
	local variation = -3 + flr(rnd(6))

	local new_column = {
		top_height = mid(10, last_column.top_height + variation, 52),
		bottom_height = mid(10, last_column.bottom_height + variation, 52)
	}

	for i = 1, column_width do
		add(columns, new_column)
	end
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