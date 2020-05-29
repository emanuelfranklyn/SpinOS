--draw api
-- add commands to draw thing more easy

Draw = {}

--function Draw.DrawImage(Image, Older)
--    if (Image == Older) then
--    else
--        --Get the diference between the strings
--        --Draw the diference
--    end
--end

function Draw.DrawImage(Image)
    ImageResolutionX, ImageResolutionY = 0,0
    ForJumper = 0
    ForJumperEnable = false
    for u = 1,string.len(Image) do
        if (ForJumperEnable == true and u < ForJumper) then
        else
            if (string.sub(Image, u, u+6) == "IMGRES:") then
                for a = u+6,string.len(Image) do
                    if (string.sub(Image, a,a) == "|") then
                        for c = u+6,a do
                            if (string.sub(Image, c,c) == "x") then
                                ImageResolutionX = tonumber(string.sub(Image, u+7, c-1))
                                ImageResolutionY = tonumber(string.sub(Image, c+1, a-1))
                                gpu.setResolution(ImageResolutionX,ImageResolutionY)
                                break
                            end
                        end
                        break
                    end
                end
            end
            --Resolution ^ | \/ Draw Pixels 
            if (string.sub(Image, u, u+3) == "Box.") then
                --Draw the box
                for w = u+11,string.len(Image) do
                    if (string.sub(Image, w,w) == "X") then
                        for b = w, string.len(Image) do
                            if (string.sub(Image, b, b) == "Y") then
                                for z = b, string.len(Image) do
                                    if (string.sub(Image,z,z) == "T") then
                                        for q = z+2, string.len(Image) do
                                            --Get the final Pos
                                            if (string.sub(Image,q,q) == "Y") then
                                                for r = q+1, string.len(Image) do
                                                    if (string.sub(Image, r,r) == "|") then
                                                        gpu.setForeground(tonumber(string.sub(Image, u+4, u+11)))
                                                        for X = tonumber(string.sub(Image, w+1, b-1)),tonumber(string.sub(Image, z+2, q-1)) do
                                                            for Y = tonumber(string.sub(Image, b+1, z-1)), tonumber(string.sub(Image, q+1, r-1)) do
                                                                if ((Y == tonumber(string.sub(Image, b+1, z-1)) or Y == tonumber(string.sub(Image, q+1, r-1))) or (X == tonumber(string.sub(Image, w+1, b-1)) or X == tonumber(string.sub(Image, z+2, q-1)))) then
                                                                    gpu.set(X,Y,"█")
                                                                end
                                                            end
                                                        end
                                                        break
                                                    end
                                                end
                                                break
                                            end
                                        end
                                        break
                                    end
                                end
                                break
                            end
                        end
                        break
                    end
                end
            end
            if (string.sub(Image, u, u+3) == "Txt.") then
                for i = u+20, string.len(Image) do
                    if (string.sub(Image,i,i) == "Y") then
                        for h = i+1, string.len(Image) do
                            if (string.sub(Image, h,h+1) == "LL") then
                                for j = h+2,string.len(Image) do
                                    if (string.sub(Image, j,j) == ":") then
                                        ForJumperEnable = true
                                        ForJumper = j+1+tonumber(string.sub(Image, h+2, j-1))
                                        gpu.setForeground(tonumber(string.sub(Image, u+4, u+11)))
                                        gpu.setBackground(tonumber(string.sub(Image, u+12, u+19)))
                                        gpu.set(tonumber(string.sub(Image,u+21,i-1)), tonumber(string.sub(Image,i+1,h-1)), string.sub(Image, j+1, j+tonumber(string.sub(Image, h+2, j-1))))
                                    end
                                end
                            end
                        end
                        break
                    end
                end
            end
            if (string.sub(Image, u, u+4) == "FBox.") then
                --Draw the box
                for w = u+13,string.len(Image) do
                    if (string.sub(Image, w,w) == "X") then
                        for b = w, string.len(Image) do
                            if (string.sub(Image, b, b) == "Y") then
                                for z = b, string.len(Image) do
                                    if (string.sub(Image,z,z) == "T") then
                                        for q = z, string.len(Image) do
                                            --Get the final Pos
                                            if (string.sub(Image,q,q) == "Y") then
                                                for r = q, string.len(Image) do
                                                    if (string.sub(Image, r,r) == "|") then
                                                        gpu.setForeground(tonumber(string.sub(Image, u+5, u+12)))
                                                        for X = tonumber(string.sub(Image, w+1, b-1)),tonumber(string.sub(Image, z+2, q-1)) do
                                                            for Y = tonumber(string.sub(Image, b+1, z-1)), tonumber(string.sub(Image, q+1, r-1)) do
                                                                gpu.set(X,Y,"█")
                                                            end
                                                        end
                                                        break
                                                    end
                                                end
                                                break
                                            end
                                        end
                                        break
                                    end
                                end
                                break
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

