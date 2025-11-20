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
	end

	player.y += player.dy
end

function check_hit()
	local hit = false

	-- top hitbox
	for i = player.x + 2, player.x + 6 do
		local top_column_below_player = columns[i + 1].top_height >= player.y

		if top_column_below_player then
			hit = true
		end
	end

	-- bottom hitbox
	for i = player.x + 2, player.x + 6 do
		local bottom_column_above_player = (128 - columns[i + 1].bottom_height) <= player.y + 8

		if bottom_column_above_player then
			hit = true
		end
	end

	if hit then
		game_over = true
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