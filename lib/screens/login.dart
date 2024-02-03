// ignore: unnecessary_import
// ignore_for_file: unnecessary_import, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unnecessary_import, implementation_imports
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introvel_1/screens/register.dart';

import 'package:introvel_1/sql/sql_helper.dart';
import 'package:local_auth/local_auth.dart';

import '../models/user.dart';
import '../utilities/util.dart';
import 'dashboard/user-dashboard.dart';
import 'dashboard/welcome_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  bool _passwordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();

    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> avail = await auth.getAvailableBiometrics();
    if (!mounted) {
      return;
    }
  }

  bool? authenticated;
  Future<void> _authenticate() async {
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
      setState(() {
        authenticated = true;
      });
    } on PlatformException catch (e) {
      setState(() {
        authenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // child: Container(),
        body: Stack(
          children: <Widget>[
            Container(
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/simala.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xff161d27).withOpacity(0.9),
                  const Color(0xff161d27),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // ignore: prefer_const_constructors
                      Text(
                        "IntroVel",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 100,
                            fontWeight: FontWeight.bold),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 30,
                      ),

                      // ignore: prefer_const_constructors
                      Text(
                        'Testing Test',
                        style: TextStyle(color: Colors.white70, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!RegExp(r'^[\w-\.]+@\.com\.ph$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email ending with @usjr.edu.ph';
                            }
                            return null;
                          },
                          controller: emailController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.grey.shade500),
                            // hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: const Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          obscureText: _passwordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: const Color(0xff161d27).withOpacity(0.9),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Container(
                          height: 50,
                          width: double.infinity,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          child: TextButton(
                            onPressed: () async {
                              final result = await SQLHelper.getSingleUser(
                                  emailController.text);
                              if (!result.isEmpty) {
                                // ignore: use_build_context_synchronously
                                if (result[0]['password'] ==
                                    passwordController.text) {
                                  // ignore: use_build_context_synchronously
                                  final user = User(
                                      id: result[0]['id'],
                                      email: result[0]['email'],
                                      password: result[0]['password'],
                                      path: result[0]['profile_image']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(user)),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBarError(
                                      context, "Password doesn't match!");
                                }
                              } else {
                                // ignore: use_build_context_synchronously
                                showSnackBarError(
                                    context, "Account doesn't exists!");
                              }
                            },

                            // ignore: prefer_const_constructors
                            child: Text('LOGIN',
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              bool authenticated = await auth.authenticate(
                                  localizedReason: 'TEST',
                                  options: const AuthenticationOptions(
                                      stickyAuth: true, biometricOnly: true));

                              if (authenticated) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              }
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const RegisterScreen()),
                              // );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const New_Register_Screen()),
                              // );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const First_Register()),
                              // );
                            },
                            // ignore: prefer_const_constructors
                            child: Text(
                              'Fingerprint',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                              );
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const RegisterScreen()),
                              // );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const New_Register_Screen()),
                              // );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const First_Register()),
                              // );
                            },
                            // ignore: prefer_const_constructors
                            child: Text(
                              'Register',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
