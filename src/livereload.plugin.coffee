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
			inject: true
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

			# Blocks
			listenBlock = """
				// Listen for the regenerated event
				// and perform a reload of the page when the event occurs
				var socket = io.connect('/docpad-live-reload');
				socket.on('regenerated',function(){
					document.location.reload();
				});
				"""
			injectBlock = """
				// Add the depedency if it doesn't already exist
				if ( typeof io === 'undefined' ) {
					var t = document.createElement('script');
					t.type = 'text/javascript';
					t.async = true;
					t.src = '/socket.io/socket.io.js';
					t.onload = function(){

				#{listenBlock}

					};
					var s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(t,s);
				}
				"""

			# Script
			scriptsBlock.add(
				"""
				(function(){
					#{if config.inject then injectBlock else listenBlock}
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
			@socket = require('socket.io').listen(serverHttp or server).of('/docpad-live-reload')

			# Chain
			@

		# Generate After
		generateAfter: (opts) ->
			# Prepare

			# Notify client
			@socket?.emit('regenerated')

			# Chain
			@
