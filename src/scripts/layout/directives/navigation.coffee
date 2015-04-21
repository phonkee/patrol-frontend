layout = angular.module 'patrol.layout'
layout.directive 'patrolNavigation', ["AuthService", "$state", (AuthService, $state) ->
    restrict: 'E'
    # require: ['^projects']
    scope: {
        "projects": "="
    }
    # priority: 0
    replace: true
    # transclude: false
    templateUrl: 'scripts/layout/directives/partials/navigation.tpl.html'
    # compile: (tElement, tAttrs, transclude) ->
    #   ($scope, $element, $attrs, ctrls) ->
    link: ($scope, $element, $attrs, ctrls) ->
        $('li a', $($element)).click (e) ->
            #Get the clicked link and the next element
            $this = $(this)
            checkElement = $this.next()
            #Check if the next element is a menu and is visible
            if checkElement.is('.treeview-menu') and checkElement.is(':visible')
                #Close the menu
                checkElement.slideUp 'normal', ->
                    checkElement.removeClass 'menu-open'
                    return
                checkElement.parent('li').removeClass 'active'
            else if checkElement.is('.treeview-menu') and !checkElement.is(':visible')
                #Get the parent menu
                parent = $this.parents('ul').first()
                #Close all open menus within the parent
                ul = parent.find('ul:visible').slideUp('normal')
                #Remove the menu-open class from the parent
                ul.removeClass 'menu-open'
                #Get the parent li
                parent_li = $this.parent('li')
                #Open the target menu and add the menu-open class
                checkElement.slideDown 'normal', ->
                    #Add the class active to the parent li
                    checkElement.addClass 'menu-open'
                    parent.find('li.active').removeClass 'active'
                    parent_li.addClass 'active'
                    return
            #if this isn't a link, prevent the page from being redirected
            if checkElement.is('.treeview-menu')
                e.preventDefault()
            return
        return

    controllerAs: "vm"
    controller: ["$scope", "$element", "$attrs", "$transclude", "$state", ($scope, $element, $attrs, $transclude, $state) ->
        vm = @

        vm.currentName = $state.current.name

        $scope.user = AuthService.user
        $scope.isAdmin = false
        vm.InState = (name) ->
            $state.name == name
        $scope.current = $state.current
        if $state.current.name.indexOf("patrol.admin") == 0
            $scope.isAdmin = true
    ]
]
