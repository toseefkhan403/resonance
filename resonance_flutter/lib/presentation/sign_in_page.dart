import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(serverpodClientProvider);

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
