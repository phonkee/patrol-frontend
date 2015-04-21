angular.module("patrol").controller "AdminUserListController", ($modal, users, ModalService) ->
    vm = @
    vm.users = users

    vm.addUser = (size) ->
        ModalService.addUser().result.then (user) ->
            vm.users.unshift user
        return

    return
