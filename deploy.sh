#!/bin/bash
# Deploy discs.baselinetech.ie (static PWA) to the VPS. Only touches /var/www/trophy-disc-printer.
set -euo pipefail

VPS="root@46.224.45.201"
REMOTE="/var/www/trophy-disc-printer"
LOCAL="$(cd "$(dirname "$0")" && pwd)"
HOST="discs.baselinetech.ie"

echo "🚀 Deploying $HOST -> $VPS:$REMOTE"
ssh "$VPS" "mkdir -p $REMOTE"

rsync -az --delete \
  --exclude='.git' \
  --exclude='deploy.sh' \
  --exclude='nginx-discs.conf' \
  --exclude='README.md' \
  --exclude='.nojekyll' \
  "$LOCAL/" "$VPS:$REMOTE/"

if ! ssh "$VPS" "test -f /etc/nginx/sites-available/trophy-disc-printer"; then
  echo "📄 Installing nginx site (first deploy) and requesting the certificate..."
  scp "$LOCAL/nginx-discs.conf" "$VPS:/etc/nginx/sites-available/trophy-disc-printer"
  ssh "$VPS" "ln -sf /etc/nginx/sites-available/trophy-disc-printer /etc/nginx/sites-enabled/trophy-disc-printer && nginx -t && systemctl reload nginx"
  ssh "$VPS" "certbot --nginx -d $HOST --non-interactive --agree-tos --register-unsafely-without-email --redirect || certbot --nginx -d $HOST --non-interactive --redirect"
else
  ssh "$VPS" "nginx -t && systemctl reload nginx"
fi

echo "✅ Live: https://$HOST"
