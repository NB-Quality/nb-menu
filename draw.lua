--[[
menu = CreateMenu 

menu:add_info 
menu:add_button
menu:add_options

button:add_action
--]]
local e = {}
local AspectRatio = 1.777778

local DrawRect = DrawRect 
local DrawSprite = DrawSprite
local EndTextCommandDisplayText = EndTextCommandDisplayText
local AddTextComponentSubstringPlayerName = AddTextComponentSubstringPlayerName
local BeginTextCommandDisplayText = BeginTextCommandDisplayText
local SetTextScale = SetTextScale
local SetTextFont = SetTextFont
local SetColourOfNextTextComponent = SetColourOfNextTextComponent
local SetTextDropShadow = SetTextDropShadow
local STRING = "STRING"
local CommonMenu = "CommonMenu"

local GetIconTexture = function(iconid, highlighted) --max:61 dont use it in loop/draws
	local icons = {}
	local iconid = (iconid or 0) + 1
	icons = {
--[[0--]]	{"",""},
--[[1--]]	{"shop_NEW_Star","shop_NEW_Star"},
--[[2--]]	{"MP_hostCrown","MP_hostCrown"},
--[[3--]]	{"Shop_Tick_Icon","Shop_Tick_Icon"},
--[[4--]]	{"Shop_Box_TickB","Shop_Box_Tick"},
--[[5--]]	{"Shop_Box_CrossB","Shop_Box_Cross"},
--[[6--]]	{"Shop_Box_BlankB","Shop_Box_Blank"},
--[[7--]]	{"Shop_Clothing_Icon_B","Shop_Clothing_Icon_A"},
--[[8--]]	{"Shop_GunClub_Icon_B","Shop_GunClub_Icon_A"},
--[[9--]]	{"Shop_Tattoos_Icon_B","Shop_Tattoos_Icon_A"},
--[[10--]]	{"Shop_Garage_Icon_B","Shop_Garage_Icon_A"},
--[[11--]]	{"Shop_Garage_Bike_Icon_B","Shop_Garage_Bike_Icon_A"},
--[[12--]]	{"Shop_Barber_Icon_B","Shop_Barber_Icon_A"},
--[[13--]]	{"shop_Lock","shop_Lock"},
--[[14--]]	{"Shop_Ammo_Icon_B","Shop_Ammo_Icon_A"},
--[[15--]]	{"Shop_Armour_Icon_B","Shop_Armour_Icon_A"},
--[[16--]]	{"Shop_Health_Icon_B","Shop_Health_Icon_A"},
--[[17--]]	{"Shop_MakeUp_Icon_B","Shop_MakeUp_Icon_A"},
--[[18--]]	{"MP_SpecItem_Coke","MP_SpecItem_Coke"},
--[[19--]]	{"MP_SpecItem_Heroin","MP_SpecItem_Heroin"},
--[[20--]]	{"MP_SpecItem_Weed","MP_SpecItem_Weed"},
--[[21--]]	{"MP_SpecItem_Meth","MP_SpecItem_Meth"},
--[[22--]]	{"MP_SpecItem_Cash","MP_SpecItem_Cash"},
--[[23--]]	{"arrowleft","arrowleft"},
--[[24--]]	{"arrowright","arrowright"},
--[[25--]]	{"MP_AlertTriangle","MP_AlertTriangle"},
--[[26--]]	{"Shop_Michael_Icon_B","Shop_Michael_Icon_A"},
--[[27--]]	{"Shop_Franklin_Icon_B","Shop_Franklin_Icon_A"},
--[[28--]]	{"Shop_Trevor_Icon_B","Shop_Trevor_Icon_A"},
--[[29--]]	{"SaleIcon","SaleIcon"},
--[[30--]]	{"Shop_Lock_Arena","Shop_Lock_Arena"},
--[[31--]]	{"Card_Suit_Clubs","Card_Suit_Clubs"},
--[[32--]]	{"Card_Suit_Hearts","Card_Suit_Hearts"},
--[[33--]]	{"Card_Suit_Spades","Card_Suit_Spades"},
--[[34--]]	{"Card_Suit_Diamonds","Card_Suit_Diamonds"},
--[[35--]]	{"Shop_Art_Icon_B","Shop_Art_Icon_A"},
--[[36--]]	{"Shop_Chips_A","Shop_Chips_B"}
	}
	return highlighted and icons[iconid][2] or icons[iconid][1]
