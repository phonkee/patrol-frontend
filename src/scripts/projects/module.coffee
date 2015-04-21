projects = angular.module 'patrol.projects', ['patrol.events', 'patrol.realtime']
projects.config ["$stateProvider", "$urlRouterProvider", ($stateProvider, $urlRouterProvider) ->

    $stateProvider.state 'patrol.project',
        abstract: true
        url: "/project/{project_id:int}"
        data:
            title: 'Project'
            bodyClass: 'skin-blue'
        resolve:
            project: (ProjectService, $stateParams) ->
                ProjectService.get($stateParams.project_id)
            projectkeys: (ProjectService, $stateParams) ->
                ProjectService.getKeys($stateParams.project_id)
            eventGroups: (EventGroupService, $stateParams) ->
                EventGroupService.getList($stateParams.project_id)
        template: '<ui-view />'

    $stateProvider.state 'patrol.project.dashboard',
        # abstract: true
        url: "/dashboard"
        data:
            title: 'Project'
            bodyClass: 'skin-blue'
        controller: "ProjectDashboardController"
        controllerAs: 'vm'
        templateUrl: "scripts/projects/views/dashboard.tpl.html"

    $stateProvider.state 'patrol.project.eventgroups',
        url: "/eventgroup"
        data:
            title: 'Project events'
            bodyClass: 'skin-blue'
        controller: "ProjectEventGroupsController"
        controllerAs: 'vm'
        templateUrl: "scripts/projects/views/eventgroup.list.tpl.html"
]
