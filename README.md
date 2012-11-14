# Live Reload Plugin for DocPad
Automatically refreshes your [DocPad](https://docpad.org) built website whenever a rengeration is performed



## Install

1. Install the Plugin

  ```
  npm install --save docpad-plugin-livereload
  ```

1. Ensure your layout outputs the scripts block, using eco it will look something like this:

  ```
  <%- @getBlock('script').toHTML() %>
  ```


## Configure

### Enabled
By default this plugin is disabled for all environments except the development environment. To enable on more environments set the `enabled` option to `true` inside your environments configuration.


## History
You can discover the history inside the `History.md` file


## License
Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT License](http://creativecommons.org/licenses/MIT/)
<br/>Copyright &copy; 2012 [Bevry Pty Ltd](http://bevry.me)