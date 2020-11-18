u = require "util"
actor = require "actor"
class Game
  new: =>
    @player    = {}
    @dir       = {}
    @planets   = {}
    @objs      = {}
    @rng       = {}
    @planet_names = {}

  init: (num_of_mons, path_to_asset) =>
    @dir = love.filesystem.getDirectoryItems(path_to_asset)
    @planet_names = u.load_asset(path_to_asset)
    @rng = love.math.newRandomGenerator(love.timer.getTime())
    @player = Player!

    for i=1, num_of_mons
      table.insert(@objs, @create_planet!)

    1

  --  Creates a planet at a random (x,y)
  --  TODO number of animation sprites hardcoded
  create_planet: () =>
    planet = Actor!
    rnd = @planet_names[love.math.random(1, #@planet_names)]
    planet\set_sprite(rnd)
    planet.x = love.math.random(48, WIDTH)
    planet.y = love.math.random(48, HEIGHT)
    planet



{:Game}
