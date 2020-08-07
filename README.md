# VKminiBridge
Simple Defold library for integrating with official VK clients for iOS, Android and Web.
Provides the basic functionality of VK bridge.

---

## Installation

Install VKminiBridge in your project by adding it as a [library dependency](https://www.defold.com/manuals/libraries/). Open your game.project file and in the "Dependencies" field under "Project", add:
```
https://github.com/Laminariy/vkminibridge/archive/v1.0.zip
```

Then open the "Project" menu of the editor and click "Fetch Libraries". You should see the "vkminibridge" folder appear in your assets panel after a few moments.

## Dependencies

This project depends on the JsToDef project:

* __[JsToDef](https://github.com/AGulev/jstodef)__

You need to add these as dependency in your game.project file, along with the dependency to this project itself.

## Basic Setup

After installation, it just takes one simple step to get VKminiBridge up and running:

* Add a "/vkminibridge/vkbridge/browser.min.js" file in your [custom resources](https://defold.com/manuals/project-settings/#custom-resources)
