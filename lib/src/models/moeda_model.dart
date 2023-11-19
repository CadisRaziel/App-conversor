import 'dart:convert';

class MoedaModel {
  final String name;
  final String code;

  MoedaModel({
    required this.name,
    required this.code,
  });

  factory MoedaModel.init(){
    return MoedaModel(name: '', code: '');
  }

  MoedaModel copyWith({
    String? name,
    String? code,
  }) {
    return MoedaModel(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
    };
  }

  factory MoedaModel.fromMap(Map<String, dynamic> map) {
    return MoedaModel(
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoedaModel.fromJson(String source) => MoedaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MoedaModel(name: $name, code: $code)';

  @override
  bool operator ==(covariant MoedaModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
