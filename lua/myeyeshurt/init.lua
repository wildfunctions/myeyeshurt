local winWidth = vim.api.nvim_get_option("columns")
local winHeight = vim.api.nvim_get_option("lines")

local canvasBuf, canvasWin
local flakes = {}

local defaults = {
  initialFlakes = 1,
  flakeOdds = 20,
  maxFlakes = 750,
  nextFrameDelay = 175,
  useDefaultKeymaps = true,
  debug = false,
  flake = {'*', '.'}
}
local config = {}

local function createFlakeCanvas()
  if canvasBuf == nil or not vim.api.nvim_buf_is_valid(canvasBuf) then
    canvasBuf = vim.api.nvim_create_buf(false, true)
  end

  if canvasWin == nil or not vim.api.nvim_win_is_valid(canvasWin) then
    vim.cmd('hi FloatingWin guibg=NONE ctermbg=NONE')

    canvasWin = vim.api.nvim_open_win(canvasBuf, false, {
      relative = 'editor',
      width = winWidth,
      height = winHeight,
      col = 0,
      row = 0,
      style = 'minimal',
      focusable = false,
      noautocmd = true,
    })

    vim.api.nvim_win_set_option(canvasWin, 'winblend', 100)
    vim.api.nvim_win_set_option(canvasWin, 'winhighlight', 'Normal:FloatingWin,NormalNC:FloatingWin')
  end
end

local function initializeFlakes()
  for _ = 1, config.initialFlakes do
    local randomFlake = config.flake[math.random(#config.flake)]
    table.insert(flakes, {char = randomFlake, x = math.random(winWidth), y = 1})
  end
end

local function addNewFlake()
  local randomFlake = config.flake[math.random(#config.flake)]
  table.insert(flakes, {char = randomFlake, x = math.random(winWidth), y = 1})
end

local function drawFlakes()
  vim.api.nvim_buf_set_lines(canvasBuf, 0, -1, false, {})

  local blankLine = string.rep(" ", winWidth)
  local lines = {}
  for i = 1, winHeight do
    lines[i] = blankLine
  end

  for _, flake in ipairs(flakes) do
    if flake.y <= winHeight then
      local line = lines[flake.y]
      lines[flake.y] = line:sub(1, flake.x - 1) .. flake.char .. line:sub(flake.x + 1)
    end
  end

  vim.api.nvim_buf_set_lines(canvasBuf, 0, -1, false, lines)

  -- vim.cmd('hi Flake guifg=#abf0ff guibg=NONE ctermbg=NONE')
  -- vim.api.nvim_buf_add_highlight(canvasBuf, -1, 'Flake', 1, 0, -1)
end

local function randomSign()
  if math.random(2) == 1 then
    return -1
  else
    return 1
  end
end

local function updateFlakesPositions()
  for _, flake in ipairs(flakes) do
    flake.y = flake.y + 1
    flake.x = flake.x + randomSign()
    if flake.y > winHeight then
      flake.y = 1
      flake.x = math.random(winWidth)
    end
    if flake.x > winWidth then
      flake.x = 1
    end
    if flake.x < 0 then
      flake.x = winWidth
    end
  end
end

local function flakeEventLoop()
  vim.defer_fn(function()
    if canvasWin == nil or canvasBuf == nil then
      return
    end
    local makeNewFlake = math.random(1, config.flakeOdds) == 1
    if makeNewFlake and #flakes < config.maxFlakes then
      addNewFlake()
    end
    updateFlakesPositions()
    drawFlakes()
    flakeEventLoop()
  end, config.nextFrameDelay)
end

local function stopFlakes()
  if canvasWin ~= nil and vim.api.nvim_win_is_valid(canvasWin) then
    vim.api.nvim_win_close(canvasWin, true)
    canvasWin = nil
  end
  if canvasBuf ~= nil and vim.api.nvim_buf_is_valid(canvasBuf) then
    vim.api.nvim_buf_delete(canvasBuf, {force = true})
    canvasBuf = nil
  end
  flakes = {}
end

local function startFlakes()
  createFlakeCanvas()
  initializeFlakes()
  flakeEventLoop()
end

local function setDefaultKeymaps()
  vim.keymap.set("n", "<leader>ms", function() startFlakes() end, {noremap = true, silent = true})
  vim.keymap.set("n", "<leader>mx", function() stopFlakes() end, {noremap = true, silent = true})
end

local function onSave()
  local entry = {}
  entry.version = 1
  entry.time = os.time()

  print("myeyeshurt: ", vim.inspect(entry))
end

local function setup(userOpts)
  userOpts = userOpts or {}
  config = vim.tbl_deep_extend("force", defaults, userOpts)

  if config.useDefaultKeymaps then
    setDefaultKeymaps()
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = onSave
  })

  if config.debug then
    print("myeyeshurt setup with config: ", vim.inspect(config))
  end
end

return {
  setup = setup,
  stop = stopFlakes,
  start = startFlakes,
}
