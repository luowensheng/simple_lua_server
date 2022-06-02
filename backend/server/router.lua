local Router = {}

Router.new = function()
    local this = {}

    local routes = {}
    routes["GET"] = {}
    routes["PUT"] = {}
    routes["POST"] = {}
    routes["DELETE"] = {}

    local get_method = function(key)
        local method = string.upper(key)
        return method
    end

    local get_handler = function(method, pattern)
        local handler = routes[method][pattern]
        return handler
    end


    this.get_handler_for_pattern = function(method, pattern)
        local _method = get_method(method)
        if _method ~= nil then
            print(_method, pattern)
            return get_handler(_method, pattern)
        end
    end

    local meta = {

        __index = function(t, key)
            local method = assert(get_method(key), "Invalid method [" .. key .. "]")
            return function(pattern, handler)
                routes[method][pattern] = handler
            end
        end
    }
    setmetatable(this, meta)
    return this
end

return Router
