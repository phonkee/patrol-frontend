# Dashboard controller
angular.module("patrol").controller "DashboardController", ($scope, LayoutService, ModalService, projects, metadata) ->
    $scope.projects = projects
    $scope.getBoxClassname = LayoutService.getBoxClassname
    @metadata = metadata

    @add = (size) ->
        ModalService.addProject()
        return


    return

