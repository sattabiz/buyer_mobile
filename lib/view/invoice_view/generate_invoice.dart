import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widget/app_bar/dialog_app_bar.dart';

  enum MenuEntry {
    cari,
    dbs
  }


class GenerateInvoice extends ConsumerStatefulWidget {
  const GenerateInvoice ({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends ConsumerState<GenerateInvoice> {

  final TextEditingController _invoiceDate = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(DateTime.now().add(const Duration(days: 3))),
  );

  final TextEditingController _shipDate = TextEditingController(
    text: DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(const Duration(days: 3))),
  );

  final List<String> list = <String>['Cari Hesap', 'DBS', 'Three', 'Four'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = list.first;
    return Material(
      child: Column(
        children: [
          DialogAppBar(
            title: FlutterI18n.translate(context, 'tr.ready_for_ship.invoice_info'),
            route: '/invoice_ready',
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.invoice_no'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _invoiceDate,
                    readOnly: true,
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.invoice_date'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                            _invoiceDate.text = formattedDate; // <- Bu satır eklenmeli
                      } else {}
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _shipDate,
                    readOnly: true,
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.ship_date'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        _shipDate.text =
                            formattedDate; // <- Bu satır eklenmeli
                      } else {}
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.waybill_no'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.address'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        onTap: () {
                          setState(() {
                            debugPrint(value);
                            dropdownValue = value;
                            debugPrint(dropdownValue);
                          });
                        },
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                    },
                    onSaved: (value) {
                      dropdownValue = value.toString();
                    },
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.tracking'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 45,
                      ),
                      labelText: FlutterI18n.translate(
                          context, 'tr.invoice.generate_invoice.tracking_no'),
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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