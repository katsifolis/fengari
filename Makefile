OBJS=main.moon game.moon util.moon

main.lua: main.moon util.moon
	moonc *.moon

run:
	love .
