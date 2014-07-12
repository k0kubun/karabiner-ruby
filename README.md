# Dotremap

Lightweight configuration DSL for [KeyRemap4MacBook](https://pqrs.org/osx/karabiner/index.html)

## Installation

````bash
$ gem install dotremap
```

## Usage
### 1. Create ~/.remap

```rb
# ~/.remap
item "Control+PNBF to Up/Down/Left/Right", not: "TERMINAL" do
  remap "C-p", to: "Up"
  remap "C-n", to: "Down"
  remap "C-b", to: "Left"
  remap "C-f", to: "Right"
end
```

### 2. Execute dotremap command

```bash
$ dotremap
```

It will replace KeyRemap4MacBook's private.xml with compiled ~/.remap.

### 3. Reload private.xml and update config

You have to reload private.xml to activate compiled configurations.

## Contributing

1. Fork it ( https://github.com/k0kubun/dotremap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
