# dotfiles
dotfiles by [@kevinji](https://github.com/kevinji).

## Installation
Clone this repo anywhere:
```bash
git clone --recursive https://github.com/kevinji/dotfiles.git

# gitconfig-local is gitignored but the install script will try to create a
# symlink for it. Make sure it exists.
touch dotfiles/git/gitconfig-local
```

Then, run `./install`, followed by `./scripts/setup-mac.sh` if relevant.

On Windows, after [installing Python](https://www.python.org/downloads/), run `python .\dotbot\bin\dotbot`.

Under the hood, [Dotbot](https://github.com/anishathalye/dotbot) manages the dotfiles installation.

## License
[MIT](LICENSE).
