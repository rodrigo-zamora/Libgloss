import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/blocs.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/models/ModelProvider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  // Ensure that the WidgetsBinding is initialized before calling
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Run the initialization splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await configureAmplify();

  // Run the app with the BlocProviders
  runApp(BlocSettings.getBlocProviders(const Libgloss()));

  // Remove the initialization splash screen
  FlutterNativeSplash.remove();
}

class Libgloss extends StatefulWidget {
  const Libgloss({super.key});

  @override
  State<Libgloss> createState() => _LibglossState();
}

Future<void> configureAmplify() async {
  // Get the amplifyconfig.json file
  final amplifyconfig = await rootBundle.loadString('amplifyconfig.json');
  final datastorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  await Amplify.addPlugins([AmplifyAuthCognito(), datastorePlugin]);
  await Amplify.configure(amplifyconfig);
}

class _LibglossState extends State<Libgloss> {
  bool amplifyConfigured = false;

  Future<void> saveUserToken() async {
    // TODO: Get the user token and save it to the database
  }

  @override
  void initState() {
    super.initState();
    saveUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
      ),
      home: Routes.getRoute(Routes.home),
    );
  }
}
