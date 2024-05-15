import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'home_screen.dart';
import 'http_functions.dart';
import 'sign_up_screen.dart';
import 'consts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMeChange = false;
  final _usernameControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool isShowPassword = false;

  @override
  void dispose() {
    super.dispose();
    _usernameControler.dispose();
    _passwordControler.dispose();
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
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _keyForm,
        child: Column(
          children: [const AppBarrSec(), mainSection(), bottomSection()],
        ),
      ),
    );
  }

  Expanded bottomSection() {
    return Expanded(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              if (_keyForm.currentState!.validate() && rememberMeChange) {
                String? currentPassword = await executeQuery(
                    "select password from users where username = '${_usernameControler.text}';");
                if (currentPassword == 'No results found.') {
                  dialogShow('username not found!');
                } else if (currentPassword != toHash(_passwordControler.text)) {
                  dialogShow('password doesn\'t match!');
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                }
              } else {
                dialogShow('complete inputs');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primeColor,
              fixedSize: const Size(250, 35),
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Don\'t have account?',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpScreen()));
            },
            style: TextButton.styleFrom(shadowColor: primeColor),
            child: const Text(
              'Sign Up form here ',
              style: TextStyle(color: primeColor),
            ),
          )
        ],
      ),
    );
  }

  Expanded mainSection() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Sign In Now',
            style: TextStyle(color: primeColor, fontSize: 27),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _usernameControler,
              keyboardType: TextInputType.name,
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
                  hintText: 'Username'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'username can not be empty';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _passwordControler,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isShowPassword,
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
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isShowPassword == false) {
                            isShowPassword = true;
                          } else {
                            isShowPassword = false;
                          }
                        });
                      },
                      icon: Icon(!isShowPassword
                          ? Icons.remove_red_eye_rounded
                          : Icons.visibility_off)),
                  prefixIcon: const Icon(Icons.lock_outlined),
                  prefixIconColor: Colors.grey.shade900,
                  hintText: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'password can not be empty';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: primeColor,
                      value: rememberMeChange,
                      onChanged: (state) {
                        setState(() {
                          rememberMeChange = state!;
                        });
                      },
                    ),
                    const Text('Remember Me')
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: primeColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class AppBarrSec extends StatelessWidget {
  const AppBarrSec({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: double.infinity,
        height: 200,
        color: primeColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 95,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
