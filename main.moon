-- Entry Point --

-- Mods --
u = require 'util' -- Helper functions

-------------------------- Defs --------------------------
local actor, back, frames, step, i, frame_iter, counter, objs, gas, des
accel = 10   --
----------------------------------------------------------

{graphics: g, keyboard: kbd} = love

class Actor
  new: =>
    @x    = 0
    @y    = 0
    @sx   = 0
    @sy   = 0
    @vx   = 0
    @vy   = 0
    @flp  = false
    @will = 10
    @mana = 10
    @spr  = nil
    @ani  = {}
  
  say_hi: ->
    print "Hello there"

  -- Initializes sprite based on filename given
  set_sprite: (fln) =>
    @spr = g.newImage "assets/#{fln}.png"
    @spr\setFilter 'nearest', 'nearest'
    @ani[1] = @spr

    for i=1, 3 do
      @ani[i+1] = g.newImage("assets/#{fln .. i}.png")
      @ani[i+1]\setFilter('nearest', 'nearest')

  movement: (dt) =>
    
    -- calculate velocity and speed 
    @x  += @vx * dt
    @y  += @vy * dt
    @vx *= math.pow(0.02, dt)
    @vy *= math.pow(0.02, dt)

    @vx -= dt * 1000 if kbd.isDown("a")
    @vx += dt * 1000 if kbd.isDown("d")
    @vy += dt * 1000 if kbd.isDown("s")
    @vy -= dt * 1000 if kbd.isDown("w")

    if kbd.isDown("space")
       @x = 200
       @y = 200


love.load = () ->
  -- Initial --
  objs = {}
  gas = Actor!
  gas\set_sprite("GasGiant")
  table.insert(objs, gas)

  des = Actor!
  des.x = 20
  des.y = 20
  des\set_sprite("Desert")
  table.insert(objs, des)
  i = 0
  frame_iter = u.counter(4)


love.draw = () ->
  g.setColor 0x33, 0x33, 0x33, 0xff
  g.rectangle 'fill', 0, 0, 512, 288
  g.setColor 1,1,1
  for obj in *objs
    g.draw obj.spr, obj.x, obj.y, 0, 1, 1

-- Movement
step = 0
love.update = (dt) ->
  step += dt
  if step > .166
    step = 0
    gas.spr = gas.ani[frame_iter()]
    des.spr = des.ani[frame_iter()]
  gas\movement(dt)

