import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(
    RickAndmortyApp(
      appRouter: AppRouter(),
    ),
  );
}

class RickAndmortyApp extends StatelessWidget {
  final AppRouter appRouter;

  const RickAndmortyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
