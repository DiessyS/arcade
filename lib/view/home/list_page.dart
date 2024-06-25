import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view/home/list/event_list.dart';
import 'package:arcade/view/home/list/user_list.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);

    bool isManager = loginVM.getUser() != null && loginVM.getUser()!.manager;

    return SafeArea(
      child: Container(
        color: ThemeTokens.backgroundColor,
        child: DefaultTabController(
          length: isManager ? 2 : 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 0,
                  excludeHeaderSemantics: true,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    tabs: isManager
                        ? [
                            const Tab(
                              icon: Icon(Icons.person_outline),
                              text: "Usuarios",
                            ),
                            const Tab(
                              icon: Icon(Icons.location_on_outlined),
                              text: "Eventos",
                            ),
                          ]
                        : [
                            const Tab(
                              icon: Icon(Icons.location_on_outlined),
                              text: "Eventos",
                            ),
                          ],
                  ),
                ),
                backgroundColor: Colors.white,
                body: TabBarView(
                  children: isManager
                      ? <Widget>[
                          const UserList(),
                          const EventList(),
                        ]
                      : <Widget>[
                          const EventList(),
                        ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
