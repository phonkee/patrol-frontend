layout = angular.module 'patrol.layout'
layout.directive 'patrolTeamStatus', ()->
	restrict: 'E'
	scope: {
		"status": "="
	}

	template: """<span class="label label-success" ng-class="className">{{::label}}</span>"""
	replace: true
	controller: ($scope, $element, $attrs, $transclude) ->
		if $scope.status == 1
			$scope.className = "label-success"
			$scope.label = "Visible"
		else if $scope.status == 2
			$scope.className = "label-warning"
			$scope.label = "Pending deletion"
		else if $scope.status == 3
			$scope.className = "label-error"
			$scope.label = "deletion in progress"
