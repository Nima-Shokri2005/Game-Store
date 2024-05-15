import 'package:flutter/material.dart';
import 'consts.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  final String longText = "The voice of this gaming store invites you to a world of excitement and entertainment! With the Flutinov programming team, explore the latest popular and trending games in the gaming world. From now on, excitement and entertainment are just a click away!";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primeColor,
      child: SafeArea(
          child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              primeColor,
              Colors.red.shade600,
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
          child: MainBody(longText: longText),
        ),
      )),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
    required this.longText,
  });

  final String longText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopExpanded(longText: longText),
          imageExpanded(),
          bottomExpanded(context)
        ],
      ),
    );
  }

  Expanded bottomExpanded(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpScreen()));
            },
            style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                  color: primeColor, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Already member?',
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignInScreen()));
            },
            child: const Text(
              'Sign in',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Expanded imageExpanded() {
    return Expanded(
      child: Image.asset(
        'assets/images/pic1.png',
        width: 170,
      ),
    );
  }
}

class TopExpanded extends StatelessWidget {
  const TopExpanded({
    super.key,
    required this.longText,
  });

  final String longText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'welcome to the game store',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(33.0),
            child: Text(
              longText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
