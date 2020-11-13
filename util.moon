-- sprite frame counter
counter = (n)->
	j = 0
	->
		j=0 if j == n -- number of frames
		j+=1
		j

{:counter}
