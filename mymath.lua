function math.movetowards(x, y, dt)
	if math.abs(x - y) <= dt then
		return y
	end
	if x > y then
		return x - dt
	else
		return x + dt
	end
end

function math.sign(x)
	if x < 0 then
		return -1
	else
		return 1
	end
end

function math.signz(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end

function math.round(x)
	return math.floor(x + 0.5)
end

function math.cap(x, a, b)
	return math.min(math.max(x, a), b)
end

function math.lerp(a, b, t)
	if t < 0 then return a end
	if t > 1 then return b end

	return (1 - t) * a + t * b
end

function math.rgb_lerp(r1, g1, b1, r2, g2, b2, t)
	return math.lerp(r1, r2, t), math.lerp(g1, g2, t), math.lerp(b1, b2, t)
end

function math.rgba_lerp(r1, g1, b1, a1, r2, g2, b2, a2, t)
	return math.lerp(r1, r2, t), math.lerp(g1, g2, t), math.lerp(b1, b2, t), math.lerp(a1, a2, t)
end

function math.seq(from, to)
	local t = {}
	for i=from, to do
		table.insert(t, i)
	end
	return t
end

function math.subset(t, n)
	local s = {}
	for i=1, n do
		local index = love.math.random(1, #t)
		table.insert(s, t[index])
		table.remove(t, index)
	end
	return s
end

function math.shuffle(a)
	for i=#a, 2, -1 do
		local j = love.math.random(1, i)
		local tmp = a[j]
		a[j] = a[i]
		a[i] = tmp
	end
	return a
end
