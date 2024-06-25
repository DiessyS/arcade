import 'package:arcade/route/path_router.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service/server_service.dart';
import 'package:arcade/service_registers.dart' as register;
import 'package:arcade/service_registers.dart';
import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view_model/bottom_navigation_vm.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/event_map_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:arcade/view_model/user_vm.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/server_vm.dart';
import 'package:arcade/view_model/user_location_vm.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  register.serviceRegister();

  await service<LocationService>().init();

  bool serverAvailable = await service<ServerService>().serverAvailable();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LimitVM()),
      ChangeNotifierProvider(create: (_) => CompassVM()),
      ChangeNotifierProvider(create: (_) => UserLocationVM()),
      ChangeNotifierProvider(create: (_) => AuthVM()),
      ChangeNotifierProvider(create: (_) => EventMapVM()),
      ChangeNotifierProvider(create: (_) => EventVM()),
      ChangeNotifierProvider(create: (_) => CompassVM()),
      ChangeNotifierProvider(create: (_) => HomePageVM()),
      ChangeNotifierProvider(create: (_) => BottomNavigationVM()),
      ChangeNotifierProvider(create: (_) => UsersVM()),
      ChangeNotifierProvider(create: (_) => ListEventsVM()),
      ChangeNotifierProvider(create: (_) => UserLocationVM()),
      ChangeNotifierProvider(create: (_) => ServerVM()),
    ],
    child: Main(serverAvailable: serverAvailable),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key, required this.serverAvailable});

  final bool serverAvailable;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'ARcade',
        themeMode: ThemeMode.dark,
        onGenerateRoute: PathRouter().generateRoute,
        initialRoute: serverAvailable ? '/main_page' : '/offline',
      ),
    );
  }
}
