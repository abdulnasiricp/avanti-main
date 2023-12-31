import 'package:avanti/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp();
//     runApp(const MyApp());
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//   }
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: const FirebaseOptions(
    apiKey: "AIzaSyAotigoE-d3sqg1P1D7GZ4-_1ZOECqu6c8", // Your apiKey
    appId: "1:708469820751:android:039f3e75177ba071b1c93a", // Your appId
    messagingSenderId: "708469820751", // Your project number
    projectId: "avanti-fd4a9",
    databaseURL:
        "https://avanti-fd4a9-default-rtdb.firebaseio.com", //your realtime database
  ));
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avanti',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
