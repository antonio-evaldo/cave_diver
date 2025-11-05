function make_cave()
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

	local new_bottom_height = flr(rnd(20));

	local new_column = {
		top = columns[#columns].top + flr(-3 + rnd(6)),
		bottom = columns[#columns].bottom + flr(-3 + rnd(6))
	};

	for i=1,column_width do
		add(columns, new_column);
	end
end

function move_cave()
	-- delete first column
	for i=1,column_width do
		del(columns, columns[1]);
	end

	add_cave_column();
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
