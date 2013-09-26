# Description:
#   Get instagram images by hash tag
#
# Dependencies:
#   "instagram-node-lib": "*"
#   https://github.com/mckelvey/instagram-node-lib
#
# Configuration:
#   HUBOT_INSTAGRAM_CLIENT_KEY
#   HUBOT_INSTAGRAM_ACCESS_KEY
#   HUBOT_INSTAGRAM_ACCESS_TOKEN
#
# Commands:
#   hubot insta tag <tag> <count>- Show recent instagram tags
#   hubot insta user <username> <count>- Show recent instagram tags
#   by default count is 1 
#
# Author:
#   raysrashmi
#


Instagram = require('instagram-node-lib')

config =
    client_key:     process.env.HUBOT_INSTAGRAM_CLIENT_KEY
    client_secret:  process.env.HUBOT_INSTAGRAM_ACCESS_KEY
    access_token:   process.env.HUBOT_INSTAGRAM_ACCESS_TOKEN

module.exports = (robot) ->
  robot.respond /(insta tag)( me )?(.*)/i, (msg) ->
    count = 1
    authenticateUser(msg)
    if msg.match[3]
      text = msg.match[3].trim().split(" ")
      tag =  text[0]
      count = parseInt(text[1]) if text[1]
    else
      msg.send 'Please provied tag'
      return
    Instagram.tags.recent 
      name: tag
      count: count
      complete: (data) ->
       for item in data
          msg.send item['images']['standard_resolution']['url']
  robot.respond /(insta user)( me )?(.*)/i, (msg) ->
    count = 1
    authenticateUser(msg)
    if  msg.match[3]
      text = msg.match[3].trim().split(" ")
      username =  text[0]
      count =  parseInt(text[1]) if text[1]
      Instagram.users.search
        q: username
        count: 1
        complete: (data) ->
          user_id = data[0]['id']
          if user_id
            Instagram.users.recent
              user_id: user_id
              count: count
              access_token: config.access_token
              complete: (data) ->
                for item in data
                  msg.send item['images']['standard_resolution']['url']
          else
            msg.send "No user found by #{username}"

authenticateUser = (msg) ->
  unless config.client_key
    msg.send "Please set the HUBOT_INSTAGRAM_CLIENT_KEY environment variable."
    return
  unless config.client_secret
    msg.send "Please set the HUBOT_INSTAGRAM_ACCESS_KEY environment variable."
    return
  unless config.access_token
    msg.send "Please set the HUBOT_INSTAGRAM_ACCESS_TOKEN environment variable."
    return
  Instagram.set('client_id', config.client_key)
  Instagram.set('client_secret', config.client_secret)


          



