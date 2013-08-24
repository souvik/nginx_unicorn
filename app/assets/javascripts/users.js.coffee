# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($) ->
    App.user = {} if typeof (App.user) is "undefined"

    App.user =
      init: ->
          @initSignupForm()

      initSignupForm: ->
          signupForm = $(".signup-form form")

          if signupForm.size() > 0
              signupSubmit = $("#signup-link a")
              signupForm.validationEngine("attach", {"focusFirstField" : false})
              signupSubmit.bind "click", (e) ->
                  e.preventDefault()
                  signupForm.submit()


    $(document).ready ->
        App.user.init()
) jQuery
