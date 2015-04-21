# Auth controller
angular.module("patrol").controller "AdminTeamListController", (ModalService, teams, $state) ->
    vm = @
    vm.teams = teams
    vm.add = () ->
        ModalService.addTeam().then (team) ->
            vm.teams.unshift team

        return

    return
