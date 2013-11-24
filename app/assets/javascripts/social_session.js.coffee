(($) ->
    App.SocialSession = {} if typeof (App.SocialSession) is "undefined"

    App.SocialSession =
        init: ->
            @initFBAuth()
            #@initTwitterAuth()
            #@initYahooAuth()

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
                        console.log 'Logged In'
                        console.log response
                        FB.api "/me", (response) ->
                            console.log response
                            fbUserParams =
                               fb_session:
                                   id: response.id
                                   first_name: response.first_name
                                   last_name: response.last_name
                                   username: response.username
                                   location: response.location.name
                                   verified: response.verified

                            $.ajax
                                url: "/create"
                                type: "POST"
                                data: fbUserParams
                    else
                        console.log 'Connection Closed'


    $(document).ready ->
        App.SocialSession.init()
) jQuery
