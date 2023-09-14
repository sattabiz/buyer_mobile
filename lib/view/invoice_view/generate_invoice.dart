import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/app_bar/dialog_app_bar.dart';

class GenerateInvoice extends ConsumerStatefulWidget {
  const GenerateInvoice ({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends ConsumerState<GenerateInvoice> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          DialogAppBar(
            title: FlutterI18n.translate(context, 'tr.ready_for_ship.invoice_info'),
            route: '/invoice_ready',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.ready_for_ship.payment'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}