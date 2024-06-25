import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:arcade/widgets/confirmation_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class Limit extends StatelessWidget {
  const Limit({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LimitVM>(context);

    return Stack(
      children: [
        FutureBuilder(
          future: vm.getLimit(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.data == null) {
              return const SizedBox();
            }

            return PolygonLayer(
              polygons: [
                Polygon(
                  points: snapshot.data!,
                  isDotted: true,
                  borderColor: Colors.red,
                  borderStrokeWidth: 4.0,
                ),
              ],
            );
          },
        ),
        Visibility(
          visible: vm.insertingLimit,
          child: ConfirmationOverlay(
            message:
                'Para adicionar o limite continue tocando nos pontos envolta da area que deseja limitar.',
            onConfirm: () async {
              await vm.saveLimit();
            },
            confirmText: 'Finalizar',
            onCancel: () {
              vm.resetLimit();
            },
            cancelText: 'Cancelar',
          ),
        ),
      ],
    );
  }
}
