import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view_model/map/limit_vm.dart';
import 'package:arcade/view_model/map/path_line_vm.dart';
import 'package:arcade/widgets/confirmation_modal.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ManagerMenu extends StatelessWidget {
  const ManagerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final LimitVM limitVM = Provider.of<LimitVM>(context);
    final PathLineVM pathVM = Provider.of<PathLineVM>(context);

    return ListView(
      shrinkWrap: true,
      children: [
        // bigButton(
        //   title: 'Gerenciar usuarios',
        //   subtitle: 'Adicione ou bloqueie usuários',
        //   icon: Icons.draw,
        //   iconColor: Colors.white,
        //   onPressed: () async {
        //     Navigator.pushNamed(context, '/users_page');
        //   },
        // ),
        // const SizedBox(height: 16),
        bigButton(
          title: 'Gerenciar area limite',
          subtitle: 'Limita o uso da aplicação para uma determinada área',
          icon: Icons.draw,
          iconColor: Colors.white,
          onPressed: () async {
            Navigator.of(context).pop();
            limitVM.startLimitInsertion();
          },
        ),
        const SizedBox(height: 16),
        bigButton(
          title: 'Gerenciar rotas internas',
          subtitle: 'Adicione rotas internar para facilitar a navegação entre os pontos criados',
          icon: Icons.route_outlined,
          iconColor: Colors.white,
          onPressed: () async {
            Navigator.of(context).pop();
            pathVM.startPathInsertion();
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: bigButton(
                title: 'Limpar rotas',
                icon: Icons.delete_outline,
                iconColor: Colors.red,
                onPressed: () async {
                  showConfirmationModal(
                    context,
                    'Remover rotas',
                    'Deseja realmente remover todas as rotas internas?',
                    () async {
                      Navigator.of(context).pop();
                      await pathVM.deletePaths();
                      showToast(
                        'Rotas removidas com sucesso',
                        position: ToastPosition.bottom,
                        radius: 16,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: bigButton(
                title: 'Limpar limite',
                icon: Icons.delete_outline,
                iconColor: Colors.red,
                onPressed: () async {
                  showConfirmationModal(
                    context,
                    'Remover limite',
                    'Deseja realmente remover o limite de área?',
                    () async {
                      Navigator.of(context).pop();
                      await limitVM.deleteLimit();
                      showToast(
                        'Limite removido com sucesso',
                        position: ToastPosition.bottom,
                        radius: 16,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget bigButton({
    required String title,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
    required Function() onPressed,
  }) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ThemeTokens.buttonColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(4),
        ),
      ),
      child: ListTile(
        style: ListTileStyle.drawer,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        splashColor: Colors.white,
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
        leading: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
