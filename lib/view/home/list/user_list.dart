import 'package:arcade/view_model/list/list_user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    ListUsersVM vm = Provider.of<ListUsersVM>(context);
    return ListView(
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
        FutureBuilder(
          future: vm.getUsers(),
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
                            items: [
                              PopupMenuItem(
                                child: Text("Deletar"),
                                value: "delete",
                              ),
                            ],
                          ).then(
                            (value) {
                              if (value == "edit") {
                                print("Edit User");
                              } else if (value == "delete") {
                                print("Delete User");
                              }
                            },
                          );
                        },
                        enableFeedback: true,
                        splashFactory: InkRipple.splashFactory,
                        splashColor: Colors.black.withOpacity(0.03),
                        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.03)),
                        child: ListTile(
                          title: Text(e.name),
                          subtitle: Text("${e.identifier}"),
                          trailing: Text("12/12/2021"),
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
      ],
    );
  }
}
