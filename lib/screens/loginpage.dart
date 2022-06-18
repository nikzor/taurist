import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taurist/screens/profilescreen.dart';
import 'package:taurist/screens/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ProfileScreen();
          } else {
            return signInWidget();
          }
        },
      ),
    );
  }
}

class signInWidget extends StatefulWidget {
  const signInWidget({Key? key}) : super(key: key);

  @override
  State<signInWidget> createState() => _signInWidgetState();
}

class _signInWidgetState extends State<signInWidget> {
  bool _isVisible = true;
  bool pass = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackBar('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar('Wrong password provided.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            // Row(mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     IconButton(onPressed: (){Navigator.pushNamed(
            //       context, '/',);}, icon: Icon(Icons.close,  color: Color.fromRGBO(44, 83, 72,1)))
            //   ],
            // ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80, left: 30),
                  height: 36,
                  width: 300,
                  child: Text(
                    'Welcome Back',
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
                  width: 110,
                  child: Text(
                    'New to the app?',
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
                        Navigator.pushNamed(
                          context,
                          '/signin',
                        );
                      },
                      child: Text(
                        'Sign up',
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
              child: TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(189, 189, 189, 1), fontSize: 16),
                  border: OutlineInputBorder(
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
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 343,
              child: TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                obscureText: pass ? _isVisible : false,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(189, 189, 189, 1), fontSize: 16),
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
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/forgot',
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(189, 189, 189, 1),
                    textStyle:
                        const TextStyle(fontSize: 16, fontFamily: 'Inter'),
                  ),
                  child: Text('Forgot password?'),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            Container(
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
                  minimumSize: MaterialStateProperty.all(const Size(130, 30)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: signIn,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.white,
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
      )),
    );
    // TODO: implement build
  }
}
