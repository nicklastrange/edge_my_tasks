import 'package:edge_my_tasks/View/admin_dashboard.dart';
import 'package:edge_my_tasks/View/employee_home.dart';
import 'package:flutter/material.dart';

/// Minimal AppView: renders either the admin or employee root view.
/// The app's larger navigation (sidebar, routing) should be handled
/// at a higher level if needed. Keeping this small prevents
/// duplication and follows the user's intent.
class AppView extends StatelessWidget {
  final bool isAdmin;
  const AppView({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return isAdmin ? const AdminDashboardView() : const EmployeeHomeView(userId: "6917e7c99f233e02e82cfa4e");
  }
}
