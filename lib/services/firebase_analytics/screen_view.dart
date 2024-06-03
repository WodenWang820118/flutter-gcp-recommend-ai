import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> handleScreenViewEvent(args) async {
  try {
    await FirebaseAnalytics.instance.logScreenView(
      screenName: args[0]['params']['page_title'],
    );
  } catch (e) {
    logger.log(Level.error, e.toString());
  }
}
