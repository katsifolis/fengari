[[ TODO

 solved 1. Implement a counte in Actor class (not frame_iter()) because it "eats away frames from the other objects
  2. Find a better step implementation for smooth frame transition

]]
--  Constants --

WIDTH  = 512
HEIGHT = 288

-- Mods --

u = require 'util' -- Helper functions

-- Defs --
local actor, back, frames, step, i, frame_iter, counter, objs, gas, des
local dirs, rng, planets
accel = 10
objs = {}
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
  
  -- Initializes sprite based on filename given
  set_sprite: (fln) =>
    @spr = g.newImage "assets/#{fln}.png"
    @spr\setFilter 'nearest', 'nearest'
    @ani[1] = @spr

    for i=1, 3 do
      @ani[i+1] = g.newImage("assets/#{fln .. i}.png")
      @ani[i+1]\setFilter('nearest', 'nearest')

class Player extends Actor
  input: (dt) =>
    
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


-- Creates a planet at a random (x
create_planet = () ->

  planet = Actor!
  fln_ext = planets[rng\random(1, #planets)]
  fln = string.reverse(string.sub(string.reverse(fln_ext), 5)) -- OBFUSCATED AFK --
  planet.spr = g.newImage "assets/#{fln}.png"
  planet.spr\setFilter 'nearest', 'nearest'

  planet.ani[1] = planet.spr
  for i=1, 3 do
    planet.ani[i+1] = g.newImage("assets/#{fln .. i}.png")
    print("assets/#{fln}.png")
    planet.ani[i+1]\setFilter('nearest', 'nearest')

  planet.x = rng\random(0, WIDTH)
  planet.y = rng\random(0, HEIGHT)
  print(love.math.getRandomSeed())

  planet


love.load = () ->


  -- Decides a random planet-asset in random and draws it --
  dirs = love.filesystem.getDirectoryItems("assets/")
  planets = [item for item in *dirs[,,4]] -- Finds all the names of asset folder
  rng  = love.math.newRandomGenerator(love.timer.getTime())
  ----------------------------------------------------------

  table.insert(objs, create_planet())
  table.insert(objs, create_planet())
  table.insert(objs, create_planet())
  table.insert(objs, create_planet())

  gas = Player!
  gas\set_sprite("GasGiant")
  table.insert(objs, gas)
  frame_iter = u.counter(4)

love.draw = () ->
  g.setColor 0x33, 0x33, 0x33, 0x00
  g.rectangle 'fill', 0, 0, 512, 288
  g.setColor 1,1,1
  for obj in *objs
    g.draw obj.spr, obj.x, obj.y, 0, 1, 1

-- Movement
step = 0
love.update = (dt) ->
  step += dt
  if step > .16
    step = 0
    for obj in *objs
      obj.spr = obj.ani[frame_iter()]

  gas\input(dt)
