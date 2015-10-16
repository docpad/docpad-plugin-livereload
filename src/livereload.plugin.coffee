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
			pathname: '/docpad-livereload'
			enabled: false
			getSocket: null
			inject: true

			generateBeforeBlock: null
			generateAfterBlock: null
			listenBlock: null
			injectBlock: null
			scriptBlock: null
			styleBlock: null

			socketOptions:
				transformer: 'websockets'
				parser: 'JSON'

			environments:
				development:
					enabled: true

		# Populate Collections
		# Used to inject our scripts block with our socket generate listener
		populateCollections: (opts) ->
			# Prepare
			docpad = @docpad
			config = @getConfig()

			# Blocks
			generateBeforeBlock = config.generateBeforeBlock or """
				if ( typeof document.getElementsByTagName !== 'undefined' ) {
					document.getElementsByTagName('html')[0].className += ' wait';
				}
				"""
			generateAfterBlock = config.generateAfterBlock or """
				document.location.reload();
				"""
			listenBlock = config.listenBlock or """
				/* Did we just livereload? */
				var log = !!(localStorage && console && console.log && true);
				if ( log && localStorage.getItem('#{config.channel}/reloaded') === 'yes' ) {
					localStorage.removeItem('#{config.channel}/reloaded');
					console.log('LiveReload completed at', new Date())
				}

				/* Listen for the regenerated event and perform a reload of the page when the event occurs */
				var listen = function(){
					var primus = new Primus('#{config.channel}');
					primus.on('data', function(data){
						if ( data && data.message ) {
							if ( data.message === 'generateBefore' ) {
								if ( log ) {
									console.log('LiveReload started at', new Date());
								}
								#{generateBeforeBlock}
							}
							else if ( data.message === 'generateAfter' ) {
								if ( log ) {
									localStorage.setItem('#{config.channel}/reloaded', 'yes');
								}
								#{generateAfterBlock}
							}
						}
					});
				};
				"""
			injectBlock = config.injectBlock or """
				/* Inject socket into our page */
				var inject = function(){
					var t = document.createElement('script');
					t.type = 'text/javascript';
					t.async = 'async';
					t.src = '#{config.pathname}/primus.js';
					t.onload = listen;
					var s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(t, s);
				};
				"""
			scriptBlock = config.scriptBlock or
				if config.inject
					"""
					(function(){
						#{listenBlock}
						#{injectBlock}
						if ( typeof Primus !== 'undefined' ) {
							listen();
						} else {
							inject();
						}
					})();
					"""
				else
					"""
					(function(){
						#{listenBlock}
						if ( typeof Primus !== 'undefined' ) {
							listen();
						}
					})();
					"""
			styleBlock = config.styleBlock or """
				html.wait {
					cursor: wait !important;
					opacity: 0;
					transition: opacity 0.5s ease;
				}
				"""

			# Script
			docpad.getBlock('scripts').add(scriptBlock, {defer:false})

			# Style
			docpad.getBlock('styles').add(styleBlock)

			# Chain
			@

		# Setup Extend
		# Start our socket
		serverExtend: (opts) ->
			# Prepare
			{serverHttp} = opts
			plugin = @
			docpad = @docpad
			config = @getConfig()

			# Configuration
			extendr = require('extendr')
			socketOptions = extendr.deep({}, config.socketOptions, {
				pathname: config.pathname
			})

			# Get socket using custom method if set
			@socket = config.getSocket?(opts, socketOptions)
			if @socket
				docpad.log('info', "LiveReload listening to custom socket on channel #{config.channel}")
			else
				# Create a socket using primus
				Primus = require('primus')
				@socket = new Primus(serverHttp, socketOptions)
				@socket.on('error', docpad.warn)

				# Log
				docpad.log('info', "LiveReload listening to new socket on channel #{config.channel}")

			# Chain
			@

		# Generate Before
		generateBefore: ->
			# Notify client
			@socket?.write(message: 'generateBefore')

			# Chain
			@

		# Generate After
		generateAfter: ->
			# Notify client
			@socket?.write(message: 'generateAfter')

			# Chain
			@

		# DocPad Destroy
		docpadDestroy: ->
			# Destroy the sockets
			@socket?.destroy({
				close: false  # Close the HTTP server that Primus received
				end: true  # End all active connections
			})

			# Chain
			@
