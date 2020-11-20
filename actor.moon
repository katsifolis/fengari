export *
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
  collides: (fln) =>


    

class Player extends Actor
  input: (dt) =>
    -- calculate velocity and speed 

    -- Collision with Window
    -- 1.2 Magic value that is being substracted is back off from bump value
    if @x - (SPR_WIDTH * SX) < -SPR_WIDTH
      @x -= @vx * dt - BUMP
      @vx = 0
    elseif @x + ( SPR_WIDTH * SX) > WIDTH
      @x -= @vx * dt + BUMP
      @vx = 0
    elseif @y - ( SPR_HEIGHT * SY) < -SPR_HEIGHT
      @y -= @vy * dt - BUMP
      @vy = 0
    elseif @y + ( SPR_HEIGHT * SY) > HEIGHT
      @y -= @vy * dt + BUMP
      @vy = 0
    ---

    @x  += @vx * dt
    @y  += @vy * dt
    @vx *= math.pow(0.02, dt)
    @vy *= math.pow(0.02, dt)

    @vx -= dt * ACCEL if kbd.isDown("a")
    @vx += dt * ACCEL if kbd.isDown("d")
    @vy += dt * ACCEL if kbd.isDown("s")
    @vy -= dt * ACCEL if kbd.isDown("w")

{:Actor, :Player}
