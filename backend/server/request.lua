local Request = {}


local parse_request_line = function(line)
    local arr = {}
    for item in (string.gmatch(line, "[A-Za-z\\.0-9//]+")) do
        table.insert(arr, item)
    end

    return { 
        method = assert(arr[1]),
        uri = assert(arr[2]),
        protocol = assert(arr[3])
    }
end

local parse_headers = function(lines)
    local headers = {}
    for index, value in pairs({ table.unpack(lines, 2) }) do
        local get_key = true
        local key = ""
        local values = {}
        for item in (string.gmatch(value, "[^\\:]+")) do
            if get_key then
                key = item
                get_key = false
            else
                table.insert(values, item)
            end
        end
        headers[key] = table.concat(values, ":")
    end
    return headers
end


Request.new = function(lines)
    local this = {}
    local request_line = parse_request_line(lines[1])
    local headers = parse_headers(lines)
    this.headers = function(key)
        return headers[key]
    end

    local meta = {
        __index = function(self, key)
            return assert(request_line[key], "Invalid argument [" .. key .. "]")
        end
    }
    setmetatable(this, meta)
    return this
end


return Request
