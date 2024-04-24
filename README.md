# myeyeshurt 

![alt text](https://github.com/wildfunctions/images/blob/main/myeyeshurt.gif)

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
      flake = {'*', '.'}
    }
}
```

## Issues
Make an issue if you see anything that can be improved.

