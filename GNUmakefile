prefix = $(HOME)/.

vim_files = $(notdir $(wildcard $(addprefix vim/, vimrc)))
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

$(prefix)vimrc: vim/vimrc
	$(setup)
	vim +BundleInstall +qall

$(ignore):
	@echo Skipping $(ignore)

clean:
	@- for file in $(dest); do \
		test -L "$$file" && "$(RM) -r $$file"; \
	done

.PHONY: all clean install

