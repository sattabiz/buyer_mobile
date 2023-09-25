import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      'Eposta Adresi',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 40),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      'Sifre',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    constraints:
                        const BoxConstraints(maxWidth: 300, maxHeight: 40),
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
                  onPressed: () {
                    context.go('/home');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                    fixedSize: MaterialStateProperty.all<Size>(const Size(140, 30)),
                  ),
                  child: Text(
                    'Giris Yap',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Sifremi Unuttum',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.shadow,
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
