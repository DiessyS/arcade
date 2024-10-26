import 'package:arcade/view_model/user_vm.dart';
import 'package:arcade/widgets/confirmation_modal.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UsersVM userVM = Provider.of<UsersVM>(context);

    return FutureBuilder(
      future: userVM.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(
              child: SizedBox(),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!
                .map(
                  (e) => InkWell(
                    onTap: () {
                      print("User tapped");
                    },
                    onTapDown: (details) {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        items: [
                          PopupMenuItem(
                            enabled: !e.banned,
                            child: const Text(
                              'Bloquear usuario',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            onTap: () async {
                              await userVM.banStateUser(e.id, true);
                            },
                          ),
                          PopupMenuItem(
                            enabled: e.banned,
                            child: const Text(
                              'Desbloquear usuario',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            onTap: () async {
                              await userVM.banStateUser(e.id, false);
                            },
                          ),
                          PopupMenuItem(
                            child: const Text(
                              'Remover',
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            onTap: () async {
                              showConfirmationModal(
                                context,
                                'Remover usuário',
                                'Deseja realmente remover o usuário?',
                                () async {
                                  Navigator.of(context).pop();
                                  await userVM.removeUser(e.id);
                                  showToast(
                                    'Usuário removido com sucesso',
                                    position: ToastPosition.bottom,
                                    radius: 16,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                    enableFeedback: true,
                    splashFactory: InkRipple.splashFactory,
                    splashColor: Colors.black.withOpacity(0.03),
                    overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.03)),
                    child: ListTile(
                      title: Text(
                        e.name,
                        style: TextStyle(
                          color: e.banned ? Colors.red : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        "${e.identifier} ${e.banned ? "(Usuario bloqueado)" : ""}",
                      ),
                      trailing: Text(
                        e.manager ? "Gerente" : "Usuário",
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          return const Center(
            child: Text("Erro ao carregar usuários"),
          );
        }
      },
    );
  }
}
