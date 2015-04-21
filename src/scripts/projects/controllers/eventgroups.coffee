projects = angular.module "patrol.projects"

# Dashboard controller
projects.controller "ProjectEventGroupsController", ['$scope', 'LayoutService', 'project', 'eventGroups', ($scope, LayoutService, project, eventGroups) ->
    @project = project
    @eventGroups = eventGroups
    $scope.getBoxClassname = LayoutService.getBoxClassname
    return
]


