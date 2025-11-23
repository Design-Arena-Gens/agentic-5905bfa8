-- Ouvre Microsoft Outlook et envoie un email
-- Remplacez l'adresse par la v?tre

activate application "Microsoft Outlook"
delay 5

tell application "Microsoft Outlook"
  set newMessage to make new outgoing message with properties {subject:"D?marrage de l?ordinateur", content:"Cet ordinateur a d?marr? ? " & ((current date) as string)}
  make new recipient at newMessage with properties {email address:{address:"votre.email@exemple.com"}}
  send newMessage
end tell
