python /home/rj1/.config/email/oauth/oauth2.py \
    --client_id="$(pass meta -a $1 'oauth_client_id')" \
    --client_secret="$(pass meta -a $1 'oauth_client_secret')" \
    --generate_oauth2_token

