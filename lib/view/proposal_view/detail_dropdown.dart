import 'package:flutter/material.dart';

class DetailDropdown extends StatefulWidget {
  const DetailDropdown({Key? key}) : super(key: key);

  @override
  _DetailDropdownState createState() => _DetailDropdownState();
}

class _DetailDropdownState extends State<DetailDropdown> {

  final TextEditingController _deliveryDate = TextEditingController(text: '3');
  final TextEditingController _tgs = TextEditingController(text: "10");
  final TextEditingController _paymentDueDate =  TextEditingController(text: 'Cari Hesap');

  List<DropdownMenuEntry<String>> dropDownMenuPaymentType =
      ["Cari Hesap", "DBS"].map((String value) {
    return DropdownMenuEntry<String>(
      value: value,
      label: value.toString(),
    );
  }).toList();

  List<DropdownMenuEntry<int>> dropDownMenuDate = [3, 5, 7].map((int value) {
    return DropdownMenuEntry<int>(
      value: value,
      label: value.toString(),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _deliveryDate.dispose();
    _tgs.dispose();
    _paymentDueDate.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          height: 300,
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: DropdownMenu<int>(
                  menuHeight: 200,
                  width: 140,
                  enableFilter: false,
                  enableSearch: false,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    constraints: const BoxConstraints(maxHeight: 40),
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ),
                  label: Text(
                    'Teklif Suresi',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  menuStyle: MenuStyle(
                    alignment: AlignmentGeometry.lerp(
                      Alignment.bottomLeft,
                      Alignment.bottomLeft,
                      0.3,
                    ),
                    surfaceTintColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onPrimary),
                  ),
                  dropdownMenuEntries: dropDownMenuDate,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _tgs,
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    label: Text(
                      'Teklif Gecerlilik Suresi',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    constraints: const BoxConstraints(maxHeight: 40),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TextField(
            controller: _tgs,
            cursorColor: Theme.of(context).colorScheme.onBackground,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.onPrimary,
              contentPadding: const EdgeInsets.only(left: 10.0),
              label: Text(
                'Teklif Gecerlilik Suresi',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              constraints: const BoxConstraints(maxHeight: 40),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
