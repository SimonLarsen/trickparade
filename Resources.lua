local Resources = {}

Resources.SOUND_INTERVAL = 0.1

local images = {}
local animators = {}
local fonts = {}
local sounds = {}
local music

function Resources.initialize()
	Resources.getImageFont("small.png", " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.,:;-?!'*")
end

function Resources.getImage(path)
	if images[path] == nil then
		images[path] = love.graphics.newImage("data/images/" .. path)
	end
	return images[path]
end

function Resources.getAnimator(path)
	if animators[path] == nil then
		local f = love.filesystem.load("data/animators/" .. path)
		animators[path] = f()
	end
	return animators[path]
end

function Resources.getFont(path, size)
	if fonts[path .. size] == nil then
		fonts[path .. size] = love.graphics.newFont("data/fonts/" .. path, size)
	end
	return fonts[path .. size]
end

function Resources.getImageFont(path, glyphs)
	if fonts[path] == nil then
		fonts[path] = love.graphics.newImageFont("data/fonts/" .. path, glyphs)
	end
	return fonts[path]
end

function Resources.playSound(path)
	if sounds[path] == nil then
		sounds[path] = love.audio.newSource("data/sfx/" .. path, "static")
	end
	love.audio.play(sounds[path])
end

function Resources.playMusic(path)
	if music then music:stop() end

	music = love.audio.newSource("data/music/" .. path, "stream")
	music:setLooping(true)
	love.audio.play(music)
end

return Resources
