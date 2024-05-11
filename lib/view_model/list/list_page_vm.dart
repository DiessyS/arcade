import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:arcade/view_model/list/list_user_vm.dart';
import 'package:flutter/cupertino.dart';

class ListPageVM extends ChangeNotifier {
  late ListEventsVM listEventsVM;
  late ListUsersVM listUsersVM;

  ListPageVM() {
    listEventsVM = ListEventsVM();
    listUsersVM = ListUsersVM();
  }
}
