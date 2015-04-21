projects = angular.module 'patrol.projects'
projects.factory 'ProjectService', (Restangular, LayoutService, $http, $q, $modal) ->

    new class ProjectService
        getList: (data) ->
            Restangular.all('projects/project/').getList(data)

        get: (projectId) ->
            Restangular.all('projects/project/').get(projectId)

        metadata: () ->
            deferred = $q.defer()
            req =
                method: 'OPTIONS'
                url: '/api/projects/project/'

            $http(req)
                .success((data) ->
                    deferred.resolve data
                ).error((data)->
                    deferred.reject data
                )

            deferred.promise

        add: (project) ->
            return Restangular.all('projects/project/').post(project)

        getKeys: (projectId) ->
            Restangular.one('projects/project/', projectId).all('key').getList()

