import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/app/home/home_page.dart';
import 'package:pennies_from_heaven/app/sign_in/sign_in_page.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);

    return StreamBuilder<User>(
        stream: authService.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            return user == null ? SignInPage() : HomePage();
          }

          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}
