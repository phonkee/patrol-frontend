# Auth controller
angular.module("patrol").controller "LoginController", ["$scope", "$state", "AuthService", ($scope, $state, AuthService) ->
	$scope.credentials =
		username: ""
		password: ""
	$scope.login = ->
		AuthService.login(
			$scope.credentials.username,
			$scope.credentials.password)
		.then (data) ->
			$state.transitionTo "patrol.dashboard",
				reload: true
		, (data) ->
			null
	return
]
