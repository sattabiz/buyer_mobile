import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/current_user_view_model.dart';
import '../../view_model/login_view_model.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              height: 700,
              child: SvgPicture.asset(
                'assets/ellipse.svg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/login_logo.svg',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 60,
                ),
                TextField(
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      FlutterI18n.translate(context, 'tr.login.email'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 300, maxHeight: 50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      FlutterI18n.translate(context, 'tr.login.password'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 300, maxHeight: 50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref.read(loginProvider.notifier).login(
                          email: _emailController.text,
                          password: _passwordController.text);
                      final loginState = ref.watch(loginProvider);

                      if (loginState == LoginState.success) {
                        context.go('/home');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(FlutterI18n.translate(context, 'tr.login.success'),),
                          ),
                        );
                        //context.go('/home');
                      } else if (loginState == LoginState.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Hata"),
                          ),
                        );
                      }
                    } catch (e) {
                      // print(e);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(140, 30)),
                  ),
                  child: Text(
                    FlutterI18n.translate(context, 'tr.login.login_btn'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      await ref.read(loginProvider.notifier).login(
                        email: "alperburat@gmail.com", password: "deneme123");
                      final loginState = ref.watch(loginProvider);

                      if (loginState == LoginState.success) {
                        context.go('/home');
                        ref.watch(getCurrentUserInfoProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Basarili giris"),
                          ),
                        );
                        //context.go('/home');
                      } else if (loginState == LoginState.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Hata"),
                          ),
                        );
                      }
                    } catch (e) {
                      // print(e);
                    }
                  },
                  child: Text(
                    FlutterI18n.translate(context, 'tr.login.forgot_password'),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.shadow,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
