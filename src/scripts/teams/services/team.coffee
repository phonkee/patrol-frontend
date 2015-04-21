projects = angular.module 'patrol.projects'
projects.factory 'TeamService', ($http, $q, Restangular, LayoutService) ->

    endpoint = 'teams/team/'

    Restangular.extendModel endpoint, (model) ->
        model.metadata = () ->
            model.options()
        return model

    new class TeamService
        getList: () ->

            promise = Restangular.all(endpoint).getList()

            # promise.then (list) ->
            #   angular.forEach list, (item) ->
            #       console.log item.metadata()

            return promise

        add: (team) ->
            Restangular.all(endpoint).post(team)

        metadata: ()->
        	# cannot get restangular options response so $http is used
        	# any help is apreciated
            deferred = $q.defer()
            req =
                method: 'OPTIONS'
                url: '/api/' + endpoint

            $http(req)
                .success((data) ->
                    deferred.resolve data
                ).error((data)->
                    deferred.reject data
                )

            deferred.promise
