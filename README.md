# Live Reload Plugin for [DocPad](https://docpad.org)

<!-- BADGES/ -->

<span class="badge-travisci"><a href="http://travis-ci.org/docpad/docpad-plugin-livereload" title="Check this project's build status on TravisCI"><img src="https://img.shields.io/travis/docpad/docpad-plugin-livereload/master.svg" alt="Travis CI Build Status" /></a></span>
<span class="badge-npmversion"><a href="https://npmjs.org/package/docpad-plugin-livereload" title="View this project on NPM"><img src="https://img.shields.io/npm/v/docpad-plugin-livereload.svg" alt="NPM version" /></a></span>
<span class="badge-npmdownloads"><a href="https://npmjs.org/package/docpad-plugin-livereload" title="View this project on NPM"><img src="https://img.shields.io/npm/dm/docpad-plugin-livereload.svg" alt="NPM downloads" /></a></span>
<span class="badge-daviddm"><a href="https://david-dm.org/docpad/docpad-plugin-livereload" title="View the status of this project's dependencies on DavidDM"><img src="https://img.shields.io/david/docpad/docpad-plugin-livereload.svg" alt="Dependency Status" /></a></span>
<span class="badge-daviddmdev"><a href="https://david-dm.org/docpad/docpad-plugin-livereload#info=devDependencies" title="View the status of this project's development dependencies on DavidDM"><img src="https://img.shields.io/david/dev/docpad/docpad-plugin-livereload.svg" alt="Dev Dependency Status" /></a></span>
<br class="badge-separator" />
<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-bitcoin"><a href="https://bevry.me/bitcoin" title="Donate once-off to this project using Bitcoin"><img src="https://img.shields.io/badge/bitcoin-donate-yellow.svg" alt="Bitcoin donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>
<br class="badge-separator" />
<span class="badge-slackin"><a href="https://slack.bevry.me" title="Join this project's slack community"><img src="https://slack.bevry.me/badge.svg" alt="Slack community badge" /></a></span>

<!-- /BADGES -->


