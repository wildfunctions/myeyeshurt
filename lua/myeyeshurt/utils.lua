local function readJsonFile(filePath)
  local file = io.open(filePath, "r")
  if not file then return nil end
  local content = file:read("*a")
  file:close()
  return vim.json.decode(content)
end

local function writeJsonFile(filePath, data)
  local file = io.open(filePath, "w")
  if not file then return nil end
  file:write(vim.json.encode(data))
  file:close()
end

local function shallowClone(original)
    local clone = {}
    for key, value in pairs(original) do
        clone[key] = value
    end
    return clone
end

return {
  readJsonFile = readJsonFile,
  writeJsonFile = writeJsonFile,
  shallowClone = shallowClone
}
