import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> setUserProperty(List<dynamic> args) async {
  try {
    final propertyName = args[0]['name'].toString();
    final propertyValue = args[0]['value'].toString();
    await FirebaseAnalytics.instance.setUserProperty(
      name: propertyName,
      value: propertyValue,
    );
  } catch (e) {
    print(e);
  }
}
