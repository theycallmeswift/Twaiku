Player = require './player'

TwilioClient = require('twilio').Client
Twiml        = require('twilio').Twiml
client       = new TwilioClient(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN, 'example.com', { port: 8080, basePath: 'incoming' })

phone = client.getPhoneNumber("+12622579438")

# Players
haikus  = []
players = []

phone.setup ->
  phone.on 'incomingSms', (smsParams, response) ->
    [currentPlayer] = players.filter (player) -> player.number == smsParams.From
    if currentPlayer
      console.log "FOUND PLAYER WITH NUMBER: #{currentPlayer.number}"
    else
      player = new Player(smsParams.From, smsParams.Body)
      players.push player
      response.append(new Twiml.Sms("Welcome to the game, #{player.name}!"))
      console.log "ADDING NEW PLAYER: #{smsParams.From}"

    response.send()

#    haiku = generateHaiku()
#    console.log(haiku)
#    response.append(new Twiml.Sms(haiku))
#    response.send()
