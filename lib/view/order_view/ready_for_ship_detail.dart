import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../model/order_model.dart';
import '../../view_model/create_shipment_record_view_model.dart';
import '../../view_model/get_order_view_model.dart';
import '../widget/app_bar/dialog_app_bar.dart';

final createShipmentOrderIdProvider = StateProvider<int?>((ref) => 0);

class ProductProposalsModel{
  int? productsProposalId;
  int? readyAmount;


  ProductProposalsModel({this.productsProposalId, this.readyAmount});
  @override
  String toString() {
    return 'ProductProposalsModel(productsProposalId: $productsProposalId, readyAmount:$readyAmount)';
  }
  ProductProposalsModel copyWith({int? readyAmount,int? productsProposalId}) {
    return ProductProposalsModel(
      readyAmount: readyAmount,
      productsProposalId: productsProposalId
    );
  }
}

final createShipmentFormProvider =
    StateNotifierProvider<FormItemModelNotifier, List<ProductProposalsModel>>((ref) {
  return FormItemModelNotifier();
});

class FormItemModelNotifier extends StateNotifier<List<ProductProposalsModel>> {
  FormItemModelNotifier() : super([]);


   void addFormItem(ProductProposalsModel productProposal,) {    
    state = [...state, productProposal];
  }

  void updateReadyAmount(int productProposalId, int readyAmount){
    state = [
      for(final productProposal in state)
        if(productProposal.productsProposalId == productProposalId)
          productProposal.copyWith(readyAmount: readyAmount, productsProposalId:productProposalId)
        else
         productProposal

    ];
  }

  void removeAllFormItems(){
    state = [];
  }

}



class ReadyForShipDetail extends ConsumerStatefulWidget {
  const ReadyForShipDetail({ Key? key }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadyForShipDetailState();
}

class _ReadyForShipDetailState extends ConsumerState<ReadyForShipDetail> {
  ScrollController _scrollController = ScrollController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OrderModel? orderAsyncValue = ref.watch(orderIndexProvider);
    return Material(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogAppBar(
              title: FlutterI18n.translate(context, 'tr.ready_for_ship.title'),
              route: '/order_detail',
              providerName: 'createShipmentPostProvider',
              buttonName: FlutterI18n.translate(context, 'tr.order.save'),
              onPressed: () {
                if (_key.currentState!.validate()) {
                  ref.watch(createShipmentPostProvider);
                  context.go('/order');
                }
              },
            ),
            Flexible(
              child: ListView.builder(
                itemCount: orderAsyncValue!.products!.length,
                shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            orderAsyncValue.products![index].name!,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          margin: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value!.isEmpty || value == '0') {
                            //     return 'Lütfen bir sayı girin.';
                            //   }else if(int.parse(value) != 0){
                            //     return "Lütfen sıfır haricinde bir sayı girin.";
                            //   }
                            // },
                            cursorColor: Theme.of(context).colorScheme.onBackground,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.onPrimary,
                              contentPadding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 15.0),
                              isDense: true,
                              label: Text(
                                orderAsyncValue.products![index].sendedAmount == null 
                                ? "${orderAsyncValue.products![index].amount} ${orderAsyncValue.products![index].unit}"  
                                : "${orderAsyncValue.products![index].amount!-orderAsyncValue.products![index].sendedAmount!} ${orderAsyncValue.products![index].unit}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              suffix: Text(orderAsyncValue.products![index].unit!),
                              suffixStyle: Theme.of(context).textTheme.bodySmall,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            onChanged: (value) async{
                              ref.read(createShipmentFormProvider.notifier).updateReadyAmount(orderAsyncValue.products![index].productProposalId!, int.parse(value));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30.0),
              child: Text(
                FlutterI18n.translate(context, 'tr.ready_for_ship.information'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}