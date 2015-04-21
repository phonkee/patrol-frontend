angular.module('patrol.widgets')
    .controller 'ModalAddTeamController', ($modalInstance, TeamService) ->
        vm = @
        vm.error = {}
        vm.team = {}
        vm.submit = () ->
            TeamService.add(vm.team).then (team) ->
                vm.error = {}
                $modalInstance.close team
            , (result) ->
                vm.error = result.data.error

        vm.reset = () ->
            $modalInstance.dismiss('cancel')

        return
