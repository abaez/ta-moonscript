# ta-moonscript
## Moonscript module for [Textadept](http://foicica.com/textadept/) by [Alejandro Baez](https://twitter.com/a_baez)

### DESCRIPTION

So after basically being pretty much a fanboy to [Leaf](https://twitter.com/moonscript),
I decided it was about time to learn his coffeescript for lua; [Moonscript](http://moonscript.org/).
The syntax sugars are pretty darn nice and feel even more functional than Lua
somehow :3.

Anyway, I noticed that the Textadept/Scintillua module for Moonscript hasn't
been updated for a *WHILE*. Now, Textadept is my editor choice. So obviously,
something had to be done. Here is my current *work in progress* module.
It does already have quite a number of options and will continue to progress
more as I actually use the language. Literally learned Moonscript while making
this module...

#### Completed:
*   lexer: All keywords, libraries, string type, class definition and full
highlighting of the current language spec (0.3.1).
*   module: compiles `*.moon` to `*.lua`, massive list of snippets, autolint
working, and can run `*.moon` files directly.
*   lint: full lint support from `moonc -l` option.

#### To Do:
*   autocomplete: always leave this one out on my modules but will get around
to it soon...
*   busted: want unit testing integration with busted tightly constructed from
snippets and build.
*   build: build directly from `Tupfiles` using [tup](http://gittup.org/tup/).

### REQUIREMENT
*   [moonscript](http://moonscript.org/) >= v0.3.1
*   [Textadept](http://foicica.com/textadept/) >= 8.0
*   (optional) [tup](http://gittup.org/tup/)

### INSTALL
Clone the repository to your `~/.textadept/modules` directory:

```
cd ~/.textadept/modules
hg clone https://bitbucket.org/a_baez/ta-moonscript moonscript
```

You are done! If you want to use the latest in development version of the lexer
(follows the moonscript nightlies), then continue along.

#### moonscript lexer
Copy the `moonscript.lua` lexer file into your `~/.textadept/lexers` directory:

```
cp ~/.textadept/modules/moonscript/moonscript.lua ~/.textadept/lexers/moonscript.lua
```

