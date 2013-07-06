# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class LivereloadPlugin extends BasePlugin
		# Plugin configuration
		name: 'livereload'

		# Plugin configuration
		# Only enable us on the development environment
		config:
			channel: '/docpad-livereload'
			enabled: false
			inject: true
			populateCollections: true
			socketOptions: null
			getSocket: null
			defaultLogLevel: 1
			browserLog: true
			regenerateBlock: null
			environments:
				development:
					enabled: true

		# Populate Collections
		# Used to inject our scripts block with our socket.io regenerate listener
		populateCollections: (opts) ->
			# Prepare
			docpad = @docpad
			config = @config
			scriptsBlock = docpad.getBlock('scripts')

			# Do not populate Collections if it's not wanted
			return @ unless config.populateCollections

			# Blocks
			regenerateBlock = config.regenerateBlock or """
				if ( log ) {
					localStorage.setItem('#{config.channel}/reloaded', 'yes');
				}
				document.location.reload();
				"""
			listenBlock = """
				/* Did we just livereload? */
				var log = #{JSON.stringify config.browserLog} && localStorage && console && console.log && true;
				if ( log && localStorage.getItem('#{config.channel}/reloaded') === 'yes' ) {
					localStorage.removeItem('#{config.channel}/reloaded');
					console.log('LiveReloaded at', new Date())
				}

				/* Listen for the regenerated event and perform a reload of the page when the event occurs */
				var listen = function(){
					var socket = io.connect('#{config.channel}');
					socket.on('regenerated',function(){
						#{regenerateBlock}
					});
				};
				"""
			injectBlock = """
				/* Inject socket.io into our page then listen once loaded */
				var inject = function(){
					var t = document.createElement('script');
					t.type = 'text/javascript';
					t.async = true;
					t.src = '/socket.io/socket.io.js';
					t.onload = listen;
					var s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(t,s);
				};
				"""
			# We must make sure the page is ready before injecting our `script` tag,
			# otherwise the `onload` event will not be registered.
			injectCall = """
				var readyStateCheckInterval = setInterval(function() {
				  if (document.readyState === "complete") {
				    inject();
				    clearInterval(readyStateCheckInterval);
				  }
				}, 10);
				"""
			scriptBlock =
				if config.inject
					"""
					(function(){
						#{listenBlock}
						if ( typeof io !== 'undefined' ) {
							listen();
						} else {
							#{injectBlock}
							#{injectCall}
						}
					})();
					"""
				else
					"""
					(function(){
						#{listenBlock}
						if ( typeof io !== 'undefined' ) {
							listen();
						}
					})();
					"""

			# Script
			scriptsBlock.add(scriptBlock, {defer:false})

			# Chain
			@

		# Setup After
		# Start our socket.io
		serverAfter: (opts) ->
			# Prepare
			{server,serverHttp} = opts
			docpad = @docpad
			config = @config
			logLevel = if docpad.getLogLevel() is 7 then 3 else config.defaultLogLevel
			socketOptions = config.socketOptions or {}
			socketOptions['log level'] ?= logLevel
			existingSocket = true

			# Get socket
			socket = @config.getSocket?()
			unless socket
				existingSocket = false
				socket = require('socket.io').listen(serverHttp or server, socketOptions)

			# Listen
			@socket = socket.of(config.channel)

			# Log
			docpad.log('info', "LiveReload listening to #{if existingSocket then 'existing' else 'new'} socket on channel #{config.channel} with log level #{logLevel}")

			# Chain
			@

		# Generate After
		generateAfter: (opts) ->
			# Prepare

			# Notify client
			@socket?.emit('regenerated')

			# Chain
			@
