import 'package:block_chain/UI/LogIn/google_sign_in/google_sign_in.dart';
import 'package:block_chain/widgets/home_page.dart';
import 'package:block_chain/routes/RouteGenerator.dart';
import 'package:block_chain/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterIconNetwork.instance!
      .init(host: "https://sejong.net.solidwallet.io/api/v3", isTestNet: true);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Flutter App_Emotion_Detection',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: const HomePage(),
          onGenerateRoute: RouteGenerator().onGenerateRoute,
        ),
      );
}
