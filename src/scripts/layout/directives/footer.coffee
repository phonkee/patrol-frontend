angular
	.module('patrol.layout')
	.directive 'patrolFooter', ['AuthService', (AuthService) ->
		restrict: 'E'
		scope: {
			controller: "="
		}
		replace: true
		templateUrl: 'scripts/layout/directives/partials/footer.tpl.html'
		controller: ($scope, $element, $attrs, $transclude) ->
			$scope.user = AuthService.user
			$scope.logout = AuthService.logout
			$scope.version = $scope.controller.version
]
