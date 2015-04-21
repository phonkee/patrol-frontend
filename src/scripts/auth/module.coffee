angular.module("patrol").constant('AUTH_EVENTS',
	loginSuccess: 'auth-login-success'
	loginFailed: 'auth-login-failed'
	logoutSuccess: 'auth-logout-success'
	sessionTimeout: 'auth-session-timeout'
	notAuthenticated: 'auth-not-authenticated'
	notAuthorized: 'auth-not-authorized'
)


angular.module("patrol").config ["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->
	$stateProvider.state 'login',
		url: "/login"
		controllerAs:"loginController"
		data:
			title: 'Login'
			bodyClass: 'login-page'
		controller: "LoginController"
		templateUrl: "scripts/auth/views/login.tpl.html"
]


angular.module("patrol").run ["Restangular", "$rootScope", "AUTH_EVENTS", "$state",  'LoaderService', (Restangular, $rootScope, AUTH_EVENTS, $state, LoaderService) ->
	# Here comes response interceptor for restangular.
	# all unauthorized requests should be vetoed and redirected to login page
	# useful with error messages
	Restangular.setErrorInterceptor (response, deferred, responseHandler) ->
		LoaderService.remove response.config.url
		if response.status == 401
			# add message
			$rootScope.$broadcast AUTH_EVENTS.notAuthorized
			$state.transitionTo "login",
				reload: true
			return false
		true
]
