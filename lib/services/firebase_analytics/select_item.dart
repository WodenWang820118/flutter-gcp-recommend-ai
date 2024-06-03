import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> handleSelectItemEvent(args) async {
  final List<AnalyticsEventItem> analyticsItems = [];
  final items = args[0]['params']['ecommerce']['items'];
  for (var item in items) {
    analyticsItems.add(AnalyticsEventItem(
      itemId: item['item_id'],
      itemName: item['item_name'],
      itemCategory: item['item_category'],
      price: item['price'],
      quantity: item['quantity'],
    ));
  }
  try {
    await FirebaseAnalytics.instance.logSelectItem(
      items: analyticsItems,
    );
  } catch (e) {
    logger.log(Level.error, e.toString());
  }
}
