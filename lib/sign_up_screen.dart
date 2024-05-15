import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:regexpattern/regexpattern.dart';
import 'dart:math';
import 'http_functions.dart';
import 'consts.dart';
import 'sign_in_screen.dart';
import 'otp.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agreeWithTermsService = false;
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _usernameControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _repasswordControler = TextEditingController();
  final GlobalKey<FormState> _validateKeyForm = GlobalKey<FormState>();


  String? email;
  bool showPasswordCheck = true;
  bool showRePasswordCheck = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailControler.dispose();
    _usernameControler.dispose();
    _passwordControler.dispose();
    _repasswordControler.dispose();
  }

  Future<dynamic> dialogShow(String str) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'warning',
          ),
          content: Text(str),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: primeColor),
              child: const Text(
                "return",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _validateKeyForm,
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarSection(context),
              mainSection(),
              buttonSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Column buttonSection(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            if (_validateKeyForm.currentState!.validate() &&
                agreeWithTermsService) {
              String? currentUsername = await executeQuery(
                  "select username from users where username = '${_usernameControler.text}';");

              if (currentUsername == 'No results found.') {
                String? currentEmail = await executeQuery(
                    "select email from users where email = '${_emailControler.text}';");

                if (currentEmail == 'No results found.') {
                  var rng = Random();
                  var confirmationNumber = (rng.nextInt(9000) + 1000).toString();
                  await sendEmail(
                      email: _emailControler.text,
                      template: 'template_azeusee',
                      name: _usernameControler.text,
                      code: confirmationNumber);
                  final String query = "insert into users(email,username,password)values('${_emailControler.text}','${_usernameControler.text}','${toHash(_passwordControler.text)}');";

            Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(userEmail: _emailControler.text,confirmationCode: confirmationNumber,query: query,dialog: dialogShow,),
                    ),
                  );
                } else {
                  dialogShow('email already registered!');
                }
              } else {
                dialogShow('this username already taken!');
              }
            } else {
              dialogShow('please complete the form');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primeColor,
            fixedSize: const Size(250, 35),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          'do you have account?',
          style: TextStyle(
              color: Colors.grey.shade800, fontFamily: 'roboto', fontSize: 15),
        ),
        TextButton(
          style: TextButton.styleFrom(shadowColor: primeColor),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          },
          child: const Text(
            'Sign in here',
            style: TextStyle(
              color: primeColor,
              fontFamily: 'roboto',
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }

  Column mainSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 13),
          child: Text(
            'Create Account',
            style: TextStyle(
                color: primeColor, fontSize: 27, fontFamily: 'roboto'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
          child: Column(
            children: [
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: _usernameControler,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.grey.shade900, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: Colors.grey.shade900,
                    hintText: 'User name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'username can not be empty';
                  } else if (value.toString().isUsername() == false) {
                    return 'enter your username correctly';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _emailControler,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.grey.shade900, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: Colors.grey.shade900,
                    hintText: 'E-mail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'E-mail can not be empty';
                  } else if (value.toString().isEmail() == false) {
                    return 'enter your E-mail correctly';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passwordControler,
                obscureText: showPasswordCheck,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password can not be empty';
                  } else if (!value.toString().isPasswordEasy()) {
                    return 'your password is easy';
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.grey.shade900, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              if (showPasswordCheck == false) {
                                showPasswordCheck = true;
                              } else {
                                showPasswordCheck = false;
                              }
                            },
                          );
                        },
                        icon: Icon(!showPasswordCheck
                            ? Icons.remove_red_eye_rounded
                            : Icons.visibility_off)),
                    prefixIconColor: Colors.grey.shade900,
                    hintText: 'password'),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _repasswordControler,
                obscureText: showRePasswordCheck,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'repeat password can not be empty';
                  } else if (_passwordControler.text !=
                      _repasswordControler.text) {
                    return 'please enter your repeat password correctly';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Colors.grey.shade900, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (showRePasswordCheck == false) {
                              showRePasswordCheck = true;
                            } else {
                              showRePasswordCheck = false;
                            }
                          });
                        },
                        icon: Icon(!showRePasswordCheck
                            ? Icons.remove_red_eye_rounded
                            : Icons.visibility_off)),
                    prefixIconColor: Colors.grey.shade900,
                    hintText: 'repeat password'),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: primeColor,
                    value: agreeWithTermsService,
                    onChanged: (state) {
                      setState(
                        () {
                          agreeWithTermsService = state!;
                        },
                      );
                    },
                  ),
                  Text(
                    'I agreed with',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontFamily: 'roboto',
                        fontSize: 15),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(shadowColor: primeColor),
                    onPressed: () {},
                    child: const Text(
                      'terms service',
                      style: TextStyle(
                          color: primeColor,
                          fontFamily: 'roboto',
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ClipPath appBarSection(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: primeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 95,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
