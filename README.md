# Karabiner DSL [![Build Status](https://travis-ci.org/k0kubun/karabiner-dsl.svg?branch=master)](https://travis-ci.org/k0kubun/karabiner-dsl)

Lightweight keyremap configuration DSL for [Karabiner](https://pqrs.org/osx/karabiner/index.html.en)

## Why Karabiner DSL?

Original [Karabiner's configuration](https://pqrs.org/osx/karabiner/xml.html.en) is very hard to write.  
Karabiner DSL is its wrapper, which is easy-to-write and readable.  
  
If you write Karabiner's config with Karabiner DSL, you can update your keyremap configuration quickly.

## Installation

First of all, you have to install [Karabiner](https://pqrs.org/osx/karabiner/index.html.en).
Karabiner is a keyboard remap utility for Mac OSX.  
  
Then execute:

```bash
$ gem install karabiner
```

Then `karabiner` executable will be installed.
This gem provides only `karabiner dsl` subcommand and other subcommands are delegated to original CLI for Karabiner.app.

## Usage
### 1. Create ~/.karabiner

```rb
item "Command+G to open Google Chrome" do
  remap "Cmd-g", to: invoke("Google Chrome")
end
```

### 2. Execute karabiner dsl command

```bash
$ karabiner dsl
```

Then `karabiner dsl` will update Karabiner's config as you expected.

![](https://raw.githubusercontent.com/k0kubun/karabiner-dsl/master/img/disabled.png)

### 3. Enable your favorite configurations

![](https://raw.githubusercontent.com/k0kubun/karabiner-dsl/master/img/enabled.png)

Enjoy!

## How to write ~/.karabiner
### Basics

karabiner-dsl's DSL is a superset of Ruby.  
So you can use any Ruby methods in ~/.karabiner.

#### item

```rb
item "configuration unit" do
  ...
end
```

In karabiner-dsl, any Karabiner's configuration unit is expressed in `item` and its `do ~ end` block.  
You can group some remap configurations in one item and enable them in one click.

#### remap

```rb
item "remap example" do
  remap "Cmd-a", to: "C-a"
end
```

If you want to add remap configuration, you have to call `remap` method.  
In this example, Command+A will be remapped to Control+A.  
  
You have to write "key expression" to specify keys to remap.

#### key expression

- `a`, `A`, `1`, `;`, `tab`, `Tab`, `space`, `up`, `down`
  - any string without `-` or `+` will be regarded as a single key
  - strings are case insensitive
- `Volume Mute`, `Mute`, `Brightness Down`, `Brightness_Down`
  - support system (consumer) keys
  - words could be separated by space ` ` or underscore `_`
- nil, `nil`, `none`
  - you can drop any key by using nil or the corresponding aliases

#### key combination

| Key combination                                            | Regarded as           | Notes  |
| ---------------------------------------------------------- | --------------------- | ------ |
| `C-a`, `Ctrl-a`, `C+a`, `Ctrl+a`                           | Control + A           | `C-` is a short alias for `Ctrl-` |
| `M-a`, `Opt-a`, `Alt-a`, `M+a`, `Opt+a`, `Alt+a`           | Option + A            | `M-` and `Alt-` are aliases for `Opt-` |
| `Shift-a`, `Shift+a`                                       | Shift + A (capital A) | if you write just `A`, it will be regarded as small a |
| `Cmd-a`, `Cmd+a`                                           | Command + A           |        |
| `Cmd-Shift-a`, `Cmd+Shift-a`, `Cmd-Shift+a`, `Cmd+Shift+a` | Command + Shift + A   | you can use any combination of Ctrl, Opt, Shift, Cmd |

#### available single keys

[Karabiner DSL keycode and alias reference](https://github.com/k0kubun/karabiner-dsl/blob/master/lib/karabiner/key.rb)

[Karabiner full keycode reference](https://pqrs.org/osx/karabiner/xml.html.en#keycode-list)

*Note:* Karabiner DSL is designed to work with all keycodes which are supported by Karabiner
(listed in the full keycode reference).

```
a b c ... x y z
0 1 2 ... 7 8 9

F1 F2 ... F11 F12
\ [ ] ; ' ` , . / - =
Up Down Right Left
Space Tab Delete ... Forward_Delete Esc Capslock
Mute Volume_Down Volume_Up ... Prev Play Next

nil none

Ctrl_R  Ctrl_L
Opt_R   Opt_L   Alt_R   Alt_L
Cmd_R   Cmd_L
Shift_R Shift_L
```

## Sample

```rb
item "Application shortcuts" do
  remap "C-o", to: invoke("YoruFukurou") # Invoke the app under the /Applications.
  remap "C-u", to: invoke("Google Chrome") # ditto.
  remap "C-h", to: invoke("/Users/johndoe/Applications/iTerm.app") # Invoke the app of the specified path.
end

item "Copy date" do
  remap "Cmd-d", to: execute("date|pbcopy")
end

item "Control+PNBF to Up/Down/Left/Right" do
  remap "C-p", to: "Up"
  remap "C-n", to: "Down"
  remap "C-b", to: "Left"
  remap "C-f", to: "Right"
end

appdef "HIPCHAT", equal: "com.hipchat.HipChat"
item "HipChat Room Change", only: "HIPCHAT" do
  remap "Cmd-K", to: "Cmd-Shift-["
  remap "Cmd-J", to: "Cmd-Shift-]"
end

item "Window change in the same app" do
  remap "Opt-tab", to: "Cmd-F1"
end
```

## Linux alternative
You could achieve the same functionality on Linux/X11 with a sister project [xkremap](https://github.com/k0kubun/xkremap).
It has a similar syntax and doesn't need any Ruby interpreter to run.

## Contributing

1. Fork it ( https://github.com/k0kubun/karabiner-dsl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
