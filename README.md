# Dotremap [![Build Status](https://travis-ci.org/k0kubun/dotremap.png?branch=master)](https://travis-ci.org/k0kubun/dotremap)

Lightweight keymap configuration DSL for [Karabiner](https://pqrs.org/osx/karabiner/index.html)

## Installation

```bash
$ gem install dotremap
```

## Usage
### 1. Create ~/.remap

```rb
# ~/.remap
item "Command+G to execute Google Chrome" do
  remap "Cmd-g", to: invoke("Google Chrome")
end
```

### 2. Execute dotremap command

```bash
$ dotremap
```

Then dotremap will update Karabiner's config as you expected.

![](https://raw.githubusercontent.com/k0kubun/dotremap/master/img/chrome.png)

### 3. Enable your favorite configurations

That's all. Enjoy!

## Example

I'm sorry but currently this software is not well documented.  
Please see [example.rb](https://github.com/k0kubun/dotremap/blob/master/example.rb) to learn how to use.

## Contributing

1. Fork it ( https://github.com/k0kubun/dotremap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
