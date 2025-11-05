function make_cave()
	cave_color = 1;

	upper_columns = {};
	bottom_columns = {};

	min_height = 10;
	column_width = 2;

	for i=1,128/4 do
		new_upper_height = rnd(20);
		new_bottom_height = rnd(20);

		add_cave_column(
			new_upper_height,
			new_bottom_height
		);
	end
end

function add_cave_column(upper_height, bottom_height)
	for i=1,column_width do
		add(upper_columns,min_height + upper_height);
		add(bottom_columns,min_height + bottom_height);
	end
end

function move_cave()
	del(
		upper_columns,
		upper_columns[#upper_columns]
	);

	-- add_cave_column(rnd(20), rnd(20));
	-- add_cave_column(rnd(20), rnd(20));
	
	-- del(
	-- 	upper_columns,
	-- 	upper_columns[2]
	-- );
end

function draw_cave()
	for i=1,#upper_columns do
		line(
			i-1, 0,
			i-1, upper_columns[i],
			cave_color
		);
	end
	
	for i=1,#bottom_columns do
		line(
			i-1, 127,
			i-1, 127 - upper_columns[i],
			cave_color
		);
	end
end
