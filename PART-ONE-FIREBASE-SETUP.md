# MSA FBLA Part One Setup

## Completed in code

- Firebase project: `msa-fbla-app`
- Email/password authentication enabled
- Firestore database created
- Web app registered
- App signup and login use Firebase Authentication
- Member profiles and calendar selections use Firestore
- Firestore rules and Firebase project binding are included in this folder

## Finish the coordinator account

1. Open Firebase Console > Authentication > Users.
2. Click **Add user**.
3. Create the coordinator email and password. Keep the password private.
4. Copy the new user's **User UID**.
5. Open Firestore Database > Data.
6. Create or open the `users` collection.
7. Create a document whose ID is the coordinator User UID.
8. Add these fields:

```text
fullName: Karissa Forlenza
email: coordinator email
username: karissa
usernameLower: karissa
role: coordinator
calendarEvents: {}
```

9. Open Firestore Database > Rules and publish `firestore.rules`.

The coordinator app login requires the Firebase email/password plus:

```text
MSAFBLACOORDINATOR2026!
```

## Deploy rules with Firebase CLI

From this folder, if Firebase CLI is installed:

```text
firebase login
firebase use msa-fbla-app
firebase deploy --only firestore:rules
```

Never put a Firebase service-account private key or a user's password in the website files.
