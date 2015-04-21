angular
	.module('patrol.widgets')
	.directive 'patrolEventgroup', [() ->
		restrict: 'E'
		scope: {
			eventgroup: "="
			eventgroupType: "="
		}
		replace: true

		templateUrl: (elm, attrs) ->
			'scripts/events/directives/partials/eventgroup.tpl.html'

		controllerAs: 'vm'
		bindToController: true

		controller: ($scope, $element, $attrs, $transclude) ->
			vm = @
			# returns template for type (ng-include)
			vm.getTemplate = (eg) ->
				type = eg.data.interfaces[0].id
				if !type
					type = "generic"
				'scripts/events/directives/partials/types/' + type + '.tpl.html'

]
