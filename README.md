# myeyeshurt 

![alt text](https://github.com/wildfunctions/images/blob/main/myeyeshurt.gif)

## About the Plugin 

The 20-20-20 rule suggests taking a break every 20 minutes to focus your eyes on something
at least 20 feet away, for at least 20 seconds.

With this plugin, ASCII snowflakes begin to fall across your screen once you've been active for 
20 minutes, reminding you to take a much-needed break. Initially, a few snowflakes appear, 
but as time continues without a break, their number grows into a blizzard compelling 
you to pause and rest your eyes.


## Installation

* install using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "wildfunctions/myeyeshurt",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
}
```


## Custom Installation

```lua
{
    "wildfunctions/myeyeshurt",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      initialFlakes = 1,
      flakeOdds = 20,
      maxFlakes = 750,
      nextFrameDelay = 175,
      useDefaultKeymaps = true,
      flake = {'*', '.'},
      minutesUntilRest = 20
    }
}
```

### Default Setup

These are the default keymaps:
```
<leader>ms : trigger flakes (this happens automatically, but it's fun to manually trigger)
<leader>mx : stop flakes 
```


Custom Keymaps can be set like the following code:
```lua
  vim.keymap.set("n", "<leader>ms", function() require("myeyeshurt").start() end, {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>mx", function() require("myeyeshurt").stop() end, {noremap = true, silent = true})
```

# Issues
Make an issue if you see anything that can be improved.

