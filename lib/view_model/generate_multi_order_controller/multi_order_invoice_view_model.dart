import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/shipment_model.dart';


final multiOrderProvider = StateNotifierProvider<FormItemModelNotifier, List<Product>>((ref) {
  return FormItemModelNotifier();
});

class FormItemModelNotifier extends StateNotifier<List<Product>> {
  FormItemModelNotifier() : super([]);


   void addFormItem(Product shipmentProduct,) {    
    state = [...state, shipmentProduct];

  }

  void removeFormItem(int productsProposalShipmentId) {
    state = [
      for (final shipmentProduct in state)
        if (shipmentProduct.productsProposalShipmentId != productsProposalShipmentId) shipmentProduct,
    ];
  }


  void readShippedAmount(int productsProposalShipmentId, double shippedAmount) {
    state = [
      for (final shipmentProduct in state)
        if (shipmentProduct.productsProposalShipmentId != productsProposalShipmentId && shipmentProduct.productsProposalShipmentId != null)
          shipmentProduct.copyWith(invoiceAmount: shippedAmount)
        else
          shipmentProduct
    ];
  }


  void removeAllFormItems(){
    state = [];
  }

}




