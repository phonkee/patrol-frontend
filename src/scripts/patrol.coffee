# Patrol application
# @author phonkee <phonkee@phonkee.eu>

patrol = angular.module 'patrol', ['ui.router', 'ui.bootstrap', 'restangular', 'ngCookies', 'angular-websocket', 'patrol.widgets', 'patrol.layout', 'patrol.dashboard', 'patrol.events', 'patrol.projects', 'patrol.realtime']
patrol.constant '_', _
patrol.config ["RestangularProvider", "$urlRouterProvider", "$stateProvider", (RestangularProvider, $urlRouterProvider, $stateProvider) ->
    RestangularProvider.setBaseUrl "/api"
    $urlRouterProvider.otherwise '/login'

    # RestangularProvider.setRequestSuffix('/');
    RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
        result = data['result']
        # add paging to getList operation
        if operation == "getList" && data['paging']
            result.paging = data['paging']
        result

    $stateProvider.state 'patrol',
        abstract: true
        template: '<ui-view />'
        resolve:
            projects: ['ProjectService', (ProjectService) ->
                ProjectService.getList()
            ]
            version: ['Restangular', (Restangular) ->
                Restangular.one('version').get()
            ]
        controller: ["projects", "version", "$scope", "$rootScope", "RealtimeService", (projects, version, $scope, $rootScope, RealtimeService) ->
            $scope.projects = projects
            @version = version.version
            RealtimeService.init()
            $scope.$on("$destroy", () ->
                RealtimeService.close()
            )
            return
        ]
        controllerAs: "PatrolController"
]

angular.module("patrol").constant('AUTH_EVENTS',
    loginSuccess: 'auth-login-success'
    loginFailed: 'auth-login-failed'
    logoutSuccess: 'auth-logout-success'
    sessionTimeout: 'auth-session-timeout'
    notAuthenticated: 'auth-not-authenticated'
    notAuthorized: 'auth-not-authorized'
)

patrol.run ($rootScope, $timeout, $window, Restangular, AuthService, LayoutService) ->

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
        $rootScope.title = toState.data.title
        $rootScope.bodyClass = LayoutService.setBodyClass(toState.data.bodyClass)

    $(window, '.wrapper').resize =>
        LayoutService.fix()
        LayoutService.fixSidebar()

    $(window, '.wrapper').resize()

    $rootScope.$on '$viewContentLoaded', (event) ->
        # Hack
        $timeout () ->
            LayoutService.fix()
            LayoutService.fixSidebar()

