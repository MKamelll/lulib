local repr = require("repr")

local M = {}

---@param str string
---@param prefix string
---@return boolean
function M.startswith(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
end

---@param str string
---@param suffix string
---@return boolean
function M.endswith(str, suffix)
    return string.sub(str, #str - #suffix + 1) == suffix
end

---@param str string
---@param sep string
---@return string[]
function M.split(str, sep)
    local result = {}
    local last_delem = 0
    for i = 1, #str do
        if string.sub(str, i, i) == sep then
            local match = string.sub(str, last_delem + 1, i - 1)
            table.insert(result, match)
            last_delem = i
        end
    end
    return result
end

---@param str string
---@return boolean
function M.is_whitespace(str)
    local space_chars = { " ", "\t", "\n" }
    local count = 0
    for i = 1, #space_chars do
        for j = 1, #str do
            if M.at(str, j) == space_chars[i] then
                count = count + 1
            end
        end
    end
    return count == #str
end

---@param str string
---@return boolean
function M.is_alpha(str)
    local count = 0
    for i = 1, #str do
        local is_lower_case = string.byte(M.at(str, i), i) >= string.byte("a") and
            string.byte(M.at(str, i), i) <= string.byte("z")
        local is_upper_case = string.byte(M.at(str, i), i) >= string.byte("A") and
            string.byte(M.at(str, i), i) <= string.byte("Z")
        if is_lower_case or is_upper_case then
            count = count + 1
        end
    end
    return count == #str
end

---@param str string
---@return boolean
function M.is_numeric(str)
    local count = 0
    local is_float = false
    for i = 1, #str do
        local is_period = M.at(str, i) == "."
        if is_period and i > 1 and is_float == false then
            count = count + 1
            is_float = true
            goto continue
        end
        local is_number = string.byte(M.at(str, i), i) >= string.byte("0") and
            str.byte(M.at(str, i), i) <= string.byte("9")
        if is_number then
            count = count + 1
        end
        ::continue::
    end
    return count == #str
end

---@param str string
---@return boolean
function M.is_alphanumeric(str)
    return M.is_alpha(str) or M.is_numeric(str)
end

---@param str string
---@param index number
---@return string
function M.at(str, index)
    return string.sub(str, index, index)
end

---@param str string
---@return string
function M.ltrim(str)
    local result = str
    for i = 1, #str do
        if not M.is_whitespace(M.at(str, i)) then
            result = string.sub(result, i)
            break
        end
    end
    return result
end

---@param str string
---@return string
function M.rtrim(str)
    local result = str
    for i = #str, -1 do
        if not M.is_whitespace(M.at(str, i)) then
            result = string.sub(result, 1, i)
            break
        end
    end
    return result
end

---@param str string
---@return string
function M.trim(str)
    local result = M.rtrim(str)
    result = M.ltrim(str)
    return result
end

---@param str string
---@param old string
---@param new string
---@return string|nil
function M.replace(str, old, new)
    local start, finish = string.find(str, old)
    if start == nil or finish == nil then return nil end
    local pre = string.sub(str, 1, start - 1)
    local post = string.sub(str, finish + 1)
    return pre .. new .. post
end

---@param str string
---@param old string
---@param new string
---@return string|nil
function M.greplace(str, old, new)
    local function aux(_str, _old, _new, _result)
        _str = M.replace(_str, _old, _new)
        if _str == nil then return _result end
        _result = _str
        return aux(_str, _old, _new, _result)
    end
    return aux(str, old, new, "")
end

---@param str string
---@return string
function M.upper_first(str)
    return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

---@param str string
---@return string
function M.lower_first(str)
    return string.lower(string.sub(str, 1, 1)) .. string.sub(str, 2)
end


print(M.lower_first("Fuck off off off"))

return M
