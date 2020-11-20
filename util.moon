-- sprite frame counter
counter = (n)->
	j = 0
	->
		j=0 if j == n -- number of frames
		j+=1
		j

-- load_asset is hardcoded for a particular usage of layout
-- Returns the names of all individual planets not sprites
load_asset = (fld) ->
  dirs = love.filesystem.getDirectoryItems(fld)
  names = {}
  for i, v in ipairs dirs
    if (i-1) % 4 == 0
      n = string.reverse(string.sub(string.reverse(v), 5))
      table.insert(names, n)

  names

{:counter, :load_asset}
