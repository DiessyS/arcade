import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:arcade/view_model/user_vm.dart';
import 'package:flutter/cupertino.dart';

class ListPageVM extends ChangeNotifier {
  late ListEventsVM listEventsVM;
  late UsersVM listUsersVM;

  ListPageVM() {
    listEventsVM = ListEventsVM();
    listUsersVM = UsersVM();
  }
}
