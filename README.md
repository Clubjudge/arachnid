# Arachnid
Arachnid is a simple service that allows your Javascript powered application to be fully indexed by SEO spiders.

You must configure your server to redirect traffic from search bots towards your Arachnid instance.
Arachnid works by inspecting a custom HTTP Header ```x-original-uri```, and then hitting the configured hostname at the URL you provided.
A [PhantomJS](http://phantomjs.org) instance then executes all your Javascript code and returns the final page HTML.

Optionally, Arachnid can save scraped pages to a folder of your choice, so that subsequent requests to the same resource are faster.

For more info, check out our blog post on Arachnid at the [Clubjudge blog](http://blog.clubjudge.com/post/57057303972/introducing-arachnid).

## Configuration
Arachnid expects a ```config.js``` file to be present in the project root. It ships with a ```config.js.example``` file with all available options. These are:

**folder | String**

The folder path where Arachnid should save scraped pages. Only has any effect if **writeToFile** is set to ```true```.

**host | String**

The hostname to query URLs against. This value must be a valid URL for Arachnid to run correctly.

**port | Number**

The port where the service should run.

**timeout | Number**

The maximum time in ms that Arachnid should wait for your page to finish rendering before it returns the current HTML snapshot.

**writeToFile | Boolean**

Whether Arachnid should write scraped files to the disk. Works in tandem with the **folder** option.

## Installation

Install [NodeJS](http://nodejs.org) (v.0.8.11 works fine).

```
npm install -g phantomjs
npm install -g forever
npm install
```
## Running it

```
npm start
```

Starting will spin up an instance of bin/arachnid using [Forever](https://github.com/nodejitsu/forever). Any CLI arguments will be passed along to Forever.

## Debian package
Install dpkg-dev and build-essential
```
Run on root application:

dpkg-buildpackage -us -uc

to install:
```
dpkg -i ../arachnid_version.deb

## Stopping it
```
npm stop
```

## Pruning files
Over time the folder where Arachnid saves its scraped pages can become too large. There's an included utility script that will clear this folder for you.

```javascript
npm run-script pruneFiles
```

An example of how to set up this task to run regularly through cron would be:

```
min hour dayOfMonth month dayOfWeek cd /PATH/TO/ARACHNID/; /PATH/TO/NPM run-script pruneFiles
```
