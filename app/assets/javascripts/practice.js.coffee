app = angular.module('Verb', ["ngResource"])

app.factory "Api", ["$resource", ($resource) ->
  V_i: $resource("/by_infinitive/:infinitive",
    infinitive: "@infinitive"
  )
  V_g: $resource("/by_group/:group",{
        group: "@group"}, { get:  {method:'GET', isArray:true}}
  )
  Ans: $resource("/check_form/:verb_id/:tense/:form.json",
    verb_id: "@verb_id"
    tense: "@tense"
    form: "@form"
  )
]

@PracticeCtrl = ($scope, Api) ->

  tenses = ['Present', 'Imparfait', 'PasseCompose', 'PasseSimple', 'PlusQueParfait', 'FuturSimple', 'Subjonctif']
  groups = [1, 2, 3]
  forms = ['je', 'tu', 'il', 'nous', 'vous', 'ils']

  $scope.set = ->
    $scope.verbs_db = []
    $scope.verbs_db2 = []
    $scope.tenses_chosen = []
    $scope.groups_chosen = []
    $scope.answers = []
    for tense in tenses
      if $scope.tenses[tense]
        $scope.tenses_chosen.push(tense)

    if $scope.tenses_chosen.length > 0

      for g in groups
        if $scope.groups[g]
          Api.V_g.get({group: g}, (success) ->
            $scope.verbs_db2 = $scope.verbs_db
            $scope.verbs_db = $scope.verbs_db2.concat(success)
            if $scope.verbs
              $scope.verbs_chosen = $scope.verbs.split ","
              for verb in $scope.verbs_chosen
                $scope.verbs_db.push(Api.V_i.get({infinitive: verb}))
            if $scope.excluded_verbs
              $scope.verbs_excluded = $scope.excluded_verbs.split ","
              for verb in $scope.verbs_excluded
                v = Api.V_i.get({infinitive: verb})
                i = $scope.verbs_db.indexOf(v)
                $scope.verbs_db.splice(i, 1)

            if $scope.verbs_db.length > 0
              $scope.draw()
              answer = document.getElementById('answer_form')
              answer.setAttribute 'class', 'row show'
            else
              addError('You have to choose verbs. ')
          )


    else
      addError('You have to specifie tenses. ')

  addError = (message) ->
    document.getElementById("error").innerHTML += message

  $scope.draw = ->
    $scope.verb = $scope.verbs_db[Math.floor(Math.random() * $scope.verbs_db.length)]
    $scope.tense = $scope.tenses_chosen[Math.floor(Math.random() * $scope.tenses_chosen.length)]
    $scope.form = forms[Math.floor(Math.random()* forms.length)]

  $scope.check = ->
    $scope.correct_ans = Api.Ans.get({verb_id: $scope.verb.id, tense: $scope.tense, form: $scope.form}, (success) ->
      $scope.correct = success.f
      $scope.answers.push {infinitive: $scope.verb.infinitive, tense: $scope.tense, form: $scope.form, user_ans: $scope.answer, correct_ans: $scope.correct}
    )