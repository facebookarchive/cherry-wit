http = require "http"
request = require "request"

log = ->
  Array.prototype.unshift.call(arguments, "[cherry-wit]");
  console.log.apply(console, arguments);

module.exports = (cherry) ->
  req = (cfg, url, qs, cb) ->
    url = cfg.witd_url + url
    token = cfg.wit_token

    qs ||= {}
    qs.access_token = token

    log url, qs

    request(url: url, qs: qs, json: true, (err, res, body) ->
      if err
        log 'ERROR: ' + err
      else if (res && body && (res.statusCode == 200))
        cb && cb(res, body)
      else
        log 'ERROR: http ' + res.statusCode
    )

  cherry.register 'wit', (x) ->
    cfg = cherry.config

    if x.text
      req cfg, '/text', { q: x.text }, (res, body) ->
        cherry.produce(from: 'wit', body: body)
      return

    if x.mic == 'start'
      req cfg, '/start', {}
    else if x.mic == 'stop'
      req cfg, '/stop', {}, (res, body) ->
        cherry.produce(from: 'wit', body: body)
    else
      log 'unknown msg', x
