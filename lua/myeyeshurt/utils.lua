local Path = require("plenary.path")

local function isFileInFolder(file, folder)
  local filePath = Path:new(file):absolute()
  local folderPath = Path:new(folder):absolute()

  local sub = filePath:sub(1, #folderPath)
  return sub == tostring(folderPath)
end

local function readJsonFile(file)
  local filePath = Path:new(file)
  if filePath:exists() then
    return vim.json.decode(filePath:read())
  end
end

local function writeJsonFile(file, data)
  Path:new(file):write(vim.json.encode(data), 'w')
end

local function shallowClone(original)
    local clone = {}
    for key, value in pairs(original) do
        clone[key] = value
    end
    return clone
end

return {
  isFileInFolder = isFileInFolder,
  readJsonFile = readJsonFile,
  writeJsonFile = writeJsonFile,
  shallowClone = shallowClone
}
