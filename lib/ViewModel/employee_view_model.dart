import '../Repository/Response/employee.dart';

class EmployeeViewModel {
  final String? id;
  final String displayName;
  final String? position;
  final List<String> groupNames;

  EmployeeViewModel({this.id, required this.displayName, this.position, required this.groupNames});

  factory EmployeeViewModel.fromModel(Employee e) => EmployeeViewModel(
        id: e.id,
  displayName: ('${e.firstName ?? ''} ${e.lastName ?? ''}').trim(),
        position: e.position,
        groupNames: e.groups?.map((g) => g.toString().split('.').last).toList() ?? [],
      );
}
