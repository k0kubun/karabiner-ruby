# Dotremap [![Build Status](https://travis-ci.org/k0kubun/dotremap.png?branch=master)](https://travis-ci.org/k0kubun/dotremap)

Lightweight keymap configuration DSL for [Karabiner](https://pqrs.org/osx/karabiner/index.html.en)

## Installation

First of all, you have to install [Karabiner](https://pqrs.org/osx/karabiner/index.html.en),
which is keyboard remap utility for Mac OSX.  
  
Then execute:

```bash
$ gem install dotremap
```

## Usage
### 1. Create ~/.remap

```rb
item "Command+G to open Google Chrome" do
  remap "Cmd-g", to: invoke("Google Chrome")
end
```

### 2. Execute dotremap command

```bash
$ dotremap
```

Then dotremap will update Karabiner's config as you expected.

![](https://raw.githubusercontent.com/k0kubun/dotremap/master/img/disabled.png)

### 3. Enable your favorite configurations

![](https://raw.githubusercontent.com/k0kubun/dotremap/master/img/enabled.png)

Enjoy!

## How to write ~/.remap
### Basics

Dotremap's DSL is a superset of Ruby.  
So you can use any Ruby methods in ~/.remap.

#### item

```rb
item "configuration unit" do
  ...
end
```

In dotremap, any Karabiner's configuration unit is expressed in `item` and its `do ~ end` block.  
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
  - any string without `-` will be regarded as single key
  - ignore upcase or downcase
- `C-a`, `Ctrl-a`
  - regarded as Control + A
  - `C-` is a short expression of `Ctrl-`
- `M-a`, `Opt-a`
  - regarded as Option + A
- `Shift-a`
  - regarded as large A
  - if you write just `A`, it will be regarded as small a
- `Cmd-a`
  - regarded as Command + A
- `Cmd-Shift-a`
  - regarded as Command + Shift + A
  - you can use any combination of Ctrl, Opt, Shift, Cmd

#### available single keys

```
a b c ... x y z
0 1 2 ... 7 8 9
F1 F2 ... F11 F12
\ [ ] ; ' , . / - =
up down right left
space tab delete forward_delete capslock

Ctrl_R Ctrl_L
Opt_R  Opt_L
Cmd_R  Cmd_L
```

### Advanced usage

I'm sorry but currently some features are not documented here.  
You can see [my ~/.remap](https://github.com/k0kubun/dotfiles/blob/master/.remap.rb) or
[dotremap's spec file](https://github.com/k0kubun/dotremap/blob/master/spec/lib/dotremap_spec.rb).

## TODO

- Document all features in this README

## Contributing

1. Fork it ( https://github.com/k0kubun/dotremap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
