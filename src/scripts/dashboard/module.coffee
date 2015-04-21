dashboard = angular.module 'patrol.dashboard', ['patrol.projects']
dashboard.config ["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
	$stateProvider.state 'patrol.dashboard',
		url: "/dashboard"
		data:
			title: 'Dashboard'
			bodyClass: 'skin-blue'
		controller: "DashboardController"
		controllerAs: "vm"
		templateUrl: "scripts/dashboard/views/dashboard.tpl.html"
		resolve:
			metadata: ['ProjectService', (ProjectService) ->
				ProjectService.metadata()
			]

]
