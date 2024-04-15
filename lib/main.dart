import 'package:arcade/route/internal_router.dart';
import 'package:arcade/service/location_service.dart';
import 'package:arcade/service_registers.dart' as register;
import 'package:arcade/service_registers.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  register.serviceRegister();

  await service<LocationService>().init();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARcade',
      themeMode: ThemeMode.dark,
      color: Color(0xFF070F2B),
      onGenerateRoute: InternalRouter().generateRoute,
      initialRoute: 'main_page',
    );
  }
}
