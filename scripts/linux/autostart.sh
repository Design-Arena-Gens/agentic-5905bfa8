#!/usr/bin/env bash
set -euo pipefail
# Ouvre Outlook Web et envoie un email via SMTP (script Python)
xdg-open "https://outlook.office.com/mail/" >/dev/null 2>&1 &
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
python3 "$SCRIPT_DIR/send_email.py" >/dev/null 2>&1 &
