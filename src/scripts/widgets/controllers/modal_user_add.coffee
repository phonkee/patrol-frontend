angular.module('patrol.widgets')
    .controller 'ModalAddUserController', ($modalInstance, UserService) ->
        vm = @
        vm.user = {
            is_active: true
        }
        vm.error = {}
        vm.ok = () ->
            UserService.add(vm.user).then (user) ->
                vm.error = {}
                $modalInstance.close user
            , then(result) ->
                vm.error = result.data.error

        vm.cancel = () ->
            $modalInstance.dismiss('cancel')

        return
