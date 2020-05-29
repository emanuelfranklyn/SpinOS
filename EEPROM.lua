--Define component! 
	setmetatable(component, {__index = function(component, t)
		local p, err = component.proxy(component.list(t)() or "")
		if p then 
			return p 
		else 
			error("O Sistema encontrou um erro grave: "..(err or "Componente faltando")..": "..t) 
		end
	end})
--

--Bind Gpu to Screen
	gpu = component.proxy(component.list("gpu")())
	screen, _ = component.list("screen")()
	if gpu and screen then
		gpu.bind(screen)
	end
--

local eeprom = component.list("eeprom")()

--Define a Global Function called FatalError
--Only called by system when some important script failed and is inpossible to recover system
function FatalError(Text) 
	error(":(".."\n".."Erro FATAL! Mostre isso para a assistencia tecnica: ".."\n"..Text)
end

local component_invoke = component.invoke
	local function boot_invoke(address, method, ...)
	local result = table.pack(pcall(component_invoke, address, method, ...))
	if not result[1] then
		return nil, result[2]
	else
		return table.unpack(result, 2, result.n)
	end
end
	  
computer.getBootAddress = function()
	return boot_invoke(eeprom, "getData")
end

computer.setBootAddress = function(address)
	return boot_invoke(eeprom, "setData", address)
end

local function tryLoadFrom(address)
	local handle, reason = boot_invoke(address, "open", "/System32/Main.lua")
	if not handle then
		return nil, reason
	end
	local buffer = ""
	repeat
		local data, reason = boot_invoke(address, "read", handle, math.huge)
		if not data and reason then
			return nil, reason
		end
		buffer = buffer .. (data or "")
	until not data
	boot_invoke(address, "close", handle)
	return load(buffer, "=init")
end

local reason
if computer.getBootAddress() then
	init, reason = tryLoadFrom(computer.getBootAddress())
end
if not init then
	computer.setBootAddress()
	for address in component.list("filesystem") do
		init, reason = tryLoadFrom(address)
		if init then
			computer.setBootAddress(address)
			break
		end
	end
end
if not init then
	FatalError("Arquivo de instrução de inicialisação não encontrado! " .. (reason and (": " .. tostring(reason)) or ""), 0)  --exibe uma tela azul caso os arquivos do sistema não sejam encontrados
end

if (init) then
	init() -- Run - /System32/Main.lua
end

--[Base loop]--
while true do
	--[Loop of system]--
	computer.pullSignal()
end