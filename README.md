# Taurist - is the world's best app ever for the tourists!

In Taurist users have ability to publish routes they found interesting uploading .gpx files.
They can add descriptions and photos of places the route following.
Furthermore, users have their own customizable profiles.
At the final stage app is going to be self-monetized.

## List of features:
- 🏞 User can lead route with the help of interactive map
- 📝 Each user can add his own route with .gpx file
- 🌈 Customizable user profile! Each user can change name, email or password ad even put .gif as a profile image without premium subscription!
- 🌊 App have some animation inside (e.g. animated AppBar inside profile section)
- ☁️ Reliable cloud storage provided by Firebase Google.inc (c)
- 🐣 GetX architecture inside :)
- 🙊 App successfully builds for Android, iOS devices and [Web](https://tauristapp-74b3f.firebaseapp.com/#/startPage)


##  ❓ How to build

1. Install and setup Dart SDK.

2. Install and retrieve Flutter SDK :

   2.1 Download from this link : [docs.flutter.dev](https://docs.flutter.dev/get-started/install)

   2.2 1. Extract the zip file and place the contained `flutter` in the desired installation
   location for the Flutter SDK.

3. Install Android Studio / VSCode and then install Flutter package.

4. Set up the Android emulator.

5. Git Clone the project or download the source code.

6. To create a new Flutter project containing existing Flutter source code files:

   6.1 In the IDE, `Create New Project` from the `Welcome` window or `File > New > Project`
   from the main IDE window.

   6.2. Select `Flutter` in the menu, and click `Next`.

   6.3. Under `Project location` enter, or browse to, the directory holding your existing
   Flutter source code files.

   6.4. Click `Finish`.

7. Run application

   7.1. Open terminal

   7.2. Build an APK using `flutter build apk --release --split-per-abi`

   7.3. Install APK using command `flutter install` or manually using APK file

## 📱 List of screens

### Login page
This page allows users who already have an account to log in. \
To log in, you must enter your email address and password. If the password is incorrect, the user will receive a message. If the user has not yet created an account or needs to change their password, they have the option to go to the appropriate application pages

### Registration page
On this page the user is registered. To do this, enter the email to which the account is linked and come up with a password. \
If the mail specified by the user is already in the database, the user will receive an error message

### Change password page
On this page the user can change the password by specifying the mail to which the message requesting the password change will be sent

### Routes page
This page is made for user to choose the appropriate route. It displays the icon corresponding to type of activity necessary for that route, the name, average time, distance and small description. Then, if you press on one of the routes you will be redirected to another screen containing more useful information about the path.

### Route description page
This page of our application contains more precise information about the route. Those are all the parameters from previous screen and additionally the embedded map. In future there is going to be photos, comments and rates of the route

### New route page
This page is made for user to create new routes themselves. It contains all the interface for creation what will be seen afterwards in concrete route page.

### Profile page
On this page users can manage routes they created, delete them

### Profile settings page
This page is made for user to change avatar, name, password and email of your account

## Related images

|        Settings         |       Routes creation       |    Routes Description     |
|:-----------------------:|:---------------------------:|:-------------------------:|
| ![](/pics/settings.png) | ![](/pics/create_route.png) | ![](/pics/route_desc.png) |

## Video Demo
[![Watch the FULL](/pics/flutter.gif)](https://youtu.be/CmLsV86mvCI)

(c) 4Tune