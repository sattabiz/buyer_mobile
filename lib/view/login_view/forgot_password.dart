import 'package:PaletPoint/view_model/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? email;
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
                  height: 40,
                ),
                Text(
                  FlutterI18n.translate(context, 'tr.login.reset_password'),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  controller: _emailController,
                  onChanged: (value) async{
                    email = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      FlutterI18n.translate(context, 'tr.login.email'),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    constraints:
                        const BoxConstraints(maxWidth: 300, maxHeight: 50),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () async{
                    await ref.read(forgotPasswordProvider.notifier).forgotPassword(email: email);
                    final responseData = ref.watch(forgotPasswordProvider);
                    if(responseData["status"]== 200){
                      context.go('/login'); 
                    }
                    const SnackBar(content: Text("Bir sorun oluştu."));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(140, 30)),
                  ),
                  child: Text(
                    FlutterI18n.translate(context, 'tr.login.send_btn'),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  hoverColor: Theme.of(context).colorScheme.primary,
                  overlayColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  onTap: () => context.go('/login'),
                  child: Text(
                    FlutterI18n.translate(context, 'tr.login.login_btn'),
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
