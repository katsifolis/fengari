u = require "util"
actor = require "actor"

class Game
  new: =>
    @player       = {} -- The Controllable character
    @objs         = {} -- Individual planets
    @planet_names = {} -- All of asset names
    @matrix       = {} -- The map 

  init: (num_of_mons, path_to_asset) =>
    love.math.setRandomSeed(love.timer.getTime())
    @planet_names = u.load_asset(path_to_asset)
    @player = Player!

    for i=1, num_of_mons
      table.insert(@objs, @create_planet!)

  --  Creates a planet at a random (x,y)
  --  TODO number of animation sprites hardcoded
  create_planet: () =>
    planet = Actor!
    rnd = @planet_names[love.math.random(1, #(@planet_names))]
    planet\set_sprite(rnd)
    planet.x = love.math.random(48, WIDTH - SPR_WIDTH)
    planet.y = love.math.random(48, HEIGHT - SPR_HEIGHT)
    planet


{:Game}
