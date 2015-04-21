# Project list controller
angular.module("patrol").controller "AdminProjectListController", (projects, metadata, ModalService) ->
    vm = @
    vm.projects = projects
    vm.metadata = metadata

    vm.add = (size) ->
        ModalService.addProject().result.then (project) ->
            vm.projects.unshift project
        return

    return

