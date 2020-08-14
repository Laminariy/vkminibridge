# VKminiBridge
Simple Defold library for integrating with official VK clients for iOS, Android and Web.

Provides the basic functionality of [VK Bridge](https://vk.com/dev/vk_bridge_methods).

---

## Installation

Install VKminiBridge in your project by adding it as a [library dependency](https://www.defold.com/manuals/libraries/). Open your game.project file and in the "Dependencies" field under "Project", add:
```
https://github.com/Laminariy/vkminibridge/archive/v1.0.2.zip
```

Then open the "Project" menu of the editor and click "Fetch Libraries". You should see the "vkminibridge" folder appear in your assets panel after a few moments.

## Dependencies

This project depends on the JsToDef project:

* __[JsToDef](https://github.com/AGulev/jstodef)__

You need to add these as dependency in your game.project file, along with the dependency to this project itself.

### JsToDef

You can still use the JsToDef for your own needs. To filter messages from VK Bridge, use message_id check:

```lua
function listener(self, message_id, message)
	if message_id == "yourmessage" then
		-- do something
	end
end
```

## Basic Setup

After installation, it just takes one simple step to get VKminiBridge up and running:

Add a "/vkminibridge/vkbridge/browser.min.js" file in your [custom resources](https://defold.com/manuals/project-settings/#custom-resources)

## Usage

```lua
local VKminiBridge = require "vkminibridge.vkminibridge"

function init(self)
	-- Subscribes to event, sended by client
	VKminiBridge.subscribe(listener)

	-- Sends event to client
	VKminiBridge.send('VKWebAppInit', {})
end
```

You can find a description of all VK Bridge events [here](https://vk.com/dev/vk_bridge_events)

## API Reference

### `VKminiBridge.get_start_params()`

Returns a table containing application start parameters from URL.

You can find a description of start parameters here:

- for [Direct Games](https://vk.com/dev/games_vk_bridge?f=%D0%90%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F%20%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D0%B5%D0%BB%D1%8F)
- for [VK Mini Apps](https://vk.com/dev/vk_apps_docs3?f=6.%2B%D0%9F%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D1%8B%2B%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0)

**Example**

```lua
local VKminiBridge = require "vkminibridge.vkminibridge"

function init(self)
	local start_params = VKminiBridge.get_start_params()
	for k, v in pairs(start_params) do
		print(k, v)
	end
end
```

### `VKminiBridge.send(method[, params])`

Sends a message to native client.

**Parameters**

- `method` <kbd>string</kbd> (_required_) The VK Bridge method
- `params` <kbd>table</kbd> (_optional_) Message data table

**Example**

```lua
local VKminiBridge = require "vkminibridge.vkminibridge"

function init(self)
	VKminiBridge.send('VKWebAppStorageGetKeys', {count = 20, offset = 0})
end
```

### `VKminiBridge.subscribe(listener)`

Subscribes a function to events listening.

**Parameters**

- `listener` <kbd>function</kbd> (_required_) Function to be subscribed to events

Where `listener` is a function with the next parameters:

- `self` Current script self
- `event_type` String that contains the VK Bridge event type
- `event_data` Table that contains the VK Bridge event data

**Example**

```lua
local VKminiBridge = require "vkminibridge.vkminibridge"

function listener(self, event_type, event_data)
	for k, v in pairs(event_data) do
		print(k, v)
	end
end

function init(self)
	VKminiBridge.subscribe(listener)
	VKminiBridge.send('VKWebAppInit', {})
end
```

### `VKminiBridge.unsubscribe(listener)`

Unsubscribes a function from events listening.

**Parameters**

- `listener` <kbd>function</kbd> (_required_) Event subscribed function

### `VKminiBridge.supports(method)`

Returns `true` if an event is available on the current device.

**Parameters**

- `method` <kbd>string</kbd> (_required_) The VK Bridge method

### `VKminiBridge.isWebView()`

Returns `true` if VK Bridge is running in mobile app.

## Issues and suggestions

If you have any issues, questions or suggestions please [create an issue](https://github.com/Laminariy/vkminibridge/issues).

You can also find me in [VK](https://vk.com/glorius_silver).
