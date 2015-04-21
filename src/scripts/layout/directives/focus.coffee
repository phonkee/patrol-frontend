angular.module('patrol.layout').directive 'ngFocus', ["$timeout", ($timeout) ->
	link: (scope, element, attrs) ->
		scope.$watch attrs.ngFocus, ((val) ->
			if angular.isDefined(val) and val
				$timeout ->
					element[0].focus()
					return
			return
		), true
		element.bind 'blur', ->
			if angular.isDefined(attrs.ngFocusLost)
				scope.$apply attrs.ngFocusLost
			return
		return
 ]
