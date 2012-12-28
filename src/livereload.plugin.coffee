# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class LivereloadPlugin extends BasePlugin
		# Plugin configuration
		name: 'livereload'

		# Plugin configuration
		# Only enable us on the development environment
		config:
			enabled: false
			environments:
				development:
					enabled: true

		# Populate Collections
		# Used to inject our scripts block with our socket.io regenerate listener
		populateCollections: (opts) ->
			# Prepare
			docpad = @docpad
			scriptsBlock = docpad.getBlock('scripts')

			# Script
			scriptsBlock.add(
				"""
				(function(){
					// Add the depedency if it doesn't already exist
					if ( typeof eio === 'undefined' ) {
				        var t = document.createElement('script');
				        t.type = 'text/javascript';
				        t.src = '//raw.github.com/LearnBoost/engine.io-client/master/engine.io.js';
				        t.onload = function(){
							// Listen for the regenerated event
							// and perform a reload of the page when the event occurs
							var socket = eio('ws://'+window.location.host+'/docpad-live-reload');
							socket.onmessage = function(){
								document.location.reload();
							};
				        };
				        var s = document.getElementsByTagName('script')[0];
				        s.parentNode.insertBefore(t,s);
					}
				})();
				""",
				{
					defer: false
				}
			)

			# Chain
			@

		# Setup After
		# Start our socket.io
		serverAfter: (opts) ->
			# Prepare
			{server,serverHttp} = opts

			# Initialise Now
			@sockets = []
			@socketServer = require('engine.io').attach(serverHttp or server, {path:'/docpad-live-reload'})
			@socketServer.on 'connection', (socket) =>
				@sockets.push(socket)
				socket.on 'close', =>
					@sockets[@sockets.indexOf(socket)] = null

			# Chain
			@

		# Generate After
		generateAfter: (opts) ->
			# Prepare
			return @  if @sockets

			# Notify client
			for socket in @sockets
				socket?.send('regenerated')

			# Chain
			@
