// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:introvel_1/screens/login.dart';

import 'package:introvel_1/screens/widgets/password_field.dart';
import 'package:introvel_1/screens/widgets/text_button.dart';
import 'package:introvel_1/screens/widgets/text_field.dart';
import 'package:introvel_1/utilities/util.dart';

import '../sql/sql_helper.dart';
import '../utilities/constant.dart';
import 'dashboard/user-dashboard.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordVisibility = true;
  bool passwordVisibility2 = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Future<void> _addItem() async {
    await SQLHelper.registerUser(
        emailController.text, passwordController.text, null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image(
              width: 24,
              color: Colors.white,
              image: Svg('assets/back_arrow.svg'),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: kHeadline,
                            ),
                            Text(
                              "Create new account to get started.",
                              style: kBodyText2,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: emailController,
                                style: kBodyText.copyWith(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Email Address",
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: passwordController,
                                style: kBodyText.copyWith(
                                  color: Colors.blue,
                                ),
                                obscureText: passwordVisibility,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          if (passwordVisibility == true) {
                                            passwordVisibility = false;
                                          } else {
                                            passwordVisibility = true;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        passwordVisibility
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Password",
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: confirmPasswordController,
                                style: kBodyText.copyWith(
                                  color: Colors.blue,
                                ),
                                obscureText: passwordVisibility2,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          if (passwordVisibility2 == true) {
                                            passwordVisibility2 = false;
                                          } else {
                                            passwordVisibility2 = true;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        passwordVisibility2
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Confirm Password",
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: kBodyText,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Login()),
                              // );
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sign In",
                              style: kBodyText.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black12,
                            ),
                          ),
                          onPressed: () async {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              showSnackBarError(
                                  context, "Password doesn't match!");
                            } else {
                              //db stuff
                              if (emailController.text.isNotEmpty ||
                                  passwordController.text.isNotEmpty ||
                                  confirmPasswordController.text.isNotEmpty) {
                                final result = await SQLHelper.registerUser(
                                    emailController.text,
                                    passwordController.text,
                                    null);
                                if (result >= 1) {
                                  Navigator.pop(context);
                                  showSnackBarSuccess(
                                      context, "Registered Successfully!");
                                } else {
                                  showSnackBarError(
                                      context, "Error on registration!");
                                }
                              } else {
                                showSnackBarError(context, "Error on Inputs!");
                              }
                            }
                          },
                          child: Text(
                            "Register",
                            style: kButtonText.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
