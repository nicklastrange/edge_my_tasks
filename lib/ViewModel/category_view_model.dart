import '../Repository/Response/category.dart';

class CategoryViewModel {
  final String name;
  final bool? requiredField;
  final String? notificationPolicy;

  CategoryViewModel({required this.name, this.requiredField, this.notificationPolicy});

  factory CategoryViewModel.fromModel(Category c) => CategoryViewModel(
      name: c.name.toString().split('.').last,
      requiredField: c.requiredField,
      notificationPolicy: c.notificationPolicy);
}
