import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    ListEventsVM vm = Provider.of<ListEventsVM>(context);
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
              .getEvents()
              .map(
                (e) => InkWell(
                  onTap: () {
                    print("Event tapped");
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
                          print("Edit event");
                        } else if (value == "delete") {
                          print("Delete event");
                        }
                      },
                    );
                  },
                  enableFeedback: true,
                  splashFactory: InkRipple.splashFactory,
                  splashColor: Colors.black.withOpacity(0.03),
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.03)),
                  child: ListTile(
                    title: Text(e.title),
                    subtitle: Text("${e.type.readableLabel()} - ${e.description}"),
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
