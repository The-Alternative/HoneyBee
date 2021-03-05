import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path_provider/path_provider.dart';

import 'http_client.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
class DriveScreen extends StatefulWidget {

  @override
  DriveScreenState createState() {
    return new DriveScreenState();
  }
}

class DriveScreenState extends State<DriveScreen> {
  GoogleSignInAccount account;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );
  DriveApi api;

  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Flutter to drive'),
        actions: account == null
            ? []
            : <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: logout)
        ],
      ),
      body: Center(
        child: account == null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(child: Text('Login'), onPressed: login),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage:
                    NetworkImage(account.photoUrl, scale: 0.3),
                    backgroundColor: Colors.yellow,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(account.displayName),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  child: Text('save random file'), onPressed: toDrive),
            ),
            Expanded(
              child: FutureBuilder(
                  initialData: null,
                  future: api.files.list(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: (snapshot.data as FileList)
                            .files
                            .map((f) => ListTile(
                          dense: true,
                          title: Text(f.name),
                          leading: Icon(Icons.insert_drive_file),
                        ))
                            .toList(),
                      );
                    }
                    if (snapshot.hasError)
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    return SizedBox();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    try {

      final googleSignIn =
      signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveScope]);
      final signIn.GoogleSignInAccount account = await googleSignIn.signIn();
      print("User account $account");

      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final Stream<List<int>> mediaStream = Future.value([104, 105]).asStream();
      var media = new drive.Media(mediaStream, 2);
      var driveFile = new drive.File();
      driveFile.name = "hello_world.txt";
      final result = await driveApi.files.create(driveFile, uploadMedia: media);
      print("Upload result: $result");
    } catch (error) {
      print('DriveScreen.login.ERROR... $error');
      _scaffold.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade700,
        content: Text(
          'Error : $error',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    setState(() {});
  }

  void toDrive() async {
    final filename = 'file-${DateTime.now().millisecondsSinceEpoch}.txt';

    final gFile = File();
    gFile.name = filename;

    final dir = await getApplicationDocumentsDirectory();
    final localFile = io.File('${dir.path}/$filename');
    await localFile.create();
    await localFile.writeAsString('$filename');

    final createdFile = await api.files.create(gFile,
        uploadMedia: Media(localFile.openRead(), localFile.lengthSync()));

    _scaffold.currentState.showSnackBar(SnackBar(
      content: Text('File saved => id : ${createdFile.id}'),
    ));

    // rebuild to refresh file list
    setState(() {});
  }

  void logout() {
    _googleSignIn.signOut();
    setState(() {
      account = null;
    });
  }
}
