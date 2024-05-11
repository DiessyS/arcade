import 'package:arcade/view_model/limit_vm.dart';
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
        PolygonLayer(
          polygons: [
            Polygon(
              points: vm.getLimit(),
              color: Colors.red.withOpacity(0.1),
              isFilled: true,
              isDotted: true,
              borderColor: Colors.red,
              borderStrokeWidth: 3.0,
            ),
          ],
        ),
        Visibility(
          visible: vm.insertingLimit,
          child: ConfirmationOverlay(
            message: 'Para adicionar o limite continue tocando nos pontos envolta da area que deseja limitar.',
            onConfirm: () {
              vm.saveLimit();
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
