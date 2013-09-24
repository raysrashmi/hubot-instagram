chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "instagram", ->
  instagram_module = require("../src/instagram")

  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()
      random: sinon.spy()
    @instagram = instagram_module(@robot)

  describe "Get photos of a hashtag", ->

    it "get one photo of rays", ->
      expect(@robot.respond).to.have.been.calledWith(/insta tag.*rays/)

    it "should get 2 photo rays tag", ->
      cb = @robot.respond.firstCall.args[1]
      cb(@msg)
      expect(@msg.send).to.not.have.been.calledWithMatch(/\n/)


  describe "Bomb", ->

    it "registers a respond listener", ->
      expect(@robot.respond).to.have.been.calledWith(/principle.*bomb/)

    it "should send several lines of text", ->
      cb = @robot.respond.secondCall.args[1]
      cb(@msg)
      expect(@msg.send).to.have.been.calledWithMatch(/\n/)

