widgets = angular.module('patrol.widgets', ['restangular'])
widgets.run ["LoaderService", (LoaderService) ->
	# init loader service
	LoaderService.init()
]
