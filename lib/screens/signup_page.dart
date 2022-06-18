import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:taurist/screens/utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isVisible = true;
  bool pass = true;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future singUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Utils.showSnackBar('this email is already used');
    }
    // final _isValid = formKey.currentState!.validate();
    // if (!_isVisible) return;
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(
    //           child: CircularProgressIndicator(),
    //         ));
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text.trim(),
    //       password: passwordController.text.trim());
    // } on FirebaseAuthException catch (e) {
    //   print(e);
    //   Utils.showSnackBar(e.message);
    // }
    // Utils.navigatorKey.currentState!.popUntil(ModalRoute.withName("/profile"));
    //Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     IconButton(
              //         onPressed: () {
              //           Navigator.pushNamed(
              //             context,
              //             '/',
              //           );
              //         },
              //         icon: Icon(Icons.close,
              //             color: Color.fromRGBO(44, 83, 72, 1)))
              //   ],
              // ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80, left: 30),
                    height: 36,
                    width: 300,
                    child: Text(
                      'Welcome To Taurist',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(44, 83, 72, 1),
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 3, left: 30),
                    height: 34,
                    width: 180,
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(44, 83, 72, 1),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3, left: 1),
                    height: 34,
                    width: 80,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName('/login'),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                              color: Color.fromRGBO(44, 83, 72, 1),
                              fontWeight: FontWeight.w900),
                        )),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 343,
                child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      //label: Text('Email'),
                      hintText: "Email",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontSize: 16),
                      border: OutlineInputBorder(
                          gapPadding: 4.0,
                          borderSide:
                              BorderSide(color: Color.fromRGBO(44, 83, 72, 1))),
                      suffixIcon: IconButton(
                        onPressed: emailController.clear,
                        icon: Icon(
                          Icons.clear,
                          color: Color.fromRGBO(189, 189, 189, 1),
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: 343,
                  child: TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: pass ? _isVisible : false,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1),
                              fontSize: 16),
                          border: OutlineInputBorder(),
                          suffixIcon: pass
                              ? IconButton(
                                  onPressed: /*passwordController.clear,*/ () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Color.fromRGBO(189, 189, 189, 1),
                                  ),
                                )
                              : null),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min 6 characters'
                          : null),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    /*gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  Color(0xff01cd8d),
                  Color(0xff93edc7),
                ],
              ),*/
                    color: Color.fromRGBO(44, 83, 72, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(130, 30)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: singUp,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /* ElevatedButton(
            onPressed: signIn,
            child: Text("SignIn"),
          ),*/
            ],
          ),
        ),
      )),
    );
  }
}
