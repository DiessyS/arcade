// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:vector_math/vector_math_64.dart' as vector64;
//
// class EventCamera extends StatelessWidget {
//   EventCamera({super.key});
//
//   late ArCoreController arCoreController;
//
//   @override
//   Widget build(BuildContext context) {
//     return ArCoreView(
//       onArCoreViewCreated: onArCoreViewCreated,
//     );
//   }
//
//   void onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     earthMap(arCoreController);
//   }
//
//   earthMap(ArCoreController coreController) async {
//     final ByteData map = await rootBundle.load("assets/earth_map.jpg");
//
//     final material = ArCoreMaterial(
//         color: Colors.white, textureBytes: map.buffer.asUint8List());
//
//     final sphere = ArCoreCylinder(
//       materials: [material],
//     );
//
//     final node = ArCoreNode(
//       shape: sphere,
//       position: vector64.Vector3(0, 0, -1.5),
//     );
//
//     arCoreController.addArCoreNode(node);
//   }
// }
