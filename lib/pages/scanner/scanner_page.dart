import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scanner_controller.dart';

class ScannerPage extends StatelessWidget {
  ScannerController control = Get.put(ScannerController());

  ScannerPage({super.key});

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Scanner Page'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
