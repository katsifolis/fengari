-- Mods --
u = require 'util' -- Helper functions
require 'actor'
require 'defs'
require "game"

--  Creates a planet at a random (x,y)
--  TODO number of animation sprites hardcoded
create_planet = () ->

  planet = Actor!
  fln_ext = planets[G.rng\random(1, #planets)]
  fln = string.reverse(string.sub(string.reverse(fln_ext), 5)) -- OBFUSCATED AFK --
  planet.spr = g.newImage "assets/#{fln}.png"
  planet.spr\setFilter 'nearest', 'nearest'

  planet.ani[1] = planet.spr
  for i=1, 3 do
    planet.ani[i+1] = g.newImage("assets/#{fln .. i}.png")
    planet.ani[i+1]\setFilter('nearest', 'nearest')

  planet.x = G.rng\random(48, WIDTH)
  planet.y = G.rng\random(48, HEIGHT)

  planet


love.load = () ->
--  Decides a random planet-asset in random and draws it --

  dirs = love.filesystem.getDirectoryItems("assets/")
  planets = [item for item in *dirs[,,4]] -- Finds all the names of asset folder
  ----------------------------------------------------------

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
  -- @FIXME frame_iter() isn't guaranteed to produce 4 numbers if there are
  -- a lot of planets to animate or when step is low number.
  if step > .16
    step = 0

    for obj in *objs
      obj.spr = obj.ani[frame_iter()]

  gas\input(dt)
