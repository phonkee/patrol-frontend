# auth service
app = angular.module "patrol"
app.factory 'AuthService', [
	'$http', '$q', '$rootScope', 'Restangular', 'AUTH_EVENTS', '$cookieStore',
	($http, $q, $rootScope, Restangular, AUTH_EVENTS, $cookieStore) ->
		new class AuthService
			# authentication token
			@token = ""

			# user information
			@user = {}

			constructor: ->
				@timestamp = Date.now()
				v = $cookieStore.get("X-Patrol-Token")
				if (v?)
					@setToken(v)
					@getUser()

			setToken: (@token) ->
				$cookieStore.put('X-Patrol-Token', @token)
				Restangular.setDefaultHeaders("Authorization": "Bearer " + @token )
				$http.defaults.headers.common['Authorization'] = "Bearer " + @token

			getUser: ->
				deferred = $q.defer()
				users = Restangular.all("auth").get("me").then (data) =>
					@user = data
					$rootScope.$broadcast AUTH_EVENTS.loginSuccess,
						user: data
					deferred.resolve(data)
				, (data) =>
					@token = ""
					@user = {}
					deferred.reject(data)

				deferred

			login: (username, password) ->
				data =
					username: username
					password: password
				deferred = $q.defer()

				$http.post('/api/auth/login', data).success((data, status, headers, config) =>
					if status == 200
						@setToken headers('X-Patrol-Token')
						@getUser()
						return deferred.resolve(data);
					else
						@setToken ""
						return deferred.reject(data);
				).error((data, status, headers, config) =>
					@setToken("")
					deferred.reject(data);
				)
				deferred.promise

			logout: =>
				$cookieStore.remove('X-Patrol-Token')
				@setToken ""
				$rootScope.$broadcast AUTH_EVENTS.logoutSuccess,
					user: @user
				@getUser()

]

