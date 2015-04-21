angular.module("patrol").config ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'patrol.admin-team-list',
        url: "/admin/team"
        controllerAs:"vm"
        data:
            title: 'Teams list'
            bodyClass: 'skin-blue'
        resolve:
            teams: ['TeamService', (TeamService) ->
                TeamService.getList()
            ]
        controller: "AdminTeamListController"
        templateUrl: "scripts/admin/views/teams.tpl.html"

    $stateProvider.state 'patrol.admin-project-list',
        url: "/admin/project"
        controllerAs:"vm"
        data:
            title: 'Projects list'
            bodyClass: 'skin-blue'
        resolve:
            teams: ['TeamService', (TeamService) ->
                TeamService.getList()
            ]
            metadata: ['ProjectService', (ProjectService) ->
                ProjectService.metadata()
            ]
        controller: "AdminProjectListController"
        templateUrl: "scripts/admin/views/projects.tpl.html"

    $stateProvider.state 'patrol.admin-user-list',
        url: "/admin/user?page"
        data:
            title: 'User list'
            bodyClass: 'skin-blue'
        resolve:
            users: (UserService, $stateParams) ->
                page = if $stateParams.page != "" then $stateParams.page else "1"
                UserService.getList({page: page})
        controller: "AdminUserListController"
        controllerAs:"vm"
        templateUrl: "scripts/admin/views/users.tpl.html"
