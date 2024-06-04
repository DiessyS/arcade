import 'package:arcade/models/user.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/widgets/perfil/login.dart';
import 'package:arcade/widgets/perfil/perfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        color: const Color(0xFF070F2B),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: loginVM.isAuthenticated() ? const Perfil() : Login(),
        ),
      ),
    );
  }
}
