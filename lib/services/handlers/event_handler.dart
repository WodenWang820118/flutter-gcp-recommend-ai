import 'package:firebase_analytics/firebase_analytics.dart';
import '../firebase_analytics/add_payment_info.dart';
import '../firebase_analytics/add_shipping_info.dart';
import '../firebase_analytics/begin_checkout.dart';
import '../firebase_analytics/purchase.dart';
import '../firebase_analytics/refund.dart';
import '../firebase_analytics/remove_from_cart.dart';
import '../firebase_analytics/screen_view.dart';
import '../firebase_analytics/view_item.dart';
import '../firebase_analytics/view_item_list.dart';
import '../firebase_analytics/add_to_cart.dart';
import '../firebase_analytics/select_item.dart';
import '../firebase_analytics/select_promotion.dart';
import '../firebase_analytics/view_cart.dart';
import '../firebase_analytics/view_promotion.dart';

getParameters(List<dynamic> args) {
  final parameters = {};
  args[0]['params'].forEach((key, value) {
    if (key != 'items') {
      parameters[key] = value;
    }
  });
  return parameters;
}

Future<void> handleEvent(List<dynamic> args) async {
  print(args);
  final eventName = args[0]['name'].toString();
  final parameters = getParameters(args);

  switch (eventName) {
    case 'page_view':
      await handleScreenViewEvent(args);
      break;
    case 'view_promotion':
      await handleViewPromotionEvent(args);
      break;
    case 'select_promotion':
      await handleSelectPromotionEvent(args);
      break;
    case 'view_item_list':
      await handleViewItemListEvent(args);
      break;
    case 'select_item':
      await handleSelectItemEvent(args);
      break;
    case 'view_item':
      await handleViewItemEvent(args);
      break;
    case 'add_to_cart':
      await handleAddToCartEvent(args);
      break;
    case 'view_cart':
      await handleViewCartEvent(args);
      break;
    case 'remove_from_cart':
      await handleRemoveFromCartEvent(args);
      break;
    case 'begin_checkout':
      await handleBeginCheckoutEvent(args);
      break;
    case 'add_shipping_info':
      await handleAddShippingInfoEvent(args);
      break;
    case 'add_payment_info':
      await handleAddPaymentInfoEvent(args);
      break;
    case 'purchase':
      await handlePurchaseEvent(args);
      break;
    case 'refund':
      await handleRefundEvent(args);
      break;
    default:
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          ...parameters,
        },
      );
  }
}
