### nodejs 5.10.1 + npm@latest

per project - build new image using this one as base, with `Dockerfile.app`

* if using bower, set in `.bowerrc`

      "directory": "node_modules/bower_components"

  and require them like this `require('bower_components/...')`

* every cmd invocation, eg. `node ./node_modules/...` should be replaced with `node $NODE_PATH/...`
