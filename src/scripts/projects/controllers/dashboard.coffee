projects = angular.module "patrol.projects"

# Dashboard controller
projects.controller "ProjectDashboardController", ($log, $scope, $location, LayoutService, project, projectkeys, eventGroups, RealtimeService) ->
	vm = @
	vm.project = project
	vm.projectkeys = projectkeys
	vm.host = $location.host()
	vm.eventGroups = eventGroups
	$scope.getBoxClassname = LayoutService.getBoxClassname

	vm.messagefn = (message) =>
		vm.project.name = vm.project.name
		$scope.$apply()

	RealtimeService.subscribe vm.messagefn

	$scope.$on "$destroy", () =>
		RealtimeService.unsubscribe vm.messagefn

	return
