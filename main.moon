-- Mods --
_          = require 'defs' -- Globals
u          = require 'util'
game       = require 'game'
-- G --
local zawurado
frame_adv = u.counter(4)

love.load = () ->
  zawurado = game.Game!
  zawurado\init(50, "assets")
  zawurado.player\set_sprite("GasGiant")
  table.insert(zawurado.objs, zawurado.player)


love.draw = () ->
  hey = 1
  g.setColor 0x33, 0x33, 0x33, 0x00
  g.rectangle 'fill', 0, 0, 512, 288
  g.setColor 1,1,1
  for obj in *zawurado.objs
    g.draw obj.spr, obj.x, obj.y, 0, 1, 1


-- Movement
step = 0
love.update = (dt) ->
  step += dt
  -- @FIXME frame_iter() isn't guaranteed to produce 4 numbers if there are
  -- a lot of planets to animate or when step is low number.
  if step > .16
    step = 0
    for obj in *zawurado.objs
      obj.spr = obj.ani[frame_adv()]

  zawurado.player\input(dt)
