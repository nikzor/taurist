import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:taurist/helpers/error_snackbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:taurist/routes.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  late File _imageFile;
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
  }

  // change firebase user name
  void changeUserName(String name) async {
    try {
      await auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  // change firebase user email
  void changeUserEmail(String email) async {
    try {
      await auth.currentUser?.updateEmail(email);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  // change firebase user password
  void changeUserPassword(String password) async {
    try {
      await auth.currentUser?.updatePassword(password);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  // update firebase user profile picture
  void updateProfilePicture() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
      final ref = storage.ref().child('${auth.currentUser?.uid}/profile.jpg');
      ref.putFile(_imageFile);
      await auth.currentUser?.updatePhotoURL(
        'https://firebasestorage.googleapis.com/v0/b/taurist-f8f8f.appspot.com/o/${auth.currentUser?.uid}/profile.jpg?alt=media',
      );
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }

  // get firebase user name
  String getUserName() {
    if (auth.currentUser?.displayName == null ||
        auth.currentUser?.displayName == "") {
      return "Default name";
    }
    return auth.currentUser?.displayName ?? 'Default name';
  }
  // get firebase user profile picture
  String getUserPhoto() {
    final url = auth.currentUser?.photoURL;
    if (url == null) {
      return 'https://cdn.gifka.com/public/thumbs/large/7/7127.gif';
    } else {
      return 'https://firebasestorage.googleapis.com/v0/b/tauristapp-74b3f.appspot.com/o/${auth.currentUser?.uid}%2Fprofile.jpg?alt=media';
    }
  }

  // log out firebase user
  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.startPage);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }
}
