angular.module('patrol.layout').directive 'patrolIncludeReplace', () ->
    require: 'ngInclude',
    restrict: 'A',
    link: (scope, el, attrs) ->
        el.replaceWith(el.children())
