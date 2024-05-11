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
        ListView(
          shrinkWrap: true,
          children: vm
              .getUsers()
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
                    subtitle: Text("${e.type.name} - ${e.ra}"),
                    trailing: Text("12/12/2021"),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
