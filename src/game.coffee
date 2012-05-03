class Game
  constructor: () ->
    @state = "pending"

    @maxPlayers = 8
    @totalNouns = 4
    @totalAdjectives = 3
    @totalVerbs = 1

    @players = []
