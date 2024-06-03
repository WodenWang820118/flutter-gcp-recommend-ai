import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> setUserId(args) async {
  try {
    final userId = args[0]['user_id'];
    await FirebaseAnalytics.instance.setUserId(id: userId);
  } catch (e) {
    print(e);
  }
}
