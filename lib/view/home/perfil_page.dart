import 'package:arcade/theme/theme_tokens.dart';
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
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: loginVM.isAuthenticated() ? const Perfil() : Login(),
        ),
      ),
    );
  }
}
