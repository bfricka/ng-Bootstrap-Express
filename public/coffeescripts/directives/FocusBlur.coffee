app.directive 'ngBlur', ->
  (scope, elem, attrs) ->
    elem.on "blur", ->
      scope.$apply attrs.ngBlur
      return

app.directive 'ngFocus', ->
  (scope, elem, attrs) ->
    elem.on "focus", ->
      scope.$apply attrs.ngFocus
      return