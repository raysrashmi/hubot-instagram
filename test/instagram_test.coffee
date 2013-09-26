chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "Instagram", ->
  instagram_module = require("../src/instagram")

  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()
      random: sinon.spy()
    @instagram = instagram_module(@robot)

  describe "Get images", ->

    it "get one images of rays", ->
      expect(@robot.respond).to.have.been.calledWith(/insta tag.*rays/)

    it "get one images of raysrashmi", ->
      expect(@robot.respond).to.have.been.calledWith(/insta user.*raysrashmi/)
