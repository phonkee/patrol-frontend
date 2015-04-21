angular
	.module('patrol.widgets')
	.directive 'patrolEventgroups', [() ->
		restrict: 'E'
		scope: {
			eventgroups: "="
		}
		replace: true
		templateUrl : 'scripts/events/directives/partials/eventgroups.tpl.html'
		controllerAs: 'vm'
		bindToController: true

		controller: ($scope, $element, $attrs, $transclude) ->
			return
]
