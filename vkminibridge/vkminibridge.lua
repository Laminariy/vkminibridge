json = require "vkminibridge.json.json"


local M = {}

if html5 then
	html5.run(sys.load_resource("/vkminibridge/vkbridge/browser.min.js"))
	html5.run("vkBridge.subscribe(msg => JsToDef.send(msg.detail.type, msg.detail.data))")
end

function M.get_start_params()
	if not html5 then 
		return 
	end
	
	local param_string = html5.run("document.location.search")

	local params = {}
	for k, v in param_string:gmatch("([^=?&]*)=([^=?&]*)") do
		if v:find(',') then
			params[k] = {}
			for val in v:gmatch("%w+") do
				params[k][#params[k]+1] = val
			end
		else
			params[k] = v
		end
	end

	return params
end

function M.send(method, params)
	if not html5 then 
		return 
	end
	
	if params == nil or next(params) == nil then
		params = "{}"
	else
		params = json:encode(params)
	end
	html5.run(string.format("vkBridge.send('%s', %s)", method, params))
end

function M.subscribe(listener)
	if not jstodef then 
		return 
	end
	jstodef.add_listener(listener)
end

function M.unsubscribe(listener)
	if not jstodef then 
		return 
	end
	jstodef.remove_listener(listener)
end

function M.supports(method)
	if not html5 then 
		return 
	end
	return html5.run(string.format("vkBridge.supports('%s')", method))
end

function M.isWebView()
	if not html5 then 
		return 
	end
	return html5.run("vkBridge.isWebView()")
end

return M
