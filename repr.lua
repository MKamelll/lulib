local M = {}

---@param v any
---@return string
function M.table_to_string(v)
    if type(v) == "table" then
        local result = "{"
        for k, val in pairs(v) do
            local key_string = to_string(k) .. ": "
            local value_string = to_string(val)
            result = result .. key_string .. value_string .. ", "
        end
        result = string.sub(result, 1, #result - 2)
        result = result .. "}"
        return result
    end
    error("type doesn't have a print function handler: '" .. type(v) .. "'")
end

---@param v any
---@return string
function M.nil_to_string(v)
    if type(v) == "nil" then
        return "nil"
    end
    return M.table_to_string(v)
end


---@param v any
---@return string
function M.boolean_to_string(v)
    if type(v) == "boolean" then
        return tostring(v)
    end
    return M.nil_to_string(v)
end

---@param v any
---@return string
function M.num_to_string(v)
    if type(v) == "number" then
        return tostring(v)
    end
    return M.boolean_to_string(v)
end


---@param v any
---@return string
function M.str_to_string(v)
    if type(v) == "string" then
        return '"' .. v .. '"'
    end
    return M.num_to_string(v)
end


---@param v any
---@return string
function M.to_string(v)
    return M.str_to_string(v)
end

return {
    to_string = M.to_string
}
