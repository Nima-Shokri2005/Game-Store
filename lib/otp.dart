import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'consts.dart';
import 'http_functions.dart';
import 'sign_in_screen.dart';

class OtpScreen extends StatefulWidget {
  final String userEmail;
  final String confirmationCode;
  final String query;
  final Function dialog;

  const OtpScreen(
      {Key? key,
      required this.userEmail,
      required this.confirmationCode,
      required this.query,
      required this.dialog})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreen();
}

class _OtpScreen extends State<OtpScreen> {
  final defultPinThem = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(fontSize: 22, color: primeColor),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarsection(context),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'verification',
                  style: TextStyle(fontSize: 36, color: primeColor),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('Enter the code sent to your Email:',
                    style: TextStyle(
                      fontSize: 20,
                      color: primeColor,
                    ),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(widget.userEmail,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defultPinThem,
                  focusedPinTheme: defultPinThem.copyWith(
                    decoration: defultPinThem.decoration!.copyWith(
                      border: Border.all(color: primeColor),
                    ),
                  ),
                  onCompleted: (pin) {
                    print(pin);
                    print(widget.confirmationCode);
                    if (pin == widget.confirmationCode) {
                      executeQuery(widget.query).then((_) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      }).catchError((error) {
                        print("Error executing query: $error");
                        // Handle error here
                      });
                    } else {
                      widget.dialog('your pin doesn\'t match!');
                    }
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipPath appBarsection(BuildContext context) {
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
