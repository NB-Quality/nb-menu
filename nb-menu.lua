Menu = function(...)
    local r = exports["nb-menu"]:Menu(...)
    r.buttons = nil
    setmetatable(r,{__index=function(t,k) if k == "buttons" then return r.getbuttons() end end,__call = function(t,...) r.setcb(...)  return r end } )

    
    return r 
end 

