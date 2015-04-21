angular.module('patrol.widgets')
    .factory 'ModalService', ($modal, $q, TeamService) ->
        new class ModalService
            addUser: (size) ->
                size?="sm"
                $modal.open
                    templateUrl: "scripts/widgets/partials/modal_user_add.tpl.html"
                    controller: "ModalAddUserController as vm"
                    size: size

            addProject: (size) ->
                size?="xl"
                # deferred = $q.defer()
                # deferred.promise
                $modal.open
                    templateUrl: "scripts/widgets/partials/modal_project_add.tpl.html"
                    controller: "ModalAddProjectController as vm"
                    size: size
                    resolve:
                        teams: () ->
                            TeamService.getList()

            addTeam: (size) ->
                size?="sm"

                deferred = $q.defer()

                TeamService.metadata().then (data) ->
                    if !data.actions.POST
                        deferred.reject
                            message: "unauthorized"
                        return

                    modal = $modal.open
                        size: size
                        templateUrl: "scripts/widgets/partials/modal_team_add.tpl.html"
                        controller: "ModalAddTeamController as vm"

                    modal.result.then (team) ->
                        deferred.resolve team
                    , (error) ->
                        deferred.reject error
                , (error) ->
                    deferred.reject error.message

                deferred.promise
