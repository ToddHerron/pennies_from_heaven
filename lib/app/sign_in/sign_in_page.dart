import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pennies_from_heaven/models/build_flavor.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = context.read<FirebaseAuthService>();
      final user = await auth.signInAnonymously();
      print("uid = ${user.uid}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Sign in anonymously'),
              onPressed: () => _signInAnonymously(context),
            ),
          ),
          Center(
            child: StreamBuilder<Object>(
                stream: GetIt.I<BuildFlavor>().stream$,
                builder: (context, snapshot) {
                  return Text('Flavor = ${snapshot.data}');
                }),
          )
        ],
      ),
    );
  }
}
