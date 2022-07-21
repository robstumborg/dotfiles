python /home/rj1/.config/email/oauth/oauth2.py \
    --client_id="$(pass meta -a $1 'oauth_client_id')" \
    --client_secret="$(pass meta -a $1 'oauth_client_secret')" \
    --refresh_token="$(pass meta -a $1 'oauth_refresh_token')" \
    --quiet
