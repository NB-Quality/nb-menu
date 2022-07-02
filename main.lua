local current_menu = nil
local current_keyhandles = nil

local openedmenus = {}

local Menu = function(maxslots,x,y)
    local self = DrawMenu(maxslots,x,y)

    self.setcb = function(cb,cbend)
        self.cb = cb
        self.cbend = cbend 
        return self 
    end 
    
    
    self.open = function()
        table.insert(openedmenus,self)
        if current_menu then 
           current_menu["end"]()
        end 
        current_menu = openedmenus[#openedmenus]
        current_menu["start"]()
        
        current_menu.cancel = function()
            if current_menu then 
                current_menu["end"]()
                
                if current_menu.cbend then current_menu.cbend() end 

                table.remove(openedmenus,#openedmenus)
                current_menu = openedmenus[#openedmenus]
                
                local p = current_menu
                if not p then 
                    if keyhandles and #keyhandles > 0 then 
                        for i=1,#keyhandles do 
                            RemoveKeyEvent(keyhandles[i])
                        end 
                        current_keyhandles = nil
                    end 
                else 
                    p["start"]()
                end 
            end 
        end 
        
        current_menu.submit = function(iscursor)
            if iscursor then 
                current_menu["return_by_cursor"](current_menu.cb)
            else 
                current_menu["return"](current_menu.cb)
            end 
        end 
        
        if not current_keyhandles then current_keyhandles = {
            KeyEvent("keyboard","UP",function(on)   
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.up()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.up()
                end,500,500,true) 
            end),
            KeyEvent("keyboard","DOWN",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.down()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.down()
                end,500,500,true)   
            end),
            KeyEvent("keyboard","LEFT",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.left()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.left()
                end,500,500,true) 
            end),
            KeyEvent("keyboard","RIGHT",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.right()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.right()
                end,500,500,true) 
            end),

            KeyEvent("keyboard","RETURN",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.submit()
                end) 
            end),

            KeyEvent("keyboard","BACK",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.cancel()
                end) 
            end),

            KeyEvent("MOUSE_BUTTON","IOM_WHEEL_UP",function(on) 
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.up()
                end) 
                
            end),

            KeyEvent("MOUSE_BUTTON","IOM_WHEEL_DOWN",function(on) 
                on("justpressed",function() 
                    if not current_menu then return end 
                    current_menu.down()
                end) 
        
            end),
            KeyEvent("MOUSE_BUTTON","MOUSE_LEFT",function(on) 
                on("justreleased",function() 
                    if not current_menu then return end 
                    
                    current_menu.submit(true)
                end) 
            end),
            KeyEvent("MOUSE_BUTTON","MOUSE_RIGHT",function(on)
                on("justpressed",function()  
                    if not current_menu then return end 
                    current_menu.cancel()
                end) 
            end),




            KeyEvent("PAD_DIGITALBUTTON","LUP_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.up()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.up()
                end,500,500,true)
            end),
            KeyEvent("PAD_DIGITALBUTTON","LDOWN_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.down()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.down()
                end,500,500,true)   
            end),
            KeyEvent("PAD_DIGITALBUTTON","LLEFT_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.left()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.left()
                end,500,500,true) 
            end),
            KeyEvent("PAD_DIGITALBUTTON","LRIGHT_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.right()
                end) 
                on("press",function()
                    if not current_menu then return end 
                    current_menu.right()
                end,500,500,true) 
            end),

            KeyEvent("PAD_DIGITALBUTTON","RDOWN_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.submit()
                end) 
            end),
            KeyEvent("PAD_DIGITALBUTTON","RRIGHT_INDEX",function(on)  
                on("justpressed",function()
                    if not current_menu then return end 
                    current_menu.cancel()
                end) 
            end),
        }
        
        end 
    end 
    
    
    
    
    return self
end 

exports("Menu",Menu)

