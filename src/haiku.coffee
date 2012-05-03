r = require 'mersenne'
words = require '../lib/words.json'

styles = [
  {
    total: {
      noun: 4,
      adjective: 3,
      verb: 1
    },
    form: [
      "adjective", "noun", false,
      "noun", "verb", "preposition", "noun", false,
      "adjective", "adjective", "noun"
    ]
  }
]

class Haiku
  constructor: ->
    @state = "pending"
    @style = styles[r.rand(styles.length)]

    @maxPlays = @style.total.noun + @style.total.adjective + @style.total.verb
    @players = []

    @preposition = words.preposition
    @noun = []
    @adjective = []
    @verb = []

  fillIn: (listType) ->
    while @[listType].length isnt @style.total[listType]
      seed = r.rand(words[listType].length)
      @[listType].push(words[listType][seed])

  generateHaiku: ->
    for listType in ['noun', 'adjective', 'verb']
      @fillIn(listType) unless @[listType].length is @style.total[listType]

    haiku = ""
    for wordType in @style.form
      if wordType
        word = @[wordType].pop()
        haiku += "#{word} "
      else
        haiku += "\n"
    return haiku

module.exports = Haiku
