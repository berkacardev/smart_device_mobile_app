import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_device_mobile_app/product/navigations/app_router.gr.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override.
  Widget build(BuildContext _context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 2200), () {
        context.router.replace(HomeRoute());
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.all(90),
            child: Center(child: Image.asset("assets/logo/smart_devices_logo.png")),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 30,
            height: 30,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotate,
            ),
          ),
        ],
      ),
    );
  }
}
