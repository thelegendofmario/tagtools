core.chat_send_all("tagtools loaded")

invisible_spec = {color={a=0,r=0,g=0,b=0}, bgcolor={a=0,r=255,g=255,b=255}}
visible_spec = {color={a=255, r=255, g=255, b=255}, bgcolor={a=140, r=0, g=0, b=0}}

core.register_privilege("tag_player", {
    description = "can hide their name",
    give_to_singleplayer = true
})

core.register_privilege("tag_admin", {
    description = "can hide/show other people's names",
    give_to_singleplayer = true
})


core.register_chatcommand("hideme", {
    privs = {
        tag_player = true
    },
    func = function (name, param)
        --for _, player in pairs(core.get_connected_players()) do
        if param ~= "" then
            core.chat_send_player(name, "this doesn't take anything. you added "..param..". try running it without "..param..".")
            return
        end
        
        if core.get_player_by_name(name) then
            local p = core.get_player_by_name(name)
            p:set_nametag_attributes(invisible_spec)
            core.chat_send_player(name, "you are hiding now :D")
        end
        --end
    end
})

core.register_chatcommand("showme", {
    privs = {
        tag_player = true
    },
    func = function (name, param)
        --for _, player in pairs(core.get_connected_players()) do
        if param ~= "" then
            core.chat_send_player(name, "this doesn't take anything. you added "..param..". try running it without "..param..".")
            return
        end
        
        if core.get_player_by_name(name) then
            local p = core.get_player_by_name(name)
            p:set_nametag_attributes(visible_spec)
            core.chat_send_player(name, "you are visible now :D")
        end
        --end
    end
})

core.register_chatcommand("showplayer", {
    privs={
        tag_admin=true
    },
    func = function(name, param)
        if param == "" then
            core.chat_send_player(name, "you need to specify a player")
        end
        
        if core.get_player_by_name(param) then
            local p = core.get_player_by_name(param)
            p:set_nametag_attributes(visible_spec)

            core.chat_send_player(name, param .. " is visible now :D")
            
            core.chat_send_player(param, "you are visible now :D")
        end
    end
})

core.register_chatcommand("hideplayer", {
    privs={
        tag_admin=true
    },
    func = function(name, param)
        if param == "" then
            core.chat_send_player(name, "you need to specify a player")
        end

        if core.get_player_by_name(param) then
            local p = core.get_player_by_name(param)
            p:set_nametag_attributes(invisible_spec)
            
            core.chat_send_player(name, param .. " is hidden now :D")
            
            core.chat_send_player(param, "you are hidden now :D")
        end
    end
})

core.register_chatcommand("hideall", {
    privs={
        tag_admin=true
    },

    func=function (name, param)
        for _, player in pairs(core.get_connected_players()) do
            player:set_nametag_attributes(invisible_spec)
        end
    end
})

core.register_chatcommand("showall", {
    privs={
        tag_admin=true
    },

    func=function (name, param)
        for _, player in pairs(core.get_connected_players()) do
            player:set_nametag_attributes(visible_spec)
        end
    end
})
