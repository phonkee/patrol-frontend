# user service

angular.module("patrol").factory 'UserService', (Restangular) ->
	new class UserService

		# add user
		add: (user) ->
			Restangular.all('auth/user/').post(user)

		# return list of users
		getList: (data) ->
			Restangular.all('auth/user/').getList(data)
