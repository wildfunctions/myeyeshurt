# myeyeshurt 

![alt text](https://github.com/wildfunctions/images/blob/main/myeyeshurt.gif)

## Installation

* install using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "wildfunctions/myeyeshurt",
    opts = {}
}
```


## Custom Installation

```lua
{
    "wildfunctions/myeyeshurt",
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
<leader>ms : triggers flakes 
<leader>mx : stop flakes 
```


Custom Keymaps can be set like the following code:
```lua
  vim.keymap.set("n", "<leader>ms", function() require("myeyeshurt").start() end, {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>mx", function() require("myeyeshurt").stop() end, {noremap = true, silent = true})
```

# Issues
Make an issue if you see anything that can be improved.

