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
		score = 0,
		hitbox_bottom = 8 -- coordenada y da hitbox desejada, contando a partir do topo do sprite.
	}
end

function move_and_listen_to_player()
	gravity = 0.15
	player.dy += gravity

	if btnp(2) then
		player.dy -= 1.5
	end

	player.y += player.dy
end

function check_hit()
	local ceil_hit = player.y < 0
	local floor_hit = player.y + player.hitbox_bottom > 128

	if ceil_hit or floor_hit then
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