# History

- v2.3.0 January 19, 2013
	- Removed shrinkwrap file, hopefully dependency issues have been resolved
	- Added `getSocket` configuration option so you can now use existing sockets if you wish
	- Made the socket.io log level customisable via the `defaultLogLevel` config option and now defaults to 1 unless in debug mode which defaults to 3
		- Closes [pull request #4](https://github.com/docpad/docpad-plugin-livereload/pull/4) thanks to [Alex](https://github.com/amesarosh)
	- Added the ability to customise the socket options via `socketOptions` config option
	- Added the ability to customise the channel we listen on via the `channel` config option, also changed the default channel from `/docpad-live-reload` to `/docpad-livereload`
	- We will now log to the browser if we were reloaded by livereload, this can be turned off via the `browserLog` config option
	- Added the ability to customise what happens at regeneration via the 'regenerateBlock' config option

- v2.2.0 December 29, 2012
	- Added a [npm shrinkwrap file](https://npmjs.org/doc/shrinkwrap.html) due to recent dependency issues some people suffered
	- Now only injects the socket.io script if it isn't already defined
	- Added a basic generate test

- v2.1.2 October 2, 2012
	- Added support for DocPad v6.7

- v2.1.1 August 10, 2012
	- Re-added markdown files to npm distribution as they are required for the npm website

- v2.1.0 July 18, 2012
	- Renamed from `live-reload` to `livereload` to follow new DocPad convention
	- Updated for DocPad v6.3.0
