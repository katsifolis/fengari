DIRS = .
MOONAKIA = $(wildcard $(DIRS:=/*.moon))

all: compile
	love .

compile:
	@echo compiling ... $(MOONAKIA)
	moonc -t . $(MOONAKIA)

clean:
	rm *.lua
