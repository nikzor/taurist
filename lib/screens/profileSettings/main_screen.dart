import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taurist/controllers/authorization_controller.dart';
import 'package:taurist/controllers/profile_controller.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final user = AuthorizationController.instance.auth.currentUser;
  final profile = Get.put(ProfileController());
  bool showPassword = false;
  bool isLoading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void updateUserInfo() async {
    if (nameController.text.trim() == "" &&
        emailController.text.trim() == "" &&
        passwordController.text.trim() == "") {
      const snackBar = SnackBar(
        content: Text('Nothing changes!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        isLoading = true;
      });
      profile.updateUserInfo(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateUserPhoto() async {
    setState(() {
      isLoading = true;
    });
    profile.updateProfilePicture();
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
    });
  }

  void cancel() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    strokeWidth: 6.0,
                    color: Color.fromRGBO(44, 83, 72, 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A bit of magic happens here :)",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromRGBO(44, 83, 72, 1),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () => profile.logout(),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: ListView(
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Obx(
                          () => Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(profile.userPhoto.value),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(44, 83, 72, 1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                profile.updateProfilePicture();
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Obx(
                    () => buildTextField(
                        'User Name',
                        profile.userName.value ?? 'Default name',
                        false,
                        nameController),
                  ),
                  Obx(
                    () => buildTextField(
                        'Email',
                        profile.userEmail.value ?? 'Default email',
                        false,
                        emailController),
                  ),
                  buildTextField(
                    'Password',
                    '',
                    true,
                    passwordController,
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          primary: const Color.fromRGBO(44, 83, 72, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () => cancel(),
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => updateUserInfo(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          primary: const Color.fromRGBO(44, 83, 72, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  Widget buildTextField(String labelText, String placeHolder, bool isPassword,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? showPassword : false,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF49454F)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF49454F)),
            ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color.fromRGBO(189, 189, 189, 1),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, color: Color(0xFF49454F)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: isPassword ? '******' : placeHolder,
          hintStyle: const TextStyle(fontSize: 16,),
        ),
      ),
    );
  }
}
