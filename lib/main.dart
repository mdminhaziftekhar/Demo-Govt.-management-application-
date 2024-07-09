import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/navigation/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(routes: defaultRoutes));
}

extension PreSize on num{
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());

}

extension PresizeMargin on List<num> {

  /// pm = Padding/Margin
  /// [].pm => EdgeInsets.zero
  /// [n].pm => EdgeInsets.all(n)
  /// [n1, n2].pm => EdgeInsets.symmetric(vertical:n1, horizontal:n1)
  /// [n1, n2, n3].pm => EdgeInsets.only(top: n1,horizontal:n2,bottom: n3)
  /// [n1, n2, n3, n4].pm => EdgeInsets.only(top: n1, right: n2,bottom: n3,  left: n4)
  EdgeInsets get pm {
    if (length >= 4) {
      return EdgeInsets.only(
        top: this[0].toDouble(),
        right: this[1].toDouble(),
        bottom: this[2].toDouble(),
        left: this[3].toDouble(),
      );
    } else if (length == 3) {
      return EdgeInsets.only(
        top: this[0].toDouble(),
        left: this[1].toDouble(),
        right: this[1].toDouble(),
        bottom: this[2].toDouble(),
      );
    } else if (length == 2) {
      return EdgeInsets.symmetric(
        vertical: this[0].toDouble(),
        horizontal: this[1].toDouble(),
      );
    } else if (length == 1) {
      return EdgeInsets.all(this[0].toDouble());
    } else {
      return EdgeInsets.zero;
    }
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routes});

  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

