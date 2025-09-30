import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfileController control = Get.put(ProfileController());

  ProfilePage({super.key});

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('Profile Page'));
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Editar Perfil',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondary, // Color de la flecha
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(context),
      body: _buildBody(context),
    );
  }
}
