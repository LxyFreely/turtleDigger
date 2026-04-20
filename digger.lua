--[[
一个控制CC电脑进行挖掘的脚本
坑洞大小为16*16*n
步骤：分动作
动作一：前进16格并一边挖掘脚下
动作二：右转前进右转
动作三：左转前进左转
动作四：右转前进16格右转
动作五：上升到报错
动作六：下降到报错

具体流程，执行一二一三循环直到最后一行(最后一次不要执行动作三)
然后执行动作四回到原点
然后执行动作五，卸货之后执行动作六
--]]
n=40

local function do1()
    for i = 1, 16 do
        turtle.digDown()
        turtle.forward()
    end
end

local function do2()
    turtle.right()
    turtle.forward()
    turtle.right()
end

local function do3()
    turtle.left()
    turtle.forward()
    turtle.left()
end

local function do4()
    turtle.right()
    for i = 1, 16 do
        turtle.forward()
    end
    turtle.right()
end

local function do5()
    while turtle.up() do end
end

local function do6()
    while turtle.down() do end
end

local function dump()
    for slot = 9,16 do
        turtle.select(slot)
        if turtle.getItemCount() > 0 then
            turtle.dropUp()
        end
    end
end

local function checkFuel()
    local target = 300
    if turtle.getFuelLevel() >= target then return end

    print("--- Refueling ---")
    while turtle.getFuelLevel() < target do
        local fuelBefore = turtle.getFuelLevel()
        local refueled = false
        for slot = 1, 16 do
            turtle.select(slot)
            if turtle.getItemCount() > 0 then
                turtle.refuel(1)
                if turtle.getFuelLevel() > fuelBefore then
                    print("Fueled: " .. turtle.getFuelLevel() .. "/" .. target)
                    refueled = true
                    break
                end
            end
        end
        if not refueled then
            print("ERROR: No fuel!")
        end
    end
    print("--- Ready ---")
end


--begin main
for i = 1, n do
    checkFuel()
    for j = 1, 8 do
        do1()
        do2()
        do1()
        if j~=8 then
            do3()
        end
    end
    do4()
    do5()
    dump()
    do6()
end
