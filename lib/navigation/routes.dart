

import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';

/// default routes of this application
Map<String, WidgetBuilder> defaultRoutes = <String, WidgetBuilder> {
  '/': (context) =>  HomeScreen(),
  '/dashboard': (context) =>  DashboardScreen(),
  '/calendar': (context) =>  CalendarScreen(),
};