player = {}
player.x = 300
player.y = 400
player.sx = 0.2
player.sy = 0.2
player.r = 0
player.image = 0

function player:set_image(szImage)
	self.image = love.graphics.newImage(szImage)
end

function player:get_x()
	return self.x
end

function player:get_y()
	return self.y
end

function player:paint()
	love.graphics.draw(self.image, self.x, self.y, self.r, self.sx, self.sy, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function player:keyboard_check()
	if love.keyboard.isDown("j") then
		self:scale_line_change(0.01, 0.01)
	elseif love.keyboard.isDown("k") then
		self:scale_line_change(-0.01, -0.01)
	elseif love.keyboard.isDown("r") then
		self:rotate(0.03)
	end
	
	--方向移动
	if love.keyboard.isDown("up") then
		self:move_y(-3)
	elseif love.keyboard.isDown("down") then
		self:move_y(3)
	elseif love.keyboard.isDown("left") then
		self:move_x(-3)
	elseif love.keyboard.isDown("right") then
		self:move_x(3)
	end
end

function player:rotate(r)
	self.r = self.r + r
end

--比例变化
function player:scale(sx, sy)
	sx = sx or 1
	self.sx = self.sx * sx
	self.sy = self.sy * (sy or sx)
end

--线性变化
function player:scale_line_change(sx, sy)
	self.sx = self.sx + sx
	self.sy = self.sy + sy
end

function player:move_x(d)
	self.x = self.x + d
end

function player:move_y(d)
	self.y = self.y + d
end




