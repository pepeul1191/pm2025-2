import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comentaries_controller.dart';

class ComentariesPage extends StatelessWidget {
  ComentariesController control = Get.put(ComentariesController());

  ComentariesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Comentaries Page'));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
