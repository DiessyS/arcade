import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view/home/list/user_list.dart';
import 'package:arcade/widgets/glossy_container.dart';
import 'package:arcade/widgets/window_area.dart';
import 'package:flutter/material.dart';

import 'list/event_list.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowArea(
      child: GlossyContainer(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Gerenciamento de Usuários",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Usuarios",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ThemeTokens.backgroundColor,
                      width: 1,
                    ),
                  ),
                  child: const UserList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