end


function DrawMenu(max_slots,x,y)
    AspectRatio = GetAspectRatio(false)

    local Loop = nil
    local TempLoop = nil
    local self;self = {style = {}}
    local r0,g0,b0,a0 = GetHudColour(0)
    local r2,g2,b2,a2 = GetHudColour(2)
    local r9,g9,b9,a9 = GetHudColour(9)
    
    local menuWidth = 0.240
    local titleHeight = 0.085
    
    local buttonFont = 0
    local buttonHeight = 0.038
    local basex = x or 0.085
    local buttonTextXOffset = 0.005
    local buttonTextYOffset = 0.005
    local basey = y or 0.096
	local rm,gm,bm,am = GetHudColour(140)
    
    --styles 
        local color,rc,gc,bc,ac 
        self.style.color = function(x)
            color = x
            rc,gc,bc,ac = GetHudColour(color)
        end 
        self.style.font = function(x)
            buttonFont = x or 0
        end 
        local titlealign = 0
        self.style.titlealign = function(x)
            titlealign = x
        end 
        local titlebackground = {CommonMenu, "interaction_bgd"}
        self.style.settitlebackground = function(x,y)
            RequestStreamedTextureDict(x)
            titlebackground = {x,y}
            color,rc,gc,bc,ac = nil
        end 
    --
    function _(toscale)
        toscale = (toscale * (1.777778 / AspectRatio));
        return toscale;
    end
    
    local title = ""
    local subtitle = ""
    local maxslots = max_slots or 7
    local buttons = {}
    
    local current_button_icon = nil
    
    local current_option_string = nil
    local current_optionicon = false 
    local current_optionwidth = 0
    local current_description = nil
    local current_optiondescription = nil
    local current_descriptionwidth = 0
    local current_descriptionlineheight = 0
    
    
    local buttonslots = #buttons 
    local isscroll = false
    local hightlighted = 1
    
    local cursorsupported = false 
    local prehightlighted = -1
    
    local texture = nil
    
    local isrendering = false 
    --local closed = false 
    local opened = false 
    
    self["end"] = function()
        --closed = true 
        self.render(false)
        opened = false 
        
    end 
    self["start"] = function()
        self.render(true)
        opened = true 
        
        --closed = false
    end 
    
     
    self.render = function(isrender)
        AspectRatio = GetAspectRatio(false)
        isrendering = isrender
        if isrender and not Loop then 
            Loop = PepareLoop(0)
            texture = CommonMenu
            RequestStreamedTextureDict(texture)
            
            Loop(function(duration)
                
                if not isrendering or not opened then return duration("kill") end 
                local menuwidth = _(menuWidth)
                local titleheight = _(titleHeight)
                local buttonheight = _(buttonHeight)
                
                local rectx = basex + menuwidth / 2
                local recty = basey 
                if color then 
                    DrawRect(rectx, recty + titleheight/2, menuwidth, titleheight, rc, gc, bc, ac)
                else
                    DrawSprite(titlebackground[1], titlebackground[2] ,rectx, recty + titleheight/2, menuwidth, titleheight,0, r0, g0, b0, a0)
                end 
                
                BeginTextCommandDisplayText(STRING)
                SetTextDropShadow(2, 2, 0, 0, 0)
                --SetColourOfNextTextComponent(0)
                SetTextColour(r0, g0, b0, a0)
                SetTextFont(buttonFont)
                SetTextScale(1.0, titleheight*10)
                AddTextComponentSubstringPlayerName(title)
                SetTextWrap(basex,basex + menuwidth)
                if titlealign == 1 then 
                    SetTextCentre(true)
                    EndTextCommandDisplayText(basex + menuwidth/2, recty + titleheight/5)
                else 
                    SetTextRightJustify(titlealign)
                    EndTextCommandDisplayText(buttonTextXOffset+basex, recty + titleheight/5)
                end 
                recty = recty + titleheight
                
                DrawRect(rectx, recty + buttonheight/2, menuwidth, buttonheight, rm,gm,bm,255)
                BeginTextCommandDisplayText(STRING)
                --SetColourOfNextTextComponent(0)
                SetTextColour(r0, g0, b0, a0)
                SetTextFont(buttonFont)
                SetTextScale(1.0, buttonheight*10)
                AddTextComponentSubstringPlayerName(subtitle)
                EndTextCommandDisplayText(basex + buttonTextXOffset, recty )
                
                if isscroll then 
                BeginTextCommandDisplayText(STRING)
                SetTextWrap(basex, basex + menuwidth - buttonTextXOffset)
                SetTextRightJustify(2)
                --SetColourOfNextTextComponent(9)
                SetTextColour(r9, g9, b9, a9)
                SetTextFont(buttonFont)
                SetTextScale(1.0, buttonheight*10)
                AddTextComponentSubstringPlayerName(hightlighted .. ' / '..buttonslots)
                EndTextCommandDisplayText(basex + menuwidth, recty )
                end 
                recty = recty + buttonheight 
                local slots = (buttonslots > maxslots and maxslots or buttonslots)
                DrawSprite(CommonMenu, "Gradient_Bgd",rectx, recty + buttonheight * slots / 2, menuwidth, buttonheight * slots,0, r0, g0, b0, a0)
                
                local from, to = 1, slots 
                if isscroll and hightlighted > slots then 
                    from, to = hightlighted-(slots-1),hightlighted
                end 
                
                --Mouse 
                    local bx,bw,bh = basex,menuwidth,buttonheight
                    local csx,csy,slotfound
                    
                    if cursorsupported then 
                        csx,csy = GetControlNormal(2, 239),GetControlNormal(2, 240);
                        SetMouseCursorActiveThisFrame()
                    end 
                --
                
                local n = 0
                for i = from, to, 1 do 
                    local tr,tg,tb,ta = r0,g0,b0,a0
                    local rr,rg,rb,ra = r0,g0,b0,a0
                    local textcolor = 0 
                    local isthisselected = (hightlighted == i)
                    local by = buttonheight * n + recty + buttonheight / 2
                    if not slotfound and cursorsupported and csx > bx and csx < bx + bw and csy > by  and csy < by + bh then 
                        slotfound = i 
                        DrawSprite(CommonMenu, "Gradient_Nav",rectx, by , menuwidth, buttonheight,0, r0, g0, b0, 100)
                        local tips,tipswidth,tipsheight = buttons[i]("getcursortips")
                        local tipsoffset = 0.01
                        if tips then 
                            local diff = tipswidth
                            local k = 0
                            repeat k = k + 1;diff = diff - menuwidth until diff < 0
                            local extend = (k - 1) * tipsheight + (k > 1 and tipsheight/2 or 0)
                            
                            DrawSprite(CommonMenu, "Gradient_Bgd",csx + tipswidth/2 + tipsoffset, csy + (buttonheight + extend)/2 + tipsoffset, tipswidth, buttonheight + extend,0, r0, g0, b0, 100)
                            BeginTextCommandDisplayText(STRING)
                            --SetColourOfNextTextComponent(0)
                            SetTextColour(r0, g0, b0, a0)
                            SetTextFont(buttonFont)
                            SetTextScale(1.0, buttonheight*10)
                            if k > 0 then 
                                SetTextWrap(csx + tipsoffset, csx + tipsoffset + menuwidth )
                            end 
                            AddTextComponentSubstringPlayerName(tips)
                            
                            EndTextCommandDisplayText(csx + tipsoffset, csy + tipsoffset)
                        end 
                    end 
                    
                    if isthisselected then 
                        DrawSprite(CommonMenu, "Gradient_Nav",rectx, by , menuwidth, buttonheight,0, r0, g0, b0, 220)
                        textcolor = 2
                        tr,tg,tb,ta = r2,g2,b2,a2
                        rr,rg,rb,ra = r2,g2,b2,a2
                        if current_option_string then 

                            if current_optionicon then 
                                DrawSprite(CommonMenu, "arrowleft" ,basex + menuwidth - current_optionwidth - (buttonTextXOffset * 4), buttonheight * n + recty + buttonheight / 2, buttonheight/AspectRatio, buttonheight,0, rr,rg,rb,ra)
                                DrawSprite(CommonMenu, "arrowright" ,basex + menuwidth - (buttonTextXOffset * 2), buttonheight * n + recty + buttonheight / 2, buttonheight/AspectRatio, buttonheight,0, rr,rg,rb,ra)
                            end 
                        end 
                    end 
                    
                    BeginTextCommandDisplayText(STRING)
                    SetColourOfNextTextComponent(textcolor)
                    SetTextFont(buttonFont)
                    SetTextScale(1.0, buttonheight*10)
                    AddTextComponentSubstringPlayerName(buttons[i]("item"))
                    EndTextCommandDisplayText(basex + buttonTextXOffset, recty + buttonheight * n )
                    
                    
                    local optionselectiontext,optionselectiontextwidth = buttons[i]("getoptionselectiontext")
                    
                    if optionselectiontext then 
                        BeginTextCommandDisplayText(STRING)
                        SetColourOfNextTextComponent(textcolor)
                        SetTextFont(buttonFont)
                        SetTextScale(1.0, buttonheight*10)
                        AddTextComponentSubstringPlayerName(optionselectiontext)
                        EndTextCommandDisplayText(basex + menuwidth - optionselectiontextwidth - (buttonTextXOffset * (isthisselected and 3 or 1.5))  , recty + buttonheight * n )
                        
                    end 
                    local icon = buttons[i]("icon",isthisselected)
                    if icon then 
                        --DrawSprite(CommonMenu, icon ,basex + menuwidth - buttonheight - (buttonTextXOffset * 3)  , recty + buttonheight * n, buttonheight/AspectRatio, buttonheight,0, rr,rg,rb,ra)
                        
                        DrawSprite("CommonMenu", icon ,basex + menuwidth - (buttonTextXOffset * 2.5) ,recty + buttonheight * n + buttonheight/2, buttonheight/AspectRatio, buttonheight,0, r0, g0, b0, a0)
                    end 
                    n = n + 1 
                end 
                prehightlighted = slotfound or -1
                recty = recty + buttonheight * slots 
                
                if isscroll then 
                DrawRect(rectx, recty + buttonheight/2, menuwidth, buttonheight, rm,gm,bm,255)
                DrawSprite(CommonMenu, "shop_arrows_upANDdown", rectx, recty + buttonheight/2 , buttonheight/AspectRatio, buttonheight, 0, r0, g0, b0, 255);
                    --if current_option_string then 
                    --DrawSprite(CommonMenu, "shop_arrows_upANDdown", rectx , recty + buttonheight/2 , buttonheight/AspectRatio, buttonheight, 90.0, r0, g0, b0, 255);
                    --end 
                recty = recty + buttonheight
                end 
                
                
                
                if current_optiondescription or current_description then 
                    recty = recty + 0.0025
                    local diff = current_descriptionwidth
                    local k = 0
                    repeat k = k + 1;diff = diff-menuwidth until diff < 0
                    local extend = (k - 1) * current_descriptionlineheight + (k > 1 and current_descriptionlineheight/2 or 0)
                    
                    DrawSprite(CommonMenu, "Gradient_Bgd",rectx, recty + (buttonheight + extend)/2, menuwidth, buttonheight + extend,0, r0, g0, b0, a0)
                    BeginTextCommandDisplayText(STRING)
                    --SetColourOfNextTextComponent(0)
                    SetTextColour(r0, g0, b0, a0)
                    SetTextFont(buttonFont)
                    SetTextScale(1.0, buttonheight*10)
                    if k > 0 then 
                        SetTextWrap(basex, basex + menuwidth)
                    end 
                    AddTextComponentSubstringPlayerName(current_optiondescription or current_description)
                    
                    EndTextCommandDisplayText(basex + buttonTextXOffset, recty )
                end 
               
            end,function()
                Loop = nil
                if HasStreamedTextureDictLoaded(texture) then 
                    SetStreamedTextureDictAsNoLongerNeeded(texture)
                end 
            end)
        end 
    end 
    
    self.settitle = function(x)
        title = x 
    end 
    self.setsubtitle = function(x)
        subtitle = x 
    end 
    
    local setoptionstring = function(x)
        current_option_string = x
        if current_option_string then 
            local buttonheight = _(buttonHeight)
            SetTextFont(buttonFont)
            SetTextScale(1.0, buttonheight*10)
            BeginTextCommandGetWidth(STRING)
            AddTextComponentSubstringPlayerName(current_option_string)
            current_optionwidth = EndTextCommandGetWidth(true)
        end 
    end 
    local seticon = function(x)
        current_button_icon = x
    end 
    local setoptiondescription = function(x)
        current_optiondescription = x
        if current_optiondescription then
            local buttonheight = _(buttonHeight)
            SetTextFont(buttonFont)
            SetTextScale(1.0, buttonheight*10)
            BeginTextCommandGetWidth(STRING)
            AddTextComponentSubstringPlayerName(current_optiondescription)
            current_descriptionwidth = EndTextCommandGetWidth(true)
            current_descriptionlineheight = GetRenderedCharacterHeight(buttonheight*10,buttonFont)
        end 
    end 
    
    local newbuttonobject = function(itemname,opts)
        local itemname = itemname 
        local itemdesc = nil
        
        local options,selected
        
  
        local icon = nil
        local iconhightlighted = nil
        local iconselecter = function(newicon)
            icon = GetIconTexture(newicon) 
            iconhightlighted = GetIconTexture(newicon,true)
        end 
        
        
        local optiontext = {} 
        local optiontextwidth = {} 
        
        
        local cursortips = nil
        local cursortipswidth = nil
        local cursortipsheight = nil
        
        if opts then 
            if type(opts) == "number" then 
                icon = GetIconTexture(opts) 
                iconhightlighted = GetIconTexture(opts,true)
            elseif type(opts) == "table" and #opts > 0 then 
                options = opts 
                for i,r in pairs(options) do 
                    local istable = type(r) == "table" and #r > 0
                    local text = istable and r[1] or r  
                    SetTextFont(buttonFont)
                    SetTextScale(1.0, _(buttonHeight)*10)
                    BeginTextCommandGetWidth(STRING)
                    AddTextComponentSubstringPlayerName(text)
                    optiontextwidth[i] = EndTextCommandGetWidth(true)
                    optiontext[i] = text
                end 
                selected = 1
            end 
        end 
        
        
        local onaction = nil
        
        
        
        local checkoptions = function()
            if selected and (options or e)[selected] then 
                local value = options[selected]
                local istable = type(value) == "table" and #value > 0
               
                if istable then 
                    setoptionstring(value[1])
                    local desc,fn = value[2]
                    if type(desc) ~= "string" then 
                        --fn = value[2]
                        desc = nil 
                    end 
                    setoptiondescription(desc)
                else 
                    setoptiondescription(nil)
                    setoptionstring(options[selected])
                end 
                current_optionicon = #options > 1
            else 
                setoptiondescription(nil)
                setoptionstring(nil)
            end 
        end     
        
        local checkdescription = function()
            current_description = itemdesc
            if current_description then 
                local buttonheight = _(buttonHeight)
                SetTextFont(buttonFont)
                SetTextScale(1.0, buttonheight*10)
                BeginTextCommandGetWidth(STRING)
                AddTextComponentSubstringPlayerName(current_description)
                current_descriptionwidth = EndTextCommandGetWidth(true)
                current_descriptionlineheight = GetRenderedCharacterHeight(buttonheight*10,buttonFont)
            end 
        end 
        
 
        
        return function(action,value,c,d,...)
            if action == "item" then 
                return itemname
            elseif action == "icon" then 
                if value then 
                    return iconhightlighted 
                else 
                    return icon
                end 
            elseif action == "geticonselecter" then 
                return iconselecter
            elseif action == "getselected" then 
                return selected
            elseif action == "getoptionselection" then 
                return selected and (options or e)[selected]
            elseif action == "getoptionselectiontext" then 
                return selected and (optiontext or e)[selected],selected and (optiontextwidth or e)[selected]
            elseif action == "getdescription" then 
                return itemdesc
            elseif action == "getcursortips" then 
                return cursortips,cursortipswidth,cursortipsheight
            elseif action == "setoptionselection" then   
                if selected then 
                    local temp = value 
                    if options and #options >= 1 then 
                        if temp <= 0 then 
                            temp = (temp-1)%#options+1
                        elseif temp > #options then 
                            temp = temp%#options
                            if temp <= 0 then 
                                temp = (temp-1)%#options+1
                            end 
                        end 
                        selected = temp
                        checkoptions()
                    end
                end 
            elseif action == "checkoptions" then 
                checkoptions()
            elseif action == "setdescription" then 
                itemdesc = value
                checkdescription()
            elseif action == "checkdescription" then 
                checkdescription()
            elseif action == "setcursortips" then 
                cursortips = value 
                SetTextFont(buttonFont)
                SetTextScale(1.0, _(buttonHeight)*10)
                BeginTextCommandGetWidth(STRING)
                AddTextComponentSubstringPlayerName(cursortips)
                cursortipswidth = EndTextCommandGetWidth(true)
                cursortipsheight = GetRenderedCharacterHeight(_(buttonHeight)*10,buttonFont)
            elseif action == "cb" then 
                if onaction then onaction(value,c,d,...) end 
            else
                if not action then
                    if onaction then onaction(itemname,selected,(selected and (optiontext or e)[selected])) end 
                else 

                    if type(action) == "string" then 
                        itemname = action
                        if type(value) == "string" then  
                            options = {}
                            itemdesc = value 
                            onaction = c
                            checkdescription()
                            checkoptions()
                        elseif type(c) == "string" then 
                            itemdesc = c 
                            onaction = d
                            checkdescription()
                            checkoptions()
                        else 
                            onaction = value
                            
                        end 
                    else 
                        onaction = action
                    end 
                    
                end 
            end 
        end 
    end 
    
    self.getobject = function(itemname,options,desc,fn)
        local desc,fn = desc,fn 
        if type(desc) ~= "string" then 
            fn = desc 
            desc = nil
        end
        
        if type(options) == "string" then 
            desc = options 
            obj = newbuttonobject(itemname)
        elseif type(options) == "table" and #options > 0 or type(options) == "number" then 
            obj = newbuttonobject(itemname,options)
        else 
            obj = newbuttonobject(itemname)
            fn = options
        end 
        
        if desc then obj("setdescription",desc) end 
        if fn then obj(fn) end 

        return obj
    end 
    
    self.addbutton = function(itemname,options,desc,fn)
        local obj = self.getobject(itemname,options,desc,fn)
        local old = #buttons
        table.insert(buttons,obj)
        buttonslots = #buttons 
        isscroll = buttonslots > maxslots
        if old == 0 and not hightlighted then hightlighted = 1 end 
        self.setselection(hightlighted)
        return obj
    end 
    
    self.updatebutton = function(idx,...)
        buttons[idx] = self.getobject(...)
        buttonslots = #buttons 
        isscroll = buttonslots > maxslots
        if old == 0 and not hightlighted then hightlighted = 1 end 
        self.setselection(hightlighted)
    end 
    
    self.updatebuttons = function(_buttons)
        for i,v in pairs(_buttons) do 
            self.updatebutton(i,table.unpack(v))
        end 
    end 
    
    self.setbuttons = self.updatebuttons
    self.setbutton = self.updatebutton
    
    
    
    self.clearbuttons = function()
        buttons = {}
    end 
    self.setselection = function(y,x,cb)
        AspectRatio = GetAspectRatio(false)
        local old = buttons[hightlighted] and vector2(hightlighted,buttons[hightlighted]("getselected") or -1) or vector2(1,-1)
        
        if y then 
            if buttons and #buttons >= 1 then  
                if y <= 0 then 
                    y = (y-1)%#buttons+1
                elseif y > #buttons then 
                    y = y%#buttons
                    if y <= 0 then 
                        y = (y-1)%#buttons+1
                    end 
                end 
            end 
            hightlighted = y 
        end 

        if buttons[hightlighted] then 
            if x then 
                buttons[hightlighted]("setoptionselection",x)
            end 
            buttons[hightlighted]("checkoptions") 
            buttons[hightlighted]("checkdescription")
            if cb then cb(old,vector2(hightlighted,buttons[hightlighted]("getselected") or -1)) end 
        end 
    end 

    self.setcursor = function(x)
        cursorsupported = x 
    end 
    self.setcursortips = function(idx,desc)
        if buttons[idx] then buttons[idx]("setcursortips",desc) end 
    end 
    self.iscursorsupported = function()
        return cursorsupported
    end 
    
    self["return"] = function(cb)
        if not opened then return end 
        local icon = buttons[hightlighted]("icon")
        if icon then 
            buttons[hightlighted]("cb",buttons[hightlighted]("geticonselecter"))
        else 
            local optionselection = buttons[hightlighted]("getoptionselection")
            local istable = type(optionselection) == "table" and #optionselection > 0
            
            if optionselection and istable then 
                local desc,fn = optionselection[2],optionselection[3]
                if type(desc) ~= "string" then 
                    fn = desc;
                    desc =nil 

                end 
                if fn then fn() end 
            end  
            buttons[hightlighted]()
            if cb then 
                cb(vector2(hightlighted,buttons[hightlighted]("getselected") or -1),buttons[hightlighted]("item"),buttons[hightlighted]("getoptionselectiontext")) 
            end 
             
        end 
        
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    end 
    
    self["return_by_cursor"] = function(cb)
        if not opened then return end 
        if cursorsupported and prehightlighted ~= -1 and prehightlighted ~= hightlighted  then 
            self.setselection(prehightlighted); prehightlighted = -1 
        else 
            local optionselection = buttons[hightlighted]("getoptionselection")
            local istable = type(optionselection) == "table" and #optionselection > 0
            if optionselection and not istable then 
                self["right"]()
                
            else     
                self["return"](cb)
            end 
        end 
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    end 
    
    self.up = function(cb)
        if not opened then return end
        HudWeaponWheelIgnoreSelection()
        if buttons[hightlighted] then 
            local old = vector2(hightlighted,buttons[hightlighted]("getselected") or -1)
            self.setselection(hightlighted - 1)
            buttons[hightlighted]("checkoptions")
            if cb then cb(old,vector2(hightlighted,buttons[hightlighted]("getselected") or -1)) end 
            PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
        end 
        
    end 
    
    self.down = function(cb)
        if not opened then return end
        HudWeaponWheelIgnoreSelection()
        if buttons[hightlighted] then 
            local old = vector2(hightlighted,buttons[hightlighted]("getselected") or -1)
            self.setselection(hightlighted + 1)
            buttons[hightlighted]("checkoptions")
            if cb then cb(old,vector2(hightlighted,buttons[hightlighted]("getselected") or -1)) end  
            PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            
        end 
        
    end 
    
    self.left = function(cb)
        if not opened then return end
        if buttons[hightlighted] then 
           
            local optionselected = buttons[hightlighted]('getselected')
            if optionselected then 
                local old = vector2(hightlighted,buttons[hightlighted]("getselected") or -1)
                self.setselection(nil,optionselected - 1)
                buttons[hightlighted]("checkoptions")
                if cb then cb(old,vector2(hightlighted,buttons[hightlighted]("getselected") or -1)) end 
                PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end 
        end 
    end 
    
    self.right = function(cb)
        if not opened then return end
        if buttons[hightlighted] then 
            
            local optionselected = buttons[hightlighted]('getselected')
            if optionselected then 
                local old = vector2(hightlighted,buttons[hightlighted]("getselected") or -1)
                self.setselection(nil,optionselected + 1)
                buttons[hightlighted]("checkoptions")
                if cb then cb(old,vector2(hightlighted,buttons[hightlighted]("getselected") or -1)) end 
                PlaySound(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
            end 
        end 
    end 
    
    self.back = function(cb)
        if not opened then return end
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    end 
    
    self.buttons = buttons 
    
    self.getbuttons = function()
        return buttons
    end 
    
    self.isrendering = function()
        return isrendering
    end 
     
    return self
end 
