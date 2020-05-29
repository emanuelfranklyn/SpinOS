
local bootFilesystemProxy = component.proxy(component.proxy(component.list("eeprom")()).getData())

package = {
	paths = {
		["/System32/"] = true
	},
	loaded = {},
	loading = {}
}

function dofile(path)
	local stream, reason = bootFilesystemProxy.open(path, "r")
	if stream then
		local data, chunk = ""
		while true do
			chunk = bootFilesystemProxy.read(stream, math.huge)
			if chunk then
				data = data .. chunk
			else
				break
			end
		end

		bootFilesystemProxy.close(stream)

		local result, reason = load(data, "=" .. path)
		if result then
			return result()
		else
			error(reason)
		end
	else
		error(reason)
	end
end

function requireExists(path)
	return bootFilesystemProxy.exists(path)
end

function requireraw(module)
	-- For non-case-sensitive filesystems
	local lowerModule = string.lower(module)

	if package.loaded[lowerModule] then
		return package.loaded[lowerModule]
	elseif package.loading[lowerModule] then
		FatalError("Uma requisição recursiva foi encontrada: A biblioteca " ..'"'..module..'"'.. " está tentando chamar uma biblioteca que chama ela \n" .. debug.traceback().."\n".."Erro code 177419")
	else
		local errors = {}

		local function checkVariant(variant)
			if requireExists(variant) then
				return variant
			else
				table.insert(errors, "  variant \"" .. variant .. "\" not exists")
			end
		end

		local function checkVariants(path, module)
			return
				checkVariant(path .. module .. ".lua") or
				checkVariant(path .. module) or
				checkVariant(module)
		end

		local modulePath
		for path in pairs(package.paths) do
			modulePath =
				checkVariants(path, module) or
				checkVariants(path, string.upper(string.sub(module, 1, 1)) .. string.sub(module, 2, -1))
			
			if modulePath then
				package.loading[lowerModule] = true
				local result = dofile(modulePath)
				package.loaded[lowerModule] = result or true
				package.loading[lowerModule] = nil
				return result
			end
		end

		FatalError("Não foi possivel encontrar o modulo " .. '"'..module..'" ' .. table.concat(errors, "\n").."\n".."Erro code 544587")
	end
end

event = requireraw("Event")

draw = requireraw("Draw")

event.sleep(2)

draw.DrawImage("IMGRES:100x30|Box.0x00FF00X14Y10TX24Y20|Txt.0xFFFFFF0x000000X10Y4LL14:ABC|GGAAAAAAA1|FBox.0x0000FFX50Y5TX80Y25|")
--FatalError(event.pull())