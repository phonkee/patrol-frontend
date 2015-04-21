angular
	.module('patrol.widgets')
	.directive 'patrolLoader', ['LoaderService', (LoaderService) ->
		restrict: 'E'
		scope: {
			controller: "="
		}
		replace: true
		template: '<i ng-show="urls.length" class="fa fa-refresh fa-spin"></i>'
		controllerAs: 'vm'
		bindToController: true

		controller: ($scope, $element, $attrs, $transclude) ->
			$scope.urls = LoaderService.urls
			return
]
