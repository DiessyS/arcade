import 'package:arcade/theme/theme_tokens.dart';
import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    //ServerVM serverVM = Provider.of<ServerVM>(context);

    return Container(
      color: ThemeTokens.backgroundColor,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: Text(
                'Não foi possível conectar ao servidor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                // serverVM.isServerAvailable().then((value) {
                //   if (value) {
                //     Navigator.of(context).pushNamed('/main_page');
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('Não foi possível conectar ao servidor'),
                //       ),
                //     );
                //   }
                // });
              },
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
