import 'package:flutter/material.dart';

class ConfirmationOverlay extends StatelessWidget {
  ConfirmationOverlay({
    super.key,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Ok',
    required this.onCancel,
    this.cancelText = 'Cancelar',
  });

  String message;

  VoidCallback onConfirm;
  String confirmText;

  VoidCallback onCancel;
  String cancelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red.withOpacity(0.8)),
                ),
                onPressed: onCancel,
                child: Text(cancelText),
              ),
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                ),
                onPressed: onConfirm,
                child: Text(confirmText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
