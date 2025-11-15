import 'package:edge_my_tasks/View/app_view.dart';
import 'package:edge_my_tasks/View/create_event.dart';
import 'package:edge_my_tasks/View/employee_management.dart';
import 'package:edge_my_tasks/View/preferences.dart';
import 'package:edge_my_tasks/View/statistics.dart';
import 'package:flutter/material.dart';

void main() {
		runApp(MaterialApp(
			theme: ThemeData(fontFamily: 'Arial'),
			initialRoute: '/dashboard',
			routes: {
				// map top-level routes to AppView with a role flag.
				// By default the dashboard route shows the admin view.
				'/dashboard': (ctx) => const AppView(isAdmin: true),
				// other routes can also render AppView; here we keep them simple
				'/events': (ctx) => const CreateEventPage(),
				'/employees': (ctx) => const EmployeeManagementPage(),
				'/statistics': (ctx) => const StatisticsPage(),
				// '/employee' is the employee-facing home
				'/employee': (ctx) => const AppView(isAdmin: false),
				'/preferences': (ctx) => const PreferencesPage(),
			},
		));
}
