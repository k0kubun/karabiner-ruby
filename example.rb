item "[Not Terminal] Command+O|P to Command+{|} (US)", not: "TERMINAL" do
  remap "Cmd-P", to: "Cmd-Shift-]"
  remap "Cmd-O", to: "Cmd-Shift-["
end

item "[Only Terminal] Command+O|P to Option+{|} (US)", only: "TERMINAL" do
  remap "Cmd-P", to: "Opt-Shift-]"
  remap "Cmd-O", to: "Opt-Shift-["
end

item "[Not Terminal] Command+E to Command+W", not: "TERMINAL" do
  remap "Cmd-E", to: "Cmd-W"
end

item "[Only Terminal] Command+T to Option+T, Command+E to Option+E", only: "TERMINAL" do
  remap "Cmd-T", to: "Opt-T"
  remap "Cmd-E", to: "Opt-E"
end

# For tmux copy mode
item "[Only Terminal] Command+I to Option+I", only: "TERMINAL" do
  remap "Cmd-I", to: "Opt-I"
end

item "Command_L to Control_R" do
  remap "Cmd_L", to: "Ctrl_R"
end

# Change japanese input mode by Cmd_L + Space
item "Exchange Control + Space and Command + Space" do
  remap "C-Space", to: "Cmd-Space"
  remap "Cmd-Space", to: "C-Space"
end

item "CapsLock ON", config_not: "notsave.private_capslock_on" do
  remap "Cmd-L", to: ["capslock", "VK_CONFIG_FORCE_ON_notsave_private_capslock_on"]
end

item "CapsLock OFF", config_only: "notsave.private_capslock_on" do
  remap "Cmd-L", to: ["capslock", "VK_CONFIG_FORCE_OFF_notsave_private_capslock_on"]
end

item "CapsLock Mode" do
  identifier "notsave.private_capslock_on", vk_config: "true"
  show_message "CapsLock"
end

item "[Not Terminal] Control+PNBF to Up/Down/Left/Right", not: "TERMINAL" do
  remap "C-p", to: "Up"
  remap "C-n", to: "Down"
  remap "C-b", to: "Left"
  remap "C-f", to: "Right"
end

# Use Cmd_R+D as M-d
item "[Not Terminal] Command+D to Option+Forward Delete", not: "TERMINAL" do
  remap "Cmd-D", to: "Opt-forward_delete"
end

item "[Only Terminal] Command+D to Option+D, Command+BF to Option+BF", only: "TERMINAL" do
  remap "Cmd-D", to: "M-d"
  remap "Cmd-B", to: "M-b"
  remap "Cmd-F", to: "M-f"
end

# Use Cmd_R+B/F as M-b/f, and Cmd_R+S as Cmd+F to avoid conflict with M-f
item "[Not Terminal] Command+B/F to Option+Left/Right, Command+S to Command+F", not: "TERMINAL" do
  remap "Cmd-B", to: "Opt-Left"
  remap "Cmd-F", to: "Opt-Right"
  remap "Cmd-S", to: "Cmd-F"
end

item "[Not Terminal] Control+W to Option+Delete", not: "TERMINAL" do
  remap "C-w", to: "Opt-delete"
end

item "Control+LeftClick to Command+LeftClick" do
  autogen "__PointingButtonToPointingButton__ PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_CONTROL, PointingButton::LEFT, MODIFIERFLAG_EITHER_LEFT_OR_RIGHT_COMMAND"
end

item "[Not Terminal] Chrome inspector Command+Control+I", not: "TERMINAL" do
  remap "Cmd-Ctrl-I", to: "Cmd-Opt-i"
end

# browser reload
item "[Not Terminal] Control-R -> Command-R", not: "TERMINAL" do
  remap "C-r", to: "Cmd-R"
end

# tmux prefix
item "[Only Terminal] Command-R -> Option-R", only: "TERMINAL" do
  remap "Cmd-R", to: "M-r"
end

# I don't want to press shift key
item "Command semicolon to colon" do
  remap "Cmd-;", to: "Shift-;"
end

item "Shift by control" do
  remap "C--", to: "Shift--"
  remap "C-0", to: "Shift-0"
  remap "C-9", to: "Shift-9"
  remap "C-8", to: "Shift-8"
  remap "C-7", to: "Shift-7"
  remap "C-6", to: "Shift-6"
  remap "C-[", to: "Shift-["
  remap "C-]", to: "Shift-]"
  remap "C-;", to: "Shift-;"
  remap "C-,", to: "Shift-,"
  remap "C-.", to: "Shift-."
  remap "C-/", to: "Shift-/"
  remap "C-=", to: "Shift-="
  remap "C-\\", to: "Shift-\\"
end

item "Exchange single quote and double quote" do
  remap "Shift-'", to: "'"
  remap "'", to: "Shift-'"
end

item "[Only Terminal] Command+A to Option+A", only: "TERMINAL" do
  remap "Cmd-A", to: "M-a"
end

item "Disable Command-W" do
  remap "Cmd-W", to: "w"
end

appdef "YORUFUKUROU", equal: "com.YoruFukurouProject.YoruFukurou"

item "YoruFukurou Account Change", only: "YORUFUKUROU" do
  remap "Cmd-K", to: "Cmd-Opt-Up"
  remap "Cmd-J", to: "Cmd-Opt-Down"
end
