# Dotfiles

> [!Note]
>
> On macOS install the XCode CLI tools before continuing.

```
xcode-select --install
```

> [!Note]
>
> On FreeBSD install bash, gmake, vim.

```
pkg install -y bash gmake vim

# Temporary add a /bin/bash link. Otherwise, vim vundle isn't happy.
ln -s /usr/local/bin/bash /bin/bash
```

## Setup

```
$ make

$ make install
```
