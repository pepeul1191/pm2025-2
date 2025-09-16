import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorites_controller.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesController control = Get.put(FavoritesController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Favorites Page'));
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
