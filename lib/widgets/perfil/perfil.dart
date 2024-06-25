import 'package:arcade/models/user.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);
    User user = loginVM.getUser()!;

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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "${user.identifier} - ${user.manager ? 'Gerenciador' : 'Usuário'}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
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
                    const Icon(
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
