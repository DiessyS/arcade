import 'package:arcade/theme/theme_tokens.dart';
import 'package:arcade/view_model/auth_vm.dart';
import 'package:arcade/widgets/glossy_container.dart';
import 'package:arcade/widgets/window_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController raController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthVM loginVM = Provider.of<AuthVM>(context);

    return WindowArea(
      child: GlossyContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 64,
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                height: 128,
                width: double.infinity,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        Icons.map_outlined,
                        size: 42,
                        color: ThemeTokens.textColor,
                      ),
                    ),
                    SizedBox.fromSize(size: const Size(16, 0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Arcade',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: ThemeTokens.textColor,
                          ),
                        ),
                        Text(
                          'Se encontre onde você está!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ThemeTokens.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        color: ThemeTokens.textColor,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox.fromSize(size: const Size(0, 32)),
                    TextFormField(
                        controller: raController,
                        decoration: InputDecoration(
                          labelText: 'RA',
                          labelStyle: const TextStyle(
                            color: ThemeTokens.textColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: ThemeTokens.textColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu RA';
                          }
                          return null;
                        }),
                    SizedBox.fromSize(size: const Size(0, 16)),
                    TextFormField(
                        controller: senhaController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                            color: ThemeTokens.textColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: ThemeTokens.textColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          return null;
                        }),
                    SizedBox.fromSize(size: const Size(0, 16)),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          await loginVM.login(raController.text, senhaController.text, context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(ThemeTokens.buttonColor),
                          fixedSize: MaterialStateProperty.all(
                            const Size(
                              double.infinity,
                              48,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        child: const Text('Entrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
