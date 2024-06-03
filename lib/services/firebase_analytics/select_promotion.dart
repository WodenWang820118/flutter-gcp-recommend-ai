import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> handleSelectPromotionEvent(args) async {
  final List<AnalyticsEventItem> analyticsItems = [];
  final items = args[0]['params']['ecommerce']['items'];
  for (var item in items) {
    analyticsItems.add(AnalyticsEventItem(
      itemId: item['item_id'],
      itemName: item['item_name'],
    ));
  }

  try {
    await FirebaseAnalytics.instance.logSelectPromotion(
      creativeName: args[0]['params']['ecommerce']['creative_name'],
      creativeSlot: args[0]['params']['ecommerce']['creative_slot'],
      promotionId: args[0]['params']['ecommerce']['promotion_id'],
      promotionName: args[0]['params']['ecommerce']['promotion_name'],
      items: analyticsItems,
    );
  } catch (e) {
    logger.log(Level.error, e.toString());
  }
}
