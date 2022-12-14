import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/message_dao.dart';
import '../data/user_dao.dart';
import 'ui/login.dart';
import 'ui/message_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MessageDao>(
          lazy: false,
          create: (_) => MessageDao(),
        ),
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (_) => UserDao(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        theme: ThemeData(primaryColor: const Color(0xFF3D814A)),
        home: Consumer<UserDao>(
          // 2
          builder: (context, userDao, child) {
            // 3
            if (userDao.isLoggedIn()) {
              return const MessageList();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
