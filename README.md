### cherry-wit

## config

```
"witd_url": "http://192.168.1.68:8080",
"wit_token": "MY_TOKEN",
```

## api

Produces "from: wit" messages. e.g.

```javascript
cherry.handle({
  wit: function (message) {
    var plugins = cherry.plugins();
    var intent = message.outcomes[0].intent;

    if (intent === 'lights_on') {
      plugins.hue({on: true});
    } else if (intent === 'lights_off') {
      plugins.hue({on: false});
    } else {
      console.log("unkown intent " + intent);
    }
  }
});
```

