# Dotremap

Lightweight keymap configuration DSL for [Karabiner](https://pqrs.org/osx/karabiner/index.html)

## Installation

```bash
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

It will replace Karabiner's private.xml with compiled ~/.remap:

```xml
<?xml version="1.0"?>
<root>
  <item>
    <name>Control+PNBF to Up/Down/Left/Right</name>
    <identifier>remap.control_pnbf_to_up_down_left_right</identifier>
    <not>TERMINAL</not>
    <autogen>__KeyToKey__ KeyCode::P, VK_CONTROL, KeyCode::CURSOR_UP</autogen>
    <autogen>__KeyToKey__ KeyCode::N, VK_CONTROL, KeyCode::CURSOR_DOWN</autogen>
    <autogen>__KeyToKey__ KeyCode::B, VK_CONTROL, KeyCode::CURSOR_LEFT</autogen>
    <autogen>__KeyToKey__ KeyCode::F, VK_CONTROL, KeyCode::CURSOR_RIGHT</autogen>
  </item>
</root>
```

dotremap will automatically execute "ReloadXML".  
Then activate your favorite configurations.

## Example

I'm sorry but currently this software is not well documented.  
Please see [example.rb](https://github.com/k0kubun/dotremap/blob/master/example.rb) to learn how to use.

## Contributing

1. Fork it ( https://github.com/k0kubun/dotremap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
