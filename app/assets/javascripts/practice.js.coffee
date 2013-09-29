app = angular.module('Verb', ["ngResource"])

app.factory "Api", ["$resource", ($resource) ->
  V_i: $resource("/by_infinitive/:infinitive",
    infinitive: "@infinitive"
  )
  V_g: $resource("/by_group/:group",
    group: "@group",
    isArray: true
  )
]

@PracticeCtrl = ($scope, Api) ->

  tenses = ['present', 'imparfait', 'passe_compose', 'passe_simple', 'plus_que_parfait', 'futur_simple', 'subjonctif']
  groups = [1, 2, 3]
  forms = ['je', 'tu', 'il', 'nous', 'vous', 'ils']

  $scope.set = ->
    $scope.verbs_db = []
    $scope.tenses_chosen = []
    $scope.groups_chosen = []
    for tense in tenses
      if $scope.tenses[tense]
        $scope.tenses_chosen.push(tense)

    if $scope.tenses_chosen.length > 0
      for group in groups
        if $scope.groups[group]
          console.log
          # a = Api.V_g.get({group: group})

      # We're checking what verbs are we look for
      $scope.verbs_chosen = $scope.verbs.split ","
      for verb in $scope.verbs_chosen
        $scope.verbs_db.push(Api.V_i.get({infinitive: verb}))

      $scope.verbs_excluded = $scope.excluded_verbs.split ","
      for verb in $scope.verbs_excluded
        v = Api.V_i.get({infinitive: verb})
        i = $scope.verbs_db.indexOf(v)
        $scope.verbs_db.splice(i, 1)

      if $scope.verbs_db.length > 0
        $scope.draw()
      else
        addError('You have to choose verbs. ')
    else
      addError('You have to specifie tenses. ')

  addError = (message) ->
    document.getElementById("error").innerHTML += message

  $scope.draw = ->
    $scope.verb = $scope.verbs_db[Math.floor(Math.random() * $scope.verbs_db.length)]
    $scope.tense = $scope.tenses_chosen[Math.floor(Math.random() * $scope.tenses_chosen.length)]
    $scope.form = forms[Math.floor(Math.random()* forms.length)]