# nb-menu

![Q20220703020037|331x400](https://github.com/negbook/nb-menu/blob/main/preview.png?raw=true)

All the menu functions is in the examples 
## basic build
```
local menu
menu = Menu(3,0.085,0.096)(function(slotselected,item,optionselected) --maxslots,x,y,cbonsubmit,cboncancel
    print('submit',slotselected,item,optionselected)
end,function()
    print('close')
end)

local buttons = menu.buttons
menu.settitle("hello")
menu.setsubtitle("asdada")
menu.setbuttons{
    {"apple",{1,2,3},"cao"},
    {"banana",{1,2,3},"asdkajdsl"}
}
menu.open() -- begin render, we do dont have menu.close
```

advanced build
```
local menu2;menu2 = Menu(7,0.085,0.096)
    menu2(--set the onsubmit,oncancel
        function(slotselected,item,optionselected)
            print('submit2',slotselected,item,optionselected)
        end,
        function()
            print('close2')
        end
    )
    menu2.settitle("~y~hello2~s~")
    menu2.setsubtitle("asdada2")
    local mycheckboxchecked = false --a var for checkbox on hit set
    menu2.setbuttons{
        {
            "apple2",{
                {"action","this is action temp desc",function() print('hello1') end},--a actionable options should be a table in the options table
                {"action2",function() print('hello2') end},
                {"action3","this is action temp desc3",function() print('hello3') end},
                "this is not a action1",
                "this is not a action2",
                "this is not a action3"
                },
            "selection of apple2",--description 
            function(item,optionselected,option)
                print('button2 cb',item,optionselected,option)
            end
        },
        {
            "banana2",{1,2,3},
            "asdkajdsl2",
            function(item,optionselected,option)
                print('button2 cb',item,optionselected,option)--a button cb, will call it on submit
            end
        },
        {
            "menu1",
            function(item,optionselected,option)
                menu.open()
            end
        },
        {
            "menu31",{{"menu3","~y~open the menu3",function(item,optionselected,option)
                menu3.open()
            end},2,3},
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            
        },
        {
            "checkbox",mycheckboxchecked and 6 or 5,"check it and change the icon if you want",
            function(iconchanger)
                mycheckboxchecked = not mycheckboxchecked
                iconchanger(mycheckboxchecked and 6 or 5)
            end
        },
        
    }
    menu2.setbutton(1,"setbutton apple2",{
        {"setbutton action","setbutton this is action temp desc",function() print('hello1') end},
        {"setbutton action2",function() print('hello2') end},
        {"setbutton action3","setbutton this is action temp desc3",function() print('hello3') end},
        "setbutton this is not a action1",
        "setbutton this is not a action2",
        "setbutton this is not a action3"
        },
    "setbutton selection of apple2",
    function(item,optionselected,option)
        print('button2 cb',item,optionselected,option)
    end) -- we can update some button dynamically
    
    menu2.open() 
    
    --menu2.style.color(10)
    menu2.style.titlealign(0) -- we can set some styles
    menu2.style.settitlebackground('shopui_title_auto_shop', 'shopui_title_auto_shop')
    menu2.setcursor(true) -- set the menu is mouse supported, it will cost only 0.01~0.02 ms more
    menu2.setcursortips(1,"hello")  -- we can set the mouse hover tips on a button
```
