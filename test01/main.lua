
--time=100
gx,gy=1024,800
qx,qy=100,100
qw,qh=6,6
nAward = 0
playSound=false
red_pix={
	["size"] = 3,
	["x"] = 0,
	["y"] = 0,
}
function drawQuad(x,y,width,height)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill",x,y,width,height)
end

function isQuadArea(x,y)
	if (x == 0) and (y == 0) then
		return 0
	end

	if (x >= qx) and (x <= qx+qw) and (y >= qy) and (y <= qy+qh) then
		return 1
	else
		return 0
	end
end

function getRedXY()
	local x = math.random(gx)
	local y = math.random(gy)
	if isQuadArea(x,y) == 1 then
		math.randomseed(os.time())
		return getRedXY()
	else
		return x, y
	end
end

function drawMouseTrack()
	--成长果
	love.graphics.setColor(255,0,0)
	love.graphics.setPointSize(red_pix.size)
	if (red_pix.x == 0) and (red_pix.y == 0) then
		local x,y = getRedXY()
		print("x,y = ", x, y)
		red_pix.x = x
		red_pix.y = y
		love.graphics.point(red_pix.x,red_pix.y)
	else
		love.graphics.point(red_pix.x,red_pix.y)
	end
	--[[
    local x, y = love.mouse.getPosition()
    if mousePos[x] == nil then
		mousePos[x] = {}
		mousePos[x][y] = 1
	else
		if mousePos[x][y] == nil then
			mousePos[x][y] = 1
		end
	end
	for x, tby in pairs(mousePos) do
		for y,_ in pairs(mousePos[x]) do
			love.graphics.point(x,y)
		end
	end
	]]
	--毁灭果
end

function love.load()
	sound = love.audio.newSource("WindowsXP登录音.wav", "static")
	music = love.audio.newSource("忧伤还是快乐.mp3") --默认是stream,动态加载,适合播放时间长的音乐
	music:setVolume(0.5)
	love.audio.play(music)
end

function love.draw()
    drawMouseTrack()
    drawQuad(qx,qy,qw,qh)
    love.graphics.print("qx="..qx.."  qy="..qy.."  award="..nAward,20,20)
	--love.graphics.print("time="..time,400,20)
end

function love.update(dt)
    --按键检测
    if(love.keyboard.isDown("up")) then
		qy=qy-math.floor(qh/3)
    end
    if(love.keyboard.isDown("down")) then
		qy=qy+math.floor(qh/3)
    end
    if(love.keyboard.isDown("left")) then
		qx=qx-math.floor(qw/4)
    end
    if(love.keyboard.isDown("right")) then
		qx=qx+math.floor(qw/4)
    end

	if isQuadArea(red_pix.x,red_pix.y) == 1 then
		red_pix.x = 0
		red_pix.y = 0
		nAward = nAward + 1
		qw = qw + 1
		qh = qh + 1
	end

    --检测小方块是否运动到窗口边界
    if(qx>=gx-qw)then
		qx=gx-qw
		playSound=true
    elseif(qx<0)then
		qx=0
		playSound=true
    end
	
	if(qy>=gy-qh)then
		qy=gy-qh
		playSound=true
    elseif(qy<=0)then
		qy=0
		playSound=true
    end


    if(playSound==true) then
		love.audio.pause(music)
        love.audio.play(sound)
        playSound=false
    else
		love.audio.resume(music)
	end

end

function love.keypressed(key)
--~     if(key=="up") then
--~     qy=qy-5
--~     elseif(key=="down") then
--~     qy=qy+5
--~     elseif(key=="left") then
--~     qx=qx-5
--~     elseif(key=="right") then
--~     qx=qx+5
--~     end
end