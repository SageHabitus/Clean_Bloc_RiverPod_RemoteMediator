import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/feature/repo_list/screen/repo_list_screen.dart';
import 'presentation/feature/user_list/screen/user_list_screen.dart';
import 'presentation/resource/app_route.dart';
import 'presentation/resource/alert_message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AlertMessage.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserListScreen(),
      routes: {
        AppRoute.userlist: (context) => const UserListScreen(),
        AppRoute.repolist: (context) => const RepoListScreen()
      },
    );
  }
}