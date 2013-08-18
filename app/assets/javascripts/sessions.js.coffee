# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($) ->
    App.Session = {}  if typeof (App.Session) is "undefined"

    App.Session =
        init: ->
          @initLoginForm()

        initLoginForm: ->
            loginForm = $(".login-form form")

            if loginForm.size() > 0
                submitLink = loginForm.find("#login-link a")
                loginForm.find("input[type=text]").first().focus()
                loginForm.validationEngine()
                submitLink.bind "click", (e) ->
                    e.preventDefault()
                    loginForm.submit()


    $(document).ready ->
        App.Session.init()

) jQuery
