PREFIX = ~/.
EXCLUDE = GNUmakefile README eclipse ssh osx

SRC := $(filter-out $(EXCLUDE), $(notdir $(shell find . -maxdepth 1 -not -name '.*' )))
DEST := $(addprefix $(PREFIX), $(SRC))

all:
	@git pull

install: $(DEST)
	@echo All done

$(PREFIX)%: %
	@ln -s -v -F $(realpath $<) $@

$(EXCLUDE):
	@echo Skipping $@

clean:
	-@ $(RM) -rf $(DEST)

.PHONY: all clean install

