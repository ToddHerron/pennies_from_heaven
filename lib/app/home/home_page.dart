import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:pennies_from_heaven/app/home/about_page.dart';
import 'package:pennies_from_heaven/common_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/models/avatar_reference.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:pennies_from_heaven/services/firebase_storage_service.dart';
import 'package:pennies_from_heaven/services/firestore_service.dart';
import 'package:pennies_from_heaven/services/image_picker_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = context.read<FirebaseAuthService>();
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutPage(),
      ),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker = context.read<ImagePickerService>();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);

      // 2. Upload the image to remote Storage / get url
      if (file != null) {
        // set avatarLoading to true

        final storage = context.read<FirebaseStorageService>();
        final downloadUrl = await storage.uploadAvatar(file: file);

        // 3. Save url to remote Firestore
        final database = context.read<FirestoreService>();
        await database.setAvatarReference(AvatarReference(downloadUrl));

        // 4. Delete the local file
        await file.delete();

        // set avatarLoading to false

      }
    } catch (e) {
      print(e);
      // set avatarLoading to false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: IconButton(
            icon: Icon(Icons.help),
            onPressed: () => _onAbout(context),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _signOut(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(130.0),
            child: Column(
              children: <Widget>[
                _buildUserInfo(context: context),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        body: Consumer<ValueNotifier<bool>>(builder: (_, avatarLoading, __) {
          if (avatarLoading.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 6.0,
                  backgroundColor: Colors.limeAccent[700],
                )),
                SizedBox(height: 10),
                Text(
                  "Avatar Loading",
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
        }));
  }

  Widget _buildUserInfo({BuildContext context}) {
    final database = context.watch<FirestoreService>();
    final avatarLoading = context.watch<ValueNotifier<bool>>();

    return StreamBuilder<AvatarReference>(
        stream: database.avatarReferenceStream(),
        builder: (context, snapshot) {
          final avatarReference = snapshot.data;
          return Avatar(
            photoUrl: avatarReference?.downloadUrl,
            radius: 50,
            borderColor: Colors.black54,
            borderWidth: 2.0,
            onPressed: () {
              avatarLoading.value = true;
              _chooseAvatar(context).then((void _) {
                avatarLoading.value = false;
              });
            },
          );
        });
  }
}
