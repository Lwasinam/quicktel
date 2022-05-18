import 'package:flutter/material.dart';
import 'package:quicktel/nav.dart';
import 'package:quicktel/presentation/home.dart';
import 'package:quicktel/presentation/login.dart';
import 'package:quicktel/presentation/signup.dart';
import 'package:quicktel/presentation/welcome.dart';
import 'package:quicktel/routes.dart';
import 'package:graphql/client.dart';
import "package:graphql_flutter/graphql_flutter.dart";
import "package:firebase_core/firebase_core.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink link = HttpLink("https://api.timart.com.ng/graphql");

    ValueNotifier<GraphQLClient> client =
        ValueNotifier(GraphQLClient(cache: GraphQLCache(), link: link));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: getInitialRoute(),
        onGenerateRoute: (route) => getRoute(route),
      ),
    );
  }

  String getInitialRoute() => AppRoutes.welcome;

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return buildRoute(Welcome(), settings: settings);
      case AppRoutes.login:
        // Arguments are mandatory
        // final LoginArguments args = settings.arguments;

        return buildRoute(Login(), settings: settings);
      case AppRoutes.signup:
        // // Arguments are not mandatory => we set some default arguments
        // final defaultArgs = HomeArguments(userToken: null);
        // final HomeArguments args = settings.arguments ?? defaultArgs;

        return buildRoute(SignUp(), settings: settings);
      case AppRoutes.home:
        // Arguments are mandatory
        // final LoginArguments args = settings.arguments;

        return buildRoute(Home(), settings: settings);
        case AppRoutes.navbar:
        // Arguments are mandatory
        // final LoginArguments args = settings.arguments;

        return buildRoute(NavBar(), settings: settings);  
      default:
        return null;
    }
  }

  MaterialPageRoute buildRoute(Widget child, {RouteSettings? settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => child,
      );
}
