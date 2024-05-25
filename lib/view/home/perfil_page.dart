import 'package:arcade/models/user.dart';
import 'package:arcade/view_model/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = Provider.of<LoginVM>(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        color: const Color(0xFF070F2B),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: loginVM.isAuthenticated() ? perfil(loginVM) : loginForm(context, loginVM),
        ),
      ),
    );
  }

  Widget loginForm(context, LoginVM loginVM) {
    TextEditingController raController = TextEditingController();
    TextEditingController senhaController = TextEditingController();

    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                //close
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox.fromSize(size: const Size(0, 32)),
            TextField(
              controller: raController,
              decoration: InputDecoration(
                labelText: 'RA',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox.fromSize(size: const Size(0, 16)),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox.fromSize(size: const Size(0, 16)),
            FilledButton(
              onPressed: () {
                loginVM.login(raController.text, senhaController.text, context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                fixedSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget perfil(LoginVM loginVM) {
    User user = loginVM.getUser();
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${user.identifier} - ${user.manager ? 'Gerenciador' : 'Usuário'}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  loginVM.logout();
                },
                style: ButtonStyle(
                  alignment: Alignment.center,
                  fixedSize: MaterialStateProperty.all(
                    const Size(120, 120),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox.fromSize(size: const Size(16, 0)),
                    const Text(
                      'Sair',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
