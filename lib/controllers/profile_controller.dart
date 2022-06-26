import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:taurist/helpers/error_snackbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
      final uploadTask = ref.putFile(_imageFile);
      await auth.currentUser?.updatePhotoURL(
        'https://firebasestorage.googleapis.com/v0/b/taurist-f8f8f.appspot.com/o/${auth.currentUser?.uid}/profile.jpg?alt=media',
      );
      print(auth.currentUser);
    } catch (e) {
      ErrorSnackbar.errorSnackbar(e.toString());
    }
  }
}
