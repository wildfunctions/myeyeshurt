local init = require("myeyeshurt.init")
local state = require("myeyeshurt.state")

init.setup()

local function test()
  local currentTime = os.time()
  local initState = state.newState(currentTime)

  print("Should be true: stillInNeovim->", init.stillInNeovim(initState, 2 * 60))
  print("Should be true: stillInNeovim->", init.stillInNeovim(initState, 3 * 60))
  print("Should be true: stillInNeovim->", init.stillInNeovim(initState, 5 * 60))
  print("Should be false: stillInNeovim->", init.stillInNeovim(initState, 6 * 60))

  currentTime = currentTime + 5 * 60
  local newState, shouldStartFlakes = init.getNewState(initState, currentTime)

  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)

  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)

  currentTime = currentTime + 5 * 60
  newState, shouldStartFlakes = init.getNewState(newState, currentTime)
  print("Should be false: shouldStartFlakes->", shouldStartFlakes)

  print("Should be true: stillInNeovim->", init.stillInNeovim(newState, 1 * 60))
  print("Should be true: stillInNeovim->", init.stillInNeovim(newState, 3 * 60))
  print("Should be false: stillInNeovim->", init.stillInNeovim(newState, 5 * 60))


  currentTime = currentTime + 1 * 60
  newState, shouldStartFlakes = init.getNewState(newState, currentTime)
  print("Should be true: shouldStartFlakes->", shouldStartFlakes)

  newState = state.newState(currentTime)
  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)
  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)
  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)
  currentTime = currentTime + 5 * 60
  newState = init.getNewState(newState, currentTime)
  currentTime = currentTime + 10 * 60
  newState, shouldStartFlakes = init.getNewState(newState, currentTime)
  print("Should be false: shouldStartFlakes->", shouldStartFlakes)
end

test()
