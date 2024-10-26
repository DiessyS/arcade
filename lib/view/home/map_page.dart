import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:arcade/enum/home_page_modes.dart';
import 'package:arcade/models/event.dart';
import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view/home/home/event_map.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/view_model/compass_vm.dart';
import 'package:arcade/view_model/home_page_vm.dart';
import 'package:arcade/view_model/map/event_vm.dart';
import 'package:arcade/view_model/user_location_vm.dart';
import 'package:arcade/widgets/event_form.dart';
import 'package:arcade/widgets/floating_map_menu.dart';
import 'package:arcade/widgets/map/map_legend.dart';
import 'package:arcade/widgets/window_area.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageVM vm = Provider.of<HomePageVM>(context);

    return WindowArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EventMap(),
          const FloatingMapMenu(),
        ],
      ),
    );
  }
}
