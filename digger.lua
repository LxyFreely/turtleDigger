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

function do1()
    for i = 1, 16 do
        turtle.forward()
        turtle.digDown()
    end
end

function do2()
    turtle.right()
    turtle.forward()
    turtle.right()
end

function do3()
    turtle.left()
    turtle.forward()
    turtle.left()
end

function do4()
    turtle.right()
    for i = 1, 16 do
        turtle.forward()
    end
    turtle.right()
end

function do5()
    while not turtle.detectUp() do
        turtle.up()
    end
end

function do6()
    while not turtle.detectDown() do
        turtle.down()
    end
end

function 