import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:untitled/catagory.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/service/auth/auth_gete.dart';
import 'package:untitled/welcome/welcome_page.dart';
import 'package:untitled/service/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const Catagory(
        //   name: 'Food',
        // )
        home: const AuthGate());
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? image;
//   Future pickImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       final imageTemporary = File(image.path);
//       final imagePermanent = await seveImagePermantly(image.path);

//       setState(() => this.image = imageTemporary);
//       print(imagePermanent.path);
//     } on PlatformException catch (e) {
//       print("faild to pick");
//     }
//   }

//   Future<File> seveImagePermantly(String imagePath) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final name = basename(imagePath);
//     final image = File('${directory.path}/$name');
//     print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq${directory.path}/$name');
//     return File(imagePath).copy(image.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             image != null
//                 ? Image.file(
//                     image!,
//                     width: 160,
//                     height: 160,
//                     fit: BoxFit.cover,
//                   )
//                 : FlutterLogo(
//                     size: 160,
//                   ),
//             IconButton(
//                 onPressed: () => pickImage(ImageSource.gallery),
//                 icon: Icon(Icons.browse_gallery)),
//             IconButton(
//                 onPressed: () => pickImage(ImageSource.camera),
//                 icon: Icon(Icons.camera))
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