function Draw.DrawBoxRaw(Image,x1,y1,x2,y2,color)
    for u = 1,string.len(Image) do
        if (string.sub(Image, u, u+3) == "Box.") then
            --Draw the box
            for w = u+11,string.len(Image) do
                if (string.sub(Image, w,w) == "X") then
                    for b = w, string.len(Image) do
                        if (string.sub(Image, b, b) == "Y") then
                            for z = b, string.len(Image) do
                                if (string.sub(Image,z,z) == "T") then
                                    for q = z+2, string.len(Image) do
                                        --Get the final Pos
                                        if (string.sub(Image,q,q) == "Y") then
                                            for r = q+1, string.len(Image) do
                                                if (string.sub(Image, r,r) == "|") then
                                                    --X1: tonumber(string.sub(Image, w+1, b-1))
                                                    --X2: tonumber(string.sub(Image, z+2, q-1))
                                                    --Y1: tonumber(string.sub(Image, b+1, z-1))
                                                    --Y2: tonumber(string.sub(Image, q+1, r-1))
                                                    --Color: tonumber(string.sub(Image, u+4, u+11))
                                                    if (tonumber(color) == tonumber(string.sub(Image, u+4, u+11))) then
                                                        --The same color, verify the postions --Merge the squares at the best way
                                                        if (tonumber(string.sub(Image, b+1, z-1)) == y1) then
                                                            --they start at the same Y cordinate
                                                            if (tonumber(string.sub(Image, q+1, r-1)) == y2) then
                                                                --and finish at the same Y cordinate
                                                                --If they find their touch earch one transform the 2 quares in just one
                                                                if (x1 < tonumber(string.sub(Image, z+2, q-1))+2 and x2 > tonumber(string.sub(Image, w+1, b-1))-2) then
                                                                    --the squares are overlaying then self and have the same color
                                                                    RestOfImage = string.sub(Image, r+1, string.len(Image)) -- the rest of message after the |
                                                                    BeforeOfImage = string.sub(Image 1, u-2) -- all things than becomes before the | than has before the instructions of the box who will be modificated
                                                                    theX,theX2 = 1,1
                                                                    if (x1 < tonumber(string.sub(Image, w+1, b-1))) then theX = x1 else theX = tonumber(string.sub(Image, w+1, b-1)) end
                                                                    if (x2 > tonumber(string.sub(Image, z+2, q-1))) then theX2 = x2 else theX = tonumber(string.sub(Image, z+2, q-1)) end
                                                                    Comand = "Box.0x"+color+"X"+theX+"Y"+y1+"TX"+theX2+"Y"+y2
                                                                    return BeforeOfImage+"|"+Comand+"|"+RestOfImage
                                                                end
                                                            end
                                                        end
                                                        if (tonumber(string.sub(Image, w+1, b-1)) == x1) then
                                                            --they start at the same X
                                                            if (tonumber(string.sub(Image, z+2, q-1)) == x2) then
                                                                --and end at the same x
                                                                if (y1 < tonumber(string.sub(Image, q+1, r-1))+2 and y2 > tonumber(string.sub(Image, b+1, z-1))-2) then
                                                                    --the squares are overlaying it selfs
                                                                    RestOfImage = string.sub(Image, r+1, string.len(Image)) -- the rest of message after the |
                                                                    BeforeOfImage = string.sub(Image 1, u-2) -- all things than becomes before the | than has before the instructions of the box who will be modificated
                                                                    theY,theY2 = 1,1
                                                                    if (y1 < tonumber(string.sub(Image, b+1, z-1))) then theY = y1 else theX = tonumber(string.sub(Image, b+1, z-1)) end
                                                                    if (y2 > tonumber(string.sub(Image, q+1, r-1))) then theY2 = y2 else theX = tonumber(string.sub(Image, q+1, r-1)) end
                                                                    Comand = "Box.0x"+color+"X"+x1+"Y"+theY+"TX"+x2+"Y"+theY2
                                                                    return BeforeOfImage+"|"+Comand+"|"+RestOfImage
                                                                end
                                                            end
                                                        end
                                                        if ((tonumber(string.sub(Image, w+1, b-1)) > x1-1 and tonumber(string.sub(Image, w+1, b-1)) < x2+1) or (tonumber(string.sub(Image, z+2, q-1)) > x1-1 and tonumber(string.sub(Image, z+2, q-1)) < x2+1)) then
                                                            --their x coordinates are overlayed --check the Y coordinate to verify the overlay
                                                            if ((tonumber(string.sub(Image, b+1, z-1)) > y1-1 and tonumber(string.sub(Image, b+1, z-1)) < y2+1) or (tonumber(string.sub(Image, q+1, r-1)) > y1-1 and tonumber(string.sub(Image, q+1, r-1)) < y2+1)) then
                                                                --their y coordinates are overlayed --the boxes are overlayed
                                                                if (x1 > tonumber(string.sub(Image, w+1, b-1))) then
                                                                    RestOfImage = string.sub(Image, r+1, string.len(Image)) -- the rest of message after the |
                                                                    BeforeOfImage = string.sub(Image 1, u-2) -- all things than becomes before the | than has before the instructions of the box who will be modificated
                                                                    Comand1 = "Box.0x"+color+"X"+x1+"Y"+y1+"TX"+x2+"Y"+y2 --the new box
                                                                    Comand2 = "Box.0x"+color+"X"+tonumber(string.sub(Image, w+1, b-1))+"Y"+theY+"TX"+x1-1+"Y"+theY2 --first piece of the bottom box
                                                                    Comand3 = "Box.0x"+color+"X"+x1+"Y"+theY+"TX"+x2+"Y"+theY2
                                                                    return BeforeOfImage+"|"+Comand+"|"+RestOfImage
                                                                else

                                                                end
                                                            end
                                                        end
                                                    else
                                                        --Diferent color, verify postions -- overlay the squares the best way
                                                    end
                                                    break
                                                end
                                            end
                                            break
                                        end
                                    end
                                    break
                                end
                            end
                            break
                        end
                    end
                    break
                end
            end
        end
    end
end

return Draw

--ImageFormat

--IMGRES:100x30|Box.0x00FF00X14Y10TX24Y20|Txt.0xFFFFFF0x000000X10Y4LL14:ABC|GGAAAAAAA1|FBox.0x0000FFX50Y5TX80Y25|