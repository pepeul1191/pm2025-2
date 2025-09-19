import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comentaries_controller.dart';

class ComentariesPage extends StatelessWidget {
  ComentariesController control = Get.put(ComentariesController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Comentaries Page'));
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
