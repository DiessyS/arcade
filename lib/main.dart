import 'package:arcade/bootstrap.dart';
import 'package:arcade/route/path_router.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart' as register;
import 'package:arcade/service_registers.dart';
import 'package:arcade/view_model/bottom_navigation_vm.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/event_map_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:arcade/view_model/limit_vm.dart';
import 'package:arcade/view_model/list/list_events_vm.dart';
import 'package:arcade/view_model/list/list_user_vm.dart';
import 'package:arcade/view_model/login_vm.dart';
import 'package:arcade/view_model/places_vm.dart';
import 'package:arcade/view_model/user_location_vm.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  register.serviceRegister();

  await service<LocationService>().init();

  bootstrap();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LimitVM()),
      ChangeNotifierProvider(create: (_) => PlacesVM()),
      ChangeNotifierProvider(create: (_) => CompassVM()),
      ChangeNotifierProvider(create: (_) => UserLocationVM()),
      ChangeNotifierProvider(create: (_) => LoginVM()),
      ChangeNotifierProvider(create: (_) => EventMapVM()),
      ChangeNotifierProvider(create: (_) => CompassVM()),
      ChangeNotifierProvider(create: (_) => HomePageVM()),
      ChangeNotifierProvider(create: (_) => BottomNavigationVM()),
      ChangeNotifierProvider(create: (_) => ListUsersVM()),
      ChangeNotifierProvider(create: (_) => ListEventsVM()),
      ChangeNotifierProvider(create: (_) => UserLocationVM()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'ARcade',
        themeMode: ThemeMode.dark,
        color: const Color(0xFF070F2B),
        onGenerateRoute: PathRouter().generateRoute,
        initialRoute: 'main_page',
      ),
    );
  }
}
