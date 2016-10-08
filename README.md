# Step Lifx Notifier

Step for showing status using your [LIFX](http://www.lifx.com) bulb during builds.

This step uses [official LIFX API](https://api.developer.lifx.com/docs/introduction) which requires OAuth2 Access token.
[Here](https://api.developer.lifx.com/docs/authentication) are the steps how to generate the access token.

## How to use this Step

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*
