function pretty(t, indent)
	indent = indent or ""
	
	local names = {}
	for n, _ in pairs(t) do
		table.insert(names, n)
    end
	
    for _, n in pairs(names) do
		local v = t[n]
        if type(v) == "table" then
            if v == t then --prevent endless loop, if table contains reference to itself
                print(indent .. tostring(n) .. ": <-")
            else
                print(indent .. tostring(n) .. ":")
                pretty(v, indent .. "   ")
            end
        else
            if type(v) == "function" then
                print(indent .. tostring(n) .. "()")
            else
                print(indent .. tostring(n) .. ": " .. tostring(v))
            end
        end
    end
end