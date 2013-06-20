require("lib\\basefunction")
--require("camera")
--require("player")
require("npc_module")

monster = {}
myself = {}

LOCK = 0

time_tick = 0
ADD_DOT_TIME_KICK = 10
ATTACK_TIME_KICK = 200

--[[
z：切换武器
j：爆气技能
]]
function love.keypressed(key)
	if LOCK == 1 then
		return
	end
	if key == "z" then
		myself:change_weapon()
	elseif key == "j" then
	
	end
end

function love.load()
	--加载背景音乐
	music = love.audio.newSource("res/忧伤还是快乐.mp3") --默认是stream,动态加载,适合播放时间长的音乐
	music:setVolume(0.5)
	love.audio.play(music)
	
	
	--player:set_image("res/taotie.jpg")
	
	--加载玩家
	myself = npc_module:create("ranger", 10, 200, 200)
	
	--加载NPC
	monster = npc_module:create("bug", 10, 300, 200)
end

function love.draw()
	if LOCK == 1 then
		love.graphics.print("successful", 300, 200)
		return
	end
	--camera:set()
	love.graphics.print("Name ="..myself.name.."  me.x="..myself.x.."  me.y="..myself.y
		.."  Monster ="..monster.name.."  monster.x="..monster.x.."  monster.y="..monster.y, 20, 20)
	love.graphics.print("me.life="..myself.life.."  monster.life="..monster.life, 20, 40)
	love.graphics.print("me.dot="..myself.dot.."  monster.dot="..monster.dot, 20, 60)
	--love.graphics.print(myself.image:getWidth()*myself.sx.."  "..monster.image:getWidth()*monster.sx, 20, 80)
	--player:paint()
	--camera:unset()
	myself:paint()
	monster:paint()
end

--[[
↑↓←→：up,down,left,right
]]
function love.update(dt)
	if LOCK == 1 then
		return
	end
	--player:keyboard_check()
	myself:keyboard_check(monster)
	
	time_tick = time_tick + 1
	if math.fmod(time_tick, ADD_DOT_TIME_KICK) == 0 then
		myself:add_dot()
		monster:add_dot()
	end
	
	if math.fmod(time_tick, ATTACK_TIME_KICK) == 0 then
		myself:attack(monster)
		--monster:attack(myself)
	end
end


