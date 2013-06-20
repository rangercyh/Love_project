npc_module = {}
axe_image = love.graphics.newImage("res/axe.jpg")
arrow_image = love.graphics.newImage("res/arrow.png")

AXE_RANGE = 5
ARROW_RANGE = 20

AXE_POWER = 10
ARROW_POWER = 3

function npc_module:create( name, dot_up_limit, x, y, life, r, sx, sy )
	local npc_object = {}
	--npc_object.image = love.graphics.newImage(image)
	npc_object.name = name
	npc_object.dot_up_limit = dot_up_limit or 10
	npc_object.dot = 0
	npc_object.x = x
	npc_object.y = y
	npc_object.life = life or 100
	npc_object.r = r or 0
	npc_object.sx = sx or 0
	npc_object.sy = sy or 0
	--npc_object.__index = npc_module
	local metatable = {}
	metatable.__index = npc_module
	setmetatable(npc_object, metatable)
	
	npc_object:init()
	
	return npc_object
end

function npc_module:init()
	self:change_weapon()
end

function npc_module:paint()
	if self.weapon == "axe" then
		self.sx = 0.3
		self.sy = 0.3
	elseif self.weapon == "arrow" then
		self.sx = 0.1
		self.sy = 0.1
	end
	love.graphics.draw(self.image, self.x, self.y, self.r, self.sx, self.sy, 
		self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function npc_module:keyboard_check(object)
	--·½ÏòÒÆ¶¯
	if love.keyboard.isDown("up") then
		--self.y = self.y - 3
	elseif love.keyboard.isDown("down") then
		--self.y = self.y + 3
	elseif love.keyboard.isDown("left") and (self.x - self.image:getWidth() / 2 * self.sx) > 0 then
		if self.dot >= 1 then
			self.x = self.x - 1
			self.dot = self.dot - 1
		end
	elseif love.keyboard.isDown("right") and ((self.x + self.image:getWidth() / 2 * self.sx) < (object.x - object.image:getWidth() / 2 * object.sx)) then
		if self.dot >= 1 then
			self.x = self.x + 1
			self.dot = self.dot - 1
		end
	end
end

function npc_module:add_dot()
	self.dot = self.dot + 1
	if self.dot >= self.dot_up_limit then
		self.dot = 0
		self:magic_attack()
	end
end

function npc_module:change_weapon()
	if self.weapon == "axe" then
		self.weapon = "arrow"
		self.image = arrow_image
	elseif self.weapon == "arrow" then
		self.weapon = "axe"
		self.image = axe_image
	elseif self.weapon == nil then
		self.weapon = "axe"
		self.image = axe_image
	end
end

function npc_module:magic_attack()
	if self.weapon == "axe" then
	
	elseif self.weapon == "arrow" then
	
	end
end

function npc_module:attack(object)
	local my_x = self.x + self.image:getWidth() / 2 * self.sx
	local object_x = object.x - object.image:getWidth() / 2 * object.sx
	if self.weapon == "axe" then
		if object_x - my_x < AXE_RANGE then
			object.life = object.life - AXE_POWER
		else
		
		end
	elseif self.weapon == "arrow" then
		if object_x - my_x < ARROW_RANGE then
			object.life = object.life - ARROW_POWER
		else
		
		end
	end
	
	if object.life <= 0 then
		love.graphics.clear()
		LOCK = 1
	end
end

