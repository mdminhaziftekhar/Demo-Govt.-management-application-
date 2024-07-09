import 'package:objectbox/objectbox.dart';


@Entity()
class DataEntity {
  @Id(assignable: false)
  int? id;
  String test;

  DataEntity({
    this.id,
    required this.test,
  }):super();

  DataEntity.fromMap(Map<String, dynamic> map)
      :this (
    test: map['test'] ?? '',
  );

  @override
  Map<String, dynamic> toJson() => {
    // "id": customerId,
  };

}