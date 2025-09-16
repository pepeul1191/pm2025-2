import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfileController control = Get.put(ProfileController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Perfil'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: true,
      ),
      body: _buildBody(context),
    );
  }
}
