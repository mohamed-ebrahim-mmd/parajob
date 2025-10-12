/*
 Mohamed Ebrahim | mohamed7ebrahim7@gmail.com | 2025-10-12 2:40 PM
 ==================================================================
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/route_manager/controller/routing_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final RoutingController routingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Onboarding Screen'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await routingController.goLoginScreen();
              },
              child: Text('Go to Login Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
