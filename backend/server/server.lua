local Router = require("backend.server.router")
local Client = require("backend.server.client")
local ResponseWriter = require("backend.server.response_writer")
local Request = require("backend.server.request")

local Server = {}

local get_server = function(port)
    local socket = require('socket')
    return assert(socket.bind("localhost", port))
end

Server.new = function()

    local this = {}

    local router = Router.new()

    local meta = {
        __index = function(t, key)
            return router[key]
        end
    }

    setmetatable(this, meta)

    local process_request = function(response_writer, request)
        print("uri: ", request.uri)
        print("method :", request.method)
        local handler = this.get_handler_for_pattern(request.method, request.uri)
        if not handler then return end
        if true then
            local response = handler()
            if (type(response) == "table") then
                response_writer.set_json_content(response)
            else
                response_writer.set_content(response)
            end
        else
            handler(response_writer, request)
        end

    end

    local handle_connection = function(client)

        local content = client.receive()

        if content then
            local response_writer = ResponseWriter.new()
            local request = Request.new(content)
            process_request(response_writer, request)
            client.send(response_writer.get_response())
        end

        client.close()
    end


    this.run = function(port)
        local server = get_server(port)
        local ip, port = server:getsockname()
        print("listening on http://" .. ip .. ":" .. port)

        while true do
            local client = Client.new(server:accept())
            handle_connection(client)
        end
    end

    return this
end



return Server
