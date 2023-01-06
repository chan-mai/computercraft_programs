-- グローバルな変数
fuelSlot = 16
zSize = 5
count = 1


-- 指定されたブロックの数だけ前にすすむ関数
function _forward(cnt)
    for i = 1, cnt do
        turtle.forward()
    end
end

-- 指定された回数右に曲がる処理
function _turnRight(cnt)
    for i = 1, cnt do
        turtle.turnRight()
    end
end

-- 指定された回数左に曲がる処理
function _turnLeft(cnt)
    for i = 1, cnt do
        turtle.turnLeft()
    end
end

-- 収穫関数
function _harvest()
    for i=1,COUNT do
        _forward(Z_SIZE)
        _turnRight()
        _forward(Z_SIZE)
        _turnLeft()
    end
end

-- チェストに戻る関数
function _returnChest()
    turtle.turnLeft()
    for i=1,COUNT*3 do
        turtle.forward()
    end
    turtle.turnRight()
end

-- アイテムをドロップさせる関数
function _dropItem(start_cnt, end_cnt)
    -- 表示
    print("Drop items: slots " .. start_cnt .. " to " .. end_cnt .. ".")
    for i=start_cnt, end_cnt do
        turtle.select(i)
        turtle.dropDown()
    end
    turtle.select(1)
end

-- 燃料の補給・確認用関数
function _chFuel()
    turtle.select(fuelSlot)
    turtle.refuel()

    -- 燃料が足りない場合
    if(turtle.getFuelLevel() < minFuelLevel) then
        turtle.suckUp()
        turtle.refuel()
        if(turtle.getFuelLevel() < minFuelLevel) then
            print("Fuel is not enough.")
            return false
        end
    end

    print("Fuel level: " .. turtle.getFuelLevel())
    return true
end

-- メイン処理
-- 第一引数: 奥行きの長さ
-- 第二引数: 繰り返し回数
args = {...}

if(args and #args == 2) then
    Z_SIZE = tonumber(args[1])
    COUNT = tonumber(args[2])
end
minFuelLevel = ((Z_SIZE + 2 + Z_SIZE + 1) * COUNT) + (3 * COUNT)

print("harvesting " .. Z_SIZE .. "x" .. Z_SIZE .. " area " .. COUNT .. " times.")
print("Fuel level(current / needed) :", turtle.getFuelLevel(), '/', minFuelLevel)

while true do
    if(_chFuel() == false) then
        break
    end
    print("Start harvest!!")
    turtle.select(1)
    _harvest()
    _returnChest()
    _dropItem(1, 16)
    print("Harvesting is completed.")
    -- 20分待機
    sleep(1200)
end