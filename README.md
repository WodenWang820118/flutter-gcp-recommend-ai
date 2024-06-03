# GCP: Retail Recommendation AI

On the browser, we can utilize the [pixel and the Google Tag Manager(GTM)](https://cloud.google.com/retail/docs/record-events) to send user event data back to the recommendation AI for real-time recommendation. However, in terms of apps, there's no obvious solution available with SDKs. The project uses the [API](https://cloud.google.com/retail/docs/reference/rest/v2/projects.locations.catalogs.userEvents/write) to achieve the same goal.

## Architecture

- The Flutter app comprises a web view widget that loads up the website for prototyping. The events via [JavaScript handler](https://firebase.google.com/docs/analytics/webview?platform=android) are handled accordingly. Please refer to the [ng gtm integration sample repo](https://github.com/WodenWang820118/ng-gtm-integration-sample) for detailed information.
- The app uses the [inappwebview](https://pub.dev/packages/flutter_inappwebview) plugin to load the website with the specific URL.

## Implementation

Specifically, after configuring a Firebase project with a billed, API-enabled GCP project, the project uses the service account to send the data with the [required schema](https://cloud.google.com/retail/docs/user-events#add-to-cart). Please create an `assets/.env` file with your authorized key.

```dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/retail/v2.dart' as retail;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

const String projectId = 'dummy-apps-418906';

// reference: https://cloud.google.com/retail/docs/reference/rest/v2/projects.locations.catalogs.userEvents#UserEvent
Future<void> postUserEvent(Map<String, dynamic> eventData) async {
  await dotenv.load(fileName: 'assets/.env');
  // reference: https://cloud.google.com/retail/docs/record-events
  // e.g. https://retail.googleapis.com/v2/projects/PROJECT_ID/locations/global/catalogs/default_catalog/userEvents:write
  const url =
      'https://retail.googleapis.com/v2/projects/$projectId/locations/global/catalogs/default_catalog/userEvents:write';
  final credential = {
    "type": "service_account",
    "project_id": projectId,
    "private_key_id": "fd51ff4e0db521dfc50d94e478c764892a6c93aa",
    "private_key": dotenv.env['GCP_RETAIL_PRIVATE_KEY'],
    "client_email":
        "firebase-adminsdk-ozevc@dummy-apps-418906.iam.gserviceaccount.com",
    "client_id": "104461087345172893903",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ozevc%40dummy-apps-418906.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };
  final accountCredentials = ServiceAccountCredentials.fromJson(credential);

  // Obtain an authenticated HTTP client
  final scopes = [retail.CloudRetailApi.cloudPlatformScope];
  final client = await clientViaServiceAccount(accountCredentials, scopes);

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${client.credentials.accessToken.data}',
  };
  final body = json.encode(eventData);

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    logger.log(Level.info, 'User event posted successfully');
    logger.log(Level.info, 'Response body: ${response.body}');
  } else {
    logger.log(
        Level.error, 'Failed to post user event: ${response.statusCode}');
    logger.log(Level.error, 'Response body: ${response.body}');
  }
}

Future<void> handleAddToCartEvent(args) async {
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
    await FirebaseAnalytics.instance.logAddToCart(
      currency: args[0]['params']['ecommerce']['currency'],
      value: args[0]['params']['ecommerce']['value'].toDouble(),
      items: analyticsItems,
    );

    final userEvent = {
      'eventType': 'add-to-cart',
      'visitorId': 'visitor-12345', // TODO: Replace with your actual visitor ID
      'productDetails': {
        'product': {
          'id': analyticsItems[0].itemId,
        },
        'quantity': analyticsItems[0].quantity,
      },
    };

    await postUserEvent(userEvent);
  } catch (e) {
    logger.log(Level.error, e.toString());
  }
}
```

Please let me know if there is anything that can be further improved.
