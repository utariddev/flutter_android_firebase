import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: firebaseTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return MaterialApp(
                      title: 'Flutter Demo',
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                      ),
                      home: MyHomePage(title: 'Flutter Demo Home Page'),
                    );
                  }
                  return CircularProgressIndicator();
                });
          }
          return CircularProgressIndicator();
        });
  }

  Future<void> firebaseTasks() async {

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getToken().then((value) {
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    });
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(),
    );
  }
}
