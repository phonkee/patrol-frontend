projects = angular.module 'patrol.widgets'
projects.factory 'LoaderService', (Restangular, _) ->
    new class LoaderService
        init: () ->
            @urls = []
            Restangular.addRequestInterceptor (element, operation, what, url) =>
                @urls.push url
                element
            Restangular.addResponseInterceptor (data, operation, what, url, response, deferred) =>
                @remove(url)
                data
            # add interceptor for $http

        remove: (url) ->
            index = _.indexOf @urls, url
            @urls.splice index, 1

