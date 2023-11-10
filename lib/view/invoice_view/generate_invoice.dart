
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../model/address_model.dart';
import '../../view_model/generate_multi_order_controller/create_multi_order_invoice_view_model.dart';
import '../../view_model/get_address_view_model.dart';
import '../widget/app_bar/dialog_app_bar.dart';

  enum MenuEntry {
    cari,
    dbs
  }

  class InvoiceTable {
  String? invoiceNo;
  String invoiceDate = DateFormat('dd-MM-yyyy').format(DateTime.now().add(const Duration(days: 3)));
  String shipmentDate = DateFormat('dd-MM-yyyy').format(DateTime.now().add(const Duration(days: 3)));
  String? waybillNo;
  AddressModel? contactInformationId;
  String? carrier;
  String? tracking;

  InvoiceTable(
      {
        this.invoiceNo,
        this.waybillNo,
        this.contactInformationId,
        this.carrier,
        this.tracking
      }
    );
  @override
  String toString() {
    return 'InvoiceTable(invoiceNo: $invoiceNo, invoiceDate:$invoiceDate,shipmentDate:$shipmentDate, waybillNo:$waybillNo, contactInformationId:$contactInformationId, carrier:$carrier, tracking:$tracking,  )';
  }
}

final invoiceTableProvider = StateProvider<InvoiceTable>((ref) {
  return InvoiceTable();
});

class GenerateInvoice extends ConsumerStatefulWidget {
  const GenerateInvoice ({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenerateInvoiceState();
}

class _GenerateInvoiceState extends ConsumerState<GenerateInvoice> {
  late String? selectedValue;
  final TextEditingController _textEditingController = TextEditingController();
  //waybill_no
  final TextEditingController _waybillNo = TextEditingController();
  final TextEditingController _carrier = TextEditingController();
  final TextEditingController _tracking = TextEditingController();
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
  void dispose() {
    _textEditingController.dispose();
    _waybillNo.dispose();
    _carrier.dispose();
    _tracking.dispose();
    _invoiceDate.dispose();
    _shipDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adressListAsyncValue = ref.watch(getAddressFutureProvider);
    final _key = GlobalKey<FormState>();
    return adressListAsyncValue.when(
      data: (data) {
        String? dropdownValue = ref.watch(invoiceTableProvider).contactInformationId!.address;
        return Material(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DialogAppBar(
                    title: FlutterI18n.translate(context, 'tr.ready_for_ship.invoice_info'),
                    route: '/invoice_ready',
                    providerName: 'createMultiOrderInvoiceProvider',
                    buttonName: FlutterI18n.translate(context, 'tr.invoice.send'),
                    onPressed: () async{
                      if (_key.currentState!.validate()) {
                        ref.watch(createMultiOrderInvoiceProvider);
                        context.go('/invoice');
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _textEditingController,
                          cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          decoration: InputDecoration(
                            // constraints: const BoxConstraints(
                            //   maxHeight: 45,
                            // ),
                            contentPadding: const EdgeInsets.only(left: 10.0, bottom: 20),
                            isDense: true,
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
                          /* onTap: () {
                            ref.read(invoiceTableProvider).contactInformationId = data[0].id ;
                          }, */
                          onChanged: (value) {
                            ref.read(invoiceTableProvider.notifier).state.invoiceNo = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return FlutterI18n.translate(context, 'tr.validations.invoice_no');
                            }
                            return null;
                          },
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
                                  ref.read(invoiceTableProvider.notifier).state.invoiceDate = _invoiceDate.text;
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
                              ref.read(invoiceTableProvider.notifier).state.shipmentDate = _shipDate.text;
                            } else {}
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _waybillNo,
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
                          onChanged: (value) {
                            ref.read(invoiceTableProvider.notifier).state.waybillNo = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: dropdownValue,
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
                          items: data.map<DropdownMenuItem <String>>((AddressModel value) {
                            return DropdownMenuItem<String>(
                              value: value.address,
                              child: Text(
                                value.address!,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // dropdownValue = value.toString();
                          AddressModel address = data.firstWhere((element) => element.address == value);
                          ref.read(invoiceTableProvider.notifier).state.contactInformationId = address ;
                          setState(() {
                          });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _carrier,
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
                          onChanged: (value) {
                            ref.read(invoiceTableProvider.notifier).state.carrier = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _tracking,
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
                          onChanged: (value) {
                            ref.read(invoiceTableProvider.notifier).state.tracking = value;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Container(),
      error: (error, stack) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
           context.go('/login');  
         });
         return Text('An error occurred: $error');
      },
    );
  }

}