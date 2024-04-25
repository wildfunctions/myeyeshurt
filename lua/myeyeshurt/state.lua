local isFileInFolder = require("myeyeshurt.utils").isFileInFolder

local function newEntryObject()
  local entry = {
    version = 1,
    duration = 0,
    last_updated = os.time()
  }

  return entry
end

return {
  newEntryObject = newEntryObject
}
