import 'package:arcade/view_model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UsersVM userVM = Provider.of<UsersVM>(context);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Pesquisar",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: userVM.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Nenhum usuário encontrado"),
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
                                    'Banir',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () async {
                                    await userVM.banStateUser(e.id, true);
                                  },
                                ),
                                PopupMenuItem(
                                  enabled: e.banned,
                                  child: const Text(
                                    'Desbanir',
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
                                    await userVM.removeUser(e.id);
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
                              "${e.identifier} ${e.banned ? "(Banido)" : ""}",
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
          ),
        ),
      ],
    );
  }
}
