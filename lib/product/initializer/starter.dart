import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_device_mobile_app/firebase_options.dart';
import 'package:smart_device_mobile_app/product/initializer/di.dart';

abstract class StarterInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    DependencyInjection.initializeDependencies();

    //await CacheNotificationServiceHive.hiveInitialize();
  }
}
