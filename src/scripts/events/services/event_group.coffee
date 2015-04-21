angular
	.module('patrol.events')
	.factory 'EventGroupService', ['Restangular', (Restangular) ->
		new class EventGroupService
			getList: (projectId, data) ->
				Restangular.one('projects/project', projectId).all('eventgroup').getList()
]
