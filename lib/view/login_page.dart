import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {
        print('Facebook login failed. Status: ${loginResult.status}');
        return null;
      }
    } catch (e) {
      print('Error during Facebook login: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.purpleAccent,
                Colors.amber,
                Colors.blue,
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 150,
                width: 200,
                child: Image.asset("assets/logo.jpeg"),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 325,
                height: 470,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      width: 260,
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      width: 260,
                      height: 60,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.red,
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ])),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    const Text(
                      "Or Login using Social Media Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            try {
                              UserCredential? userCredential =
                                  await signInWithGoogle();
                              if (userCredential != null) {
                                print(
                                    "Google sign-in successful: ${userCredential.user?.displayName}");
                              } else {
                                print("Google sign-in cancelled.");
                              }
                            } catch (e) {
                              print("Error during Google sign-in: $e");
                            }
                          },
                          child: Image.asset(
                            'assets/google.png',
                            height: 50,
                            width: 100,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            UserCredential? userCredential =
                                await signInWithFacebook();
                            if (userCredential != null) {
                              // Handle successful login
                              print(
                                  'Facebook login successful: ${userCredential.user}');
                            } else {
                              // Handle login failure
                              print('Facebook login failed.');
                            }
                          },
                          child: Image.asset(
                            'assets/fb.png',
                            height: 50,
                            width: 100,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () async {
                        //       try {
                        //         UserCredential? userCredential =
                        //             await signInWithGoogle();
                        //         if (userCredential != null) {
                        //           print(
                        //               "Google sign-in successful: ${userCredential.user?.displayName}");
                        //         } else {
                        //           print("Google sign-in cancelled.");
                        //         }
                        //       } catch (e) {
                        //         print("Error during Google sign-in: $e");
                        //       }
                        //     },
                        //     icon: Image.asset(
                        //       'assets/google.png',
                        //     )),
                        // IconButton(
                        //     onPressed: () async {
                        //       UserCredential? userCredential =
                        //           await signInWithFacebook();
                        //       if (userCredential != null) {
                        //         // Handle successful login
                        //         print(
                        //             'Facebook login successful: ${userCredential.user}');
                        //       } else {
                        //         // Handle login failure
                        //         print('Facebook login failed.');
                        //       }
                        //     },
                        //     icon: Image.asset(
                        //       'assets/fb.png',
                        //       height: 100,
                        //       width: 100,
                        //       fit: BoxFit.fitHeight,
                        //     )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
