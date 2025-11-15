import 'package:json_annotation/json_annotation.dart';
import 'enums.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  final CategoryDto name;
  @JsonKey(name: 'required')
  final bool? requiredField;
  final String? notificationPolicy; // STRICT, MEDIUM, RELAXED

  const Category({required this.name, this.requiredField, this.notificationPolicy});

  factory Category.fromJson(dynamic json) {
    // backend may return category as a simple enum string (e.g. "SECURITY")
    // or as an object { "name": "SECURITY", ... }.
    if (json is String) {
      // map string value to CategoryDto using generated map
      final entry = categoryDtoEnumMap.entries.firstWhere((e) => e.value == json, orElse: () => throw ArgumentError.value(json, 'json', 'Unknown CategoryDto value'));
      return Category(name: entry.key);
    }
    return _$CategoryFromJson(json as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
