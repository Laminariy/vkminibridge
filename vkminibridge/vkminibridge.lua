json = require "vkminibridge.json.json"


local listeners = {}

function provide_msg(self, message_id, message)
	if message_id == 'VKminiBridge' then
		for _, lst in pairs(listeners) do
			lst.listener(lst.obj, message)
		end
	end
end

if html5 and jstodef then
	html5.run(sys.load_resource("/vkminibridge/vkbridge/browser.min.js"))
	html5.run("vkBridge.subscribe(msg => JsToDef.send('VKminiBridge', msg.detail))")
	jstodef.add_listener(provide_msg)
end


M = {}

function M.get_start_params()
	local param_string = html5.run("document.location.search")

	local params = {}
	for k, v in param_string:gmatch("([^=?&]*)=([^=?&]*)") do
		params[k] = v
	end

	local token_string = params["vk_access_token_settings"]
	params["vk_access_token_settings"] = {}
	for setting in token_string:gmatch("%w+") do
		params["vk_access_token_settings"][#params["vk_access_token_settings"]+1] = setting
	end

	return params
end

function M.send(method, params)
	if params == nil or next(params) == nil then
		params = "{}"
	else
		params = json:encode(params)
	end
	html5.run(string.format("vkBridge.send('%s', %s)", method, params))
end

function M.subscribe(self, listener)
	listeners[#listeners+1] = {obj=self, listener=listener}
end

function M.unsubscribe(self, listener)
	for i, lst in pairs(listeners) do
		if lst.obj == self and lst.listener == listener then
			listeners[i] = nil
			break
		end
	end
end

function M.supports(method)
	return html5.run(string.format("vkBridge.supports('%s')", method))
end

function M.isWebView()
	return html5.run("vkBridge.isWebView()")
end

return M