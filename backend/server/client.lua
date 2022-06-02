Client = {}

Client.new = function (socket)
    local this = {}
    this.receive = function ()

        local receive = true
        local msg = {}
        while receive do
            local line, err = socket:receive()
            receive = (line~="") and (not err)  
            if receive then 
                table.insert(msg, line)
            else
              return msg
            end
        end
    end

    this.send = function (reply)
        socket:send(reply)
    end

    this.close = function ()
        socket:close()
    end

    return this
end



return Client