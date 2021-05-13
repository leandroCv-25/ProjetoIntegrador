import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/admin_users_manager.dart';
import 'providers/ghs.dart';
import 'providers/user_manager.dart';
import 'screens/base_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager?>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager?..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, Ghs?>(
          create: (_) => Ghs(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager?..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        // locale: const Locale('pt_BR', ""),
        title: 'Controle IoT',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          backgroundColor: Colors.white,
          cardColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat"),
            bodyText2: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat"),
            headline6: TextStyle(
                color: Colors.grey,
                fontSize: 30,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat"),
            headline5: TextStyle(
                color: Colors.grey,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
            headline3: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey, fontFamily: "Montserrat"),
            caption: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: "Montserrat"),
          ),
          bottomAppBarColor: Colors.blueGrey[700],
          appBarTheme: AppBarTheme(color: Colors.blueGrey[700], elevation: 0),
          iconTheme: const IconThemeData(color: Colors.blueGrey),
        ),
        debugShowCheckedModeBanner: false,
        home: BaseScreen(),
      ),
    );
  }
}
