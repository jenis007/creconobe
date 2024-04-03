import 'dart:developer';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubScribeController extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> subscribe({ProductDetails? product}) async {

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product!,
    );
    _inAppPurchase
        .buyNonConsumable(
      purchaseParam: purchaseParam,
    )
        .then((value) {
      log("value----->$value");

    });
  }
}
