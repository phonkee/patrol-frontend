angular.module('patrol.widgets')
	.controller 'ModalAddProjectController', ($modalInstance, ProjectService, teams) ->
		vm = @
		vm.error = {}
		vm.project = {}
		vm.teams = teams
		vm.ok = () ->
			ProjectService.add(vm.project).then (project) ->
				vm.error = {}
				$modalInstance.close project
			, then(result) ->
				vm.error = result.data.error

		vm.cancel = () ->
			$modalInstance.dismiss('cancel')

		return
