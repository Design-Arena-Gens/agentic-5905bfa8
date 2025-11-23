#!/usr/bin/env python3
import os
import smtplib
from email.mime.text import MIMEText
from datetime import datetime

# Param?tres via variables d'environnement (recommand?)
# export EMAIL_USER="votre.email@exemple.com"
# export EMAIL_PASS="votre_mot_de_passe_ou_token_app"
# export RECIPIENT="votre.email@exemple.com"

EMAIL_USER = os.getenv("EMAIL_USER", "votre.email@exemple.com")
EMAIL_PASS = os.getenv("EMAIL_PASS", "")
RECIPIENT = os.getenv("RECIPIENT", EMAIL_USER)

SUBJECT = "D?marrage de l?ordinateur"
BODY = f"Cet ordinateur a d?marr? ? {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"

msg = MIMEText(BODY)
msg['Subject'] = SUBJECT
msg['From'] = EMAIL_USER
msg['To'] = RECIPIENT

# SMTP Microsoft 365 / Outlook.com
SMTP_HOST = os.getenv("SMTP_HOST", "smtp.office365.com")
SMTP_PORT = int(os.getenv("SMTP_PORT", "587"))

if not EMAIL_PASS:
    # ?viter d'?chouer bruyamment si non configur?
    raise SystemExit("EMAIL_PASS non d?fini. D?finissez EMAIL_USER/EMAIL_PASS/RECIPIENT en variables d'environnement.")

with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as server:
    server.starttls()
    server.login(EMAIL_USER, EMAIL_PASS)
    server.send_message(msg)
