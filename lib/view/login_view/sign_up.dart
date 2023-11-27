import 'package:PaletPoint/utils/widget_helper.dart';
import 'package:PaletPoint/view/widget/app_bar/top_app_bar_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {

  final _key = GlobalKey<FormState>();
  bool selectedValue = false;

  Widget customTextField(BuildContext context, double bottomPadding,String label, bool isPassword) {
    return TextFormField(
      cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.0, bottom: bottomPadding),
        isDense: true,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return FlutterI18n.translate(
              context, 'tr.login.sign_up_page.error_msg');
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopAppBarCentered(
                title: FlutterI18n.translate(context, 'tr.login.sign_up'), 
                backRoute: "null",
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.name'), 
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.password'), 
                      true
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.email'), 
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.firm'),
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      40.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.address'),
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: FlutterI18n.translate(
                            context, 'tr.login.sign_up_page.city'),
                        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(
                          maxHeight: 45,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      items: CITY_LIST.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        // dropdownValue = value.toString();
                      },
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.phone_number'),
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.tax_center'),
                      false
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    customTextField(
                      context, 
                      20.0, 
                      FlutterI18n.translate(context, 'tr.login.sign_up_page.tax_no'),
                      false
                    ),
                    const SizedBox(
                      height: 10
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: selectedValue, 
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            FlutterI18n.translate(context, 'tr.login.sign_up_page.terms_agreement'),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.blue[800],
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue[800],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(140, 30)),
                        ),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.login.sign_up'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}