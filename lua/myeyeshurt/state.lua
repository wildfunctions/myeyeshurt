local function newState(currentTime)
  local state = {
    version = 1,
    duration = 0,
    last_updated = currentTime
  }

  return state
end

return {
  newState = newState
}
