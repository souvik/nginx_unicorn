# Be sure to restart your server when you modify this file.

NginxUnicorn::Application.config.session_store :cookie_store, key: '_nginx_unicorn_session',
                                                              secure: true,
                                                              http_only: true
