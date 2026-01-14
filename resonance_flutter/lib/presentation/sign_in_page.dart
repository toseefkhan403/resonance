import 'package:flutter/material.dart';
import 'package:resonance_flutter/main.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050000),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: SizedBox(
            width: 450,
            child: GoogleSignInWidget(
              client: client,
              buttonWrapper:
                  ({required child, required onPressed, required style}) =>
                      FilledButton(
                        onPressed: onPressed,
                        style:
                            FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF050000),
                              padding: EdgeInsets.zero,
                            ).copyWith(
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                        child: child,
                      ),
              onError: (error) {
                // Handle errors
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
