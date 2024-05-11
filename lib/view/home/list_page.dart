import 'package:arcade/view/home/list/event_list.dart';
import 'package:arcade/view/home/list/user_list.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF070F2B),
        child: DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  excludeHeaderSemantics: true,
                  automaticallyImplyLeading: false,
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.person_outline),
                        text: "Usuarios",
                      ),
                      Tab(
                        icon: Icon(Icons.location_on_outlined),
                        text: "Eventos",
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: <Widget>[
                    UserList(),
                    EventList(),
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
