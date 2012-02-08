prefix = $(HOME)/.

vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc gvimrc)))
ignore = $(wildcard GNUmakefile README* eclipse ssh osx)

files := $(filter-out $(ignore), $(shell ls -1))
files += $(vim_files)

dest := $(addprefix $(prefix), $(files))

git_up = @git pull
setup = @ln -s -v -F $(realpath $<) $@

all:
	$(git_up)

install: $(dest)
	@echo All done

$(prefix)%: %
	$(setup)

$(prefix)%imrc: vim/%imrc
	$(setup)

$(ignore):
	@echo Skipping $(ignore)

clean:
	-@ $(RM) -rf $(dest)

.PHONY: all clean install

