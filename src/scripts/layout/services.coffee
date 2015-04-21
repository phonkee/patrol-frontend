layout = angular.module "patrol.layout"
layout.factory 'LayoutService', ['$rootScope', ($rootScope) ->
    new class LayoutService
        setBodyClass: (bodyClass) ->
            $rootScope.bodyClass = bodyClass
        getBackground: (id) =>
            bgs = ['light-blue', 'aqua ', 'red', 'green', 'yellow']
            "bg-" + bgs[id % bgs.length]

        getBoxClassname: (id) =>
            "box-" + @getClassname(id)

        getClassname: (id) =>
            clss = ['primary', 'info', 'danger', 'success', 'warning']
            clss[id % clss.length]

        fix: () ->
            #Get window height and the wrapper height
            neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight()
            window_height = $(window).height()
            sidebar_height = $('.sidebar').height()
            #Set the min-height of the content and sidebar based on the
            #the height of the document.
            if $('body').hasClass('fixed')
                $('.content-wrapper, .right-side').css 'min-height', window_height - $('.main-footer').outerHeight()
            else
                if window_height >= sidebar_height
                    $('.content-wrapper, .right-side').css 'min-height', window_height - neg
                else
                    $('.content-wrapper, .right-side').css 'min-height', sidebar_height
            return
        fixSidebar: () ->
            #Make sure the body tag has the .fixed class
            if !$('body').hasClass('fixed')
                if typeof $.fn.slimScroll != 'undefined'
                    $('.sidebar').slimScroll(destroy: true).height 'auto'
                return
            else if typeof $.fn.slimScroll == 'undefined' and console
                console.error 'Error: the fixed layout requires the slimscroll plugin!'
            #Enable slimscroll for fixed layout
            # if $.AdminLTE.options.sidebarSlimScroll
            #     if typeof $.fn.slimScroll != 'undefined'
            #         #Distroy if it exists
            #         $('.sidebar').slimScroll(destroy: true).height 'auto'
            #         #Add slimscroll
            #         $('.sidebar').slimscroll
            #             height: $(window).height() - $('.main-header').height() + 'px'
            #             color: 'rgba(0,0,0,0.2)'
            #             size: '3px'
            return



]
