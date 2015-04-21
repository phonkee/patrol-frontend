layout = angular.module 'patrol.layout'
layout.directive 'patrolHeader', ['AuthService', (AuthService) ->
	restrict: 'E'
	# require: ['^ngModel']
	scope: {}

	# priority: 0
	# replace: true
	# transclude: false
	templateUrl: 'scripts/layout/directives/partials/header.tpl.html'
	# compile: (tElement, tAttrs, transclude) ->
	#   ($scope, $element, $attrs, ctrls) ->

	# link: ($scope, $element, $attrs, ctrls) ->

	controller: ($scope, $element, $attrs, $transclude) ->
		$scope.user = AuthService.user
		$scope.logout = AuthService.logout
]
