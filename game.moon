class Game
  new: =>
    @player    = {}
    @planets   = {}
    @objs      = {}
    @rng       = {}

  init: (num_of_mons, path_to_asset) =>
    dir = love.filesystem.getDirectoryItems(path_to_asset)
    @planets = [item for item in *dir[,,4]]
    @rng = love.math.newRandomGenerator(love.timer.getTime())

    for i=1, num_of_mons
      table.insert(@objs, create_planet())



love.load = () ->
--  Decides a random planet-asset in random and draws it --

  dirs = love.filesystem.getDirectoryItems("assets/")
  planets = [item for item in *dirs[,,4]] -- Finds all the names of asset folder
  rng  = love.math.newRandomGenerator(love.timer.getTime())
  ----------------------------------------------------------
  for i=1, 100
    table.insert(objs, create_planet())
  

{:Game}
