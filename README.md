# ta-moonscript
[![license][6i]][6l]
## Moonscript module for [Textadept][1] by [Alejandro Baez][2]

### DESCRIPTION

So after basically being pretty much a fanboy to [Leaf][3],
I decided it was about time to learn his coffeescript for lua; [Moonscript][4].
The syntax sugars are pretty darn nice and feel even more functional than Lua
somehow :3.

Anyway, I noticed that the Textadept/Scintillua module for Moonscript hasn't
been updated for a *WHILE*. Now, Textadept is my editor choice. So obviously,
something had to be done. Here is my current *work in progress* module.
It does already have quite a number of options and will continue to progress
more as I actually use the language. Literally learned Moonscript while making
this module...

**NOTE**: the module really shines when you use the snippets. Please check them
out so you know what they are and make your life that much easier. :)

#### Completed:
*   lexer: All keywords, libraries, string type, class definition and full
highlighting of the current language spec (0.4).
*   module: compiles `*.moon` to `*.lua`, massive list of snippets, autolint
working, and can run `*.moon` files directly.
*   lint: full lint support from `moonc -l` option.
*   build: build directly from `Tupfiles` using [tup][5].

#### To Do:
*   autocomplete: always leave this one out on my modules but will get around
to it soon...
*   busted: want unit testing integration with busted tightly constructed from
snippets and build.

### REQUIREMENT
*   [moonscript][4] >= v0.4
*   [Textadept][1] >= 8.3
*   (optional) [tup][5]

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

### KEYBINDINGS

    Keys        Action
    cl+s        opens snippets directory for modifying.
    cR          runs `moonc` on the current moonscript file.
    cr          runs `moon` on the current moonscript file.
    cB          builds the project with tup.

[1]: http://foicica.com/textadept/
[2]: https://twitter.com/a_baez
[3]: https://twitter.com/moonscript
[4]: http://moonscript.org/
[5]: http://gittup.org/tup/
[6i]: https://img.shields.io/badge/license-MIT-green.svg
[6l]: ./LICENSE
