OBJS=main.moon game.moon util.moon

main.lua: main.moon util.moon
	moonc *.moon

run:
	love .

clean:
	rm game.lua main.lua util.lua