Automatically refreshes your [DocPad](https://docpad.org) built website whenever a regeneration is performed



## Install

1. Install the Plugin

	``` bash
	docpad install livereload
	```

1. Ensure your layout outputs the scripts block

	1. In eco:

		```
		<%- @getBlock('scripts').toHTML() %>
		```

	1. In jade:

		``` jade
		!= getBlock('scripts').toHTML()
		```


## Configure

### `enabled`
This option specifies whether or not this plugin should be enabled or disabled, by default it is `true` for the development environment and `false` for all other environments.

### `inject`
This option specifies whether or not we should try to inject our socket library into the page. It is `true` by default.

### `getSocket`
This option when falsey (the default) means we will create our own socket instance, however if you already have your own socket instance you can set this option as a function that will return your own socket instance.

### `channel`
This option specifies the which channel we should listen to, it defaults to `/docpad-livereload`

### `pathname`
This option specifies the the pathname that primus should use, it defaults to `/docpad-livereload`

### `socketOptions`
This option allows you to customise the [primus configuration](https://github.com/primus/primus) that we use if we have to create our own instance.

### `generateBeforeBlock`, `generateAfterBlock`, `listenBlock`, `injectBlock`, `scriptBlock`, `styleBlock`
These options allow you to customise the content of the scripts and styles that are injected into your page by this plugin. Check out the source code of this plugin to figure out their usage.


## Troubleshooting

- [Watching doesn't work, works only some of the time, or I get `EISDIR` errors](http://docpad.org/docs/troubleshoot#watching-doesn-t-work-works-only-some-of-the-time-or-i-get-eisdir-errors)


<!-- HISTORY/ -->

<h2>History</h2>

<a href="https://github.com/docpad/docpad-plugin-livereload/blob/master/HISTORY.md#files">Discover the release history by heading on over to the <code>HISTORY.md</code> file.</a>

<!-- /HISTORY -->


<!-- CONTRIBUTE/ -->

<h2>Contribute</h2>

<a href="https://github.com/docpad/docpad-plugin-livereload/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->

<h2>Backers</h2>

<h3>Maintainers</h3>

These amazing people are maintaining this project:

<ul><li><a href="http://balupton.com">Benjamin Lupton</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=balupton" title="View the GitHub contributions of Benjamin Lupton on repository docpad/docpad-plugin-livereload">view contributions</a></li></ul>

<h3>Sponsors</h3>

No sponsors yet! Will you be the first?

<span class="badge-patreon"><a href="https://patreon.com/bevry" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>
<span class="badge-opencollective"><a href="https://opencollective.com/bevry" title="Donate to this project using Open Collective"><img src="https://img.shields.io/badge/open%20collective-donate-yellow.svg" alt="Open Collective donate button" /></a></span>
<span class="badge-flattr"><a href="https://flattr.com/profile/balupton" title="Donate to this project using Flattr"><img src="https://img.shields.io/badge/flattr-donate-yellow.svg" alt="Flattr donate button" /></a></span>
<span class="badge-paypal"><a href="https://bevry.me/paypal" title="Donate to this project using Paypal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg" alt="PayPal donate button" /></a></span>
<span class="badge-bitcoin"><a href="https://bevry.me/bitcoin" title="Donate once-off to this project using Bitcoin"><img src="https://img.shields.io/badge/bitcoin-donate-yellow.svg" alt="Bitcoin donate button" /></a></span>
<span class="badge-wishlist"><a href="https://bevry.me/wishlist" title="Buy an item on our wishlist for us"><img src="https://img.shields.io/badge/wishlist-donate-yellow.svg" alt="Wishlist browse button" /></a></span>

<h3>Contributors</h3>

These amazing people have contributed code to this project:

<ul><li><a href="https://github.com/amesarosh">Alex Mesarosh</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=amesarosh" title="View the GitHub contributions of Alex Mesarosh on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="antoinebrault.ca">Antoine Brault</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=antoinebrault" title="View the GitHub contributions of Antoine Brault on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="http://balupton.com">Benjamin Lupton</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=balupton" title="View the GitHub contributions of Benjamin Lupton on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="http://delapouite.com">Bruno Heridet</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=Delapouite" title="View the GitHub contributions of Bruno Heridet on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="http://www.garthdb.com">Garth Braithwaite</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=GarthDB" title="View the GitHub contributions of Garth Braithwaite on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="http://robloach.net">Rob Loach</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=RobLoach" title="View the GitHub contributions of Rob Loach on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="https://github.com/scottoreilly">Scott O'Reilly</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=scottoreilly" title="View the GitHub contributions of Scott O'Reilly on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="https://github.com/StephenBrown2">Stephen Brown II</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=StephenBrown2" title="View the GitHub contributions of Stephen Brown II on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="http://vaughan.io">Vaughan Rouesnel</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=vjpr" title="View the GitHub contributions of Vaughan Rouesnel on repository docpad/docpad-plugin-livereload">view contributions</a></li>
<li><a href="https://github.com/vsopvsop">vsopvsop</a> — <a href="https://github.com/docpad/docpad-plugin-livereload/commits?author=vsopvsop" title="View the GitHub contributions of vsopvsop on repository docpad/docpad-plugin-livereload">view contributions</a></li></ul>

<a href="https://github.com/docpad/docpad-plugin-livereload/blob/master/CONTRIBUTING.md#files">Discover how you can contribute by heading on over to the <code>CONTRIBUTING.md</code> file.</a>

<!-- /BACKERS -->


<!-- LICENSE/ -->

<h2>License</h2>

Unless stated otherwise all works are:

<ul><li>Copyright &copy; 2012+ <a href="http://bevry.me">Bevry Pty Ltd</a></li></ul>

and licensed under:

<ul><li><a href="http://spdx.org/licenses/MIT.html">MIT License</a></li></ul>

<!-- /LICENSE -->
