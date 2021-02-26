import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:pennies_from_heaven/services/firebase_storage_service.dart';
import 'package:pennies_from_heaven/services/firestore_service.dart';
import 'package:provider/provider.dart';

// Used to create user dependant objects that need to be accessible by all widgets.
// This widget should live above the [MaterialApp].
// See [AuthWidget], a descendant widget that consumes the snapshot
// generated by this builder

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<FirebaseAuthService>();

    return StreamBuilder<User>(
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user != null) {
            return MultiProvider(
              providers: [
                Provider<User>.value(
                  value: user,
                ),
                Provider<FirebaseStorageService>(
                    create: (_) => FirebaseStorageService(uid: user.uid)),
                Provider<FirestoreService>(
                    create: (_) => FirestoreService(uid: user.uid)),
              ],
              child: builder(context, snapshot),
            );
          }
          return builder(context, snapshot);
        });
  }
}
