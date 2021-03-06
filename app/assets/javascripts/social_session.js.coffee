(($) ->
  App.SocialSession = {} if typeof (App.SocialSession) is "undefined"

  App.SocialSession =
    init: ->
      @initFBAuth()
      @initGooglePlusAuth()

    initFBAuth: ->
      $('body').prepend('<div id="fb-root"></div>')
      FBLink = $(".social-signin a#connect-fb")
      if FBLink.size() > 0
        $.ajax
          url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
          dataType: "script"
          cache: true

        FBLink.bind "click", (e) ->
          e.preventDefault()
          FB.init
            appId: FBLink.attr("data-app-id")
            cookie: false

          FB.login (response) ->
            if response.authResponse
              FB.api "/me", (response) ->
                fbUserParams =
                  fb_session:
                    identifier: response.id
                    first_name: response.first_name
                    last_name: response.last_name
                    username: response.username
                    email: response.email
                    location: response.location.name
                    verified: response.verified

                $.ajax
                  url: "/create"
                  type: "POST"
                  data: fbUserParams
                  success: (response) ->
                    window.location.assign(response.redirect_url) unless response.redirect_url is "undefined"

            else
              console.log 'Connection Closed'

    googleSigninCallback: (authResult) ->
      token = gapi.auth.getToken()
      accessToken = token.access_token

    initGooglePlusAuth: ->
      googlePlusLink = $(".social-signin a#connect-gplus")
      defaultOptions =
        clientid: googlePlusLink.attr("data-clientid")
        cookiepolicy: googlePlusLink.attr("data-cookiepolicy")
        requestvisibleactions: googlePlusLink.attr("data-requestvisibleactions")
        scope: googlePlusLink.attr("data-scope")

      if googlePlusLink.size() > 0
        $.ajax
          url: "#{window.location.protocol}//apis.google.com/js/client:plusone.js"
          dataType: "script"
          cache: true
          success: ->
            googlePlusLink.bind "click", (e) ->
              e.preventDefault()
              gapi.auth.signIn $.extend(defaultOptions,
                callback: @googleSigninCallback
              )


  $(document).ready ->
    App.SocialSession.init()
) jQuery
