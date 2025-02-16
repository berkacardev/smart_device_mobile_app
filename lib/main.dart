import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_device_mobile_app/product/navigations/app_router.dart';

import 'product/initializer/starter.dart';

Future<void> main() async {
  await StarterInitializer.initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Akıllı Cihazlarım',
      theme: ThemeData(
          useMaterial3: false, scaffoldBackgroundColor: Colors.transparent),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
