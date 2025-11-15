import 'package:json_annotation/json_annotation.dart';
import 'category.dart';
import 'enums.dart';

part 'employee.g.dart';

@JsonSerializable(explicitToJson: true)
class Employee {
  final String? id;
  final String? firstName;
  final String? lastName;
  final List<Category>? categoriesBlacklist;
  final List<GroupEnum>? groups;
  final String? position;
  final List<NotificationChannel>? notificationChannels;

  Employee({this.id, this.firstName, this.lastName, this.categoriesBlacklist, this.groups, this.position, this.notificationChannels});

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
