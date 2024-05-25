import 'dart:convert';

/// firstname : ""
/// lastname1 : ""
/// lastname2 : ""
/// gender : ""
/// phoneNumber : ""
/// major : ""
/// controlNumber : ""
/// photoUrl : ""
/// type : ""

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));
String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  String? _type;
  String? _firstname;
  String? _lastname1;
  String? _lastname2;
  String? _gender;
  String? _phoneNumber;
  String? _major;
  String? _controlNumber;
  String? _email;
  String? _photoUrl;

  String? get type => _type;
  String? get firstname => _firstname;
  String? get lastname1 => _lastname1;
  String? get lastname2 => _lastname2;
  String? get gender => _gender;
  String? get phoneNumber => _phoneNumber;
  String? get major => _major;
  String? get controlNumber => _controlNumber;
  String? get email => _email;
  String? get photoUrl => _photoUrl;

  UserEntity({
    String? type,
    String? firstname,
    String? lastname1,
    String? lastname2,
    String? gender,
    String? phoneNumber,
    String? major,
    String? controlNumber,
    String? email,
    String? photoUrl
  })
  {
    _type = type;
    _firstname = firstname;
    _lastname1 = lastname1;
    _lastname2 = lastname2;
    _gender = gender;
    _phoneNumber = phoneNumber;
    _major = major;
    _controlNumber = controlNumber;
    _email = email;
    _photoUrl = photoUrl;
  }

  UserEntity.fromJson(dynamic json) {
    _type = json['type'];
    _firstname = json['firstname'];
    _lastname1 = json['lastname1'];
    _lastname2 = json['lastname2'];
    _gender = json['gender'];
    _phoneNumber = json['phoneNumber'];
    _major = json['major'];
    _controlNumber = json['controlNumber'];
    _email = json['email'];
    _photoUrl = json['photoUrl'];
  }

  UserEntity copyWith({
    String? type,
    String? firstname,
    String? lastname1,
    String? lastname2,
    String? gender,
    String? phoneNumber,
    String? major,
    String? controlNumber,
    String? email,
    String? photoUrl
  }) => UserEntity(
    type: type ?? _type,
    firstname: firstname ?? _firstname,
    lastname1: lastname1 ?? _lastname1,
    lastname2: lastname2 ?? _lastname2,
    gender: gender ?? _gender,
    phoneNumber: phoneNumber ?? _phoneNumber,
    major: major ?? _major,
    controlNumber: controlNumber ?? _controlNumber,
    email: email ?? _email,
    photoUrl: photoUrl ?? _photoUrl
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['firstname'] = _firstname;
    map['lastname1'] = _lastname1;
    map['lastname2'] = _lastname2;
    map['gender'] = _gender;
    map['phoneNumber'] = _phoneNumber;
    map['major'] = _major;
    map['controlNumber'] = _controlNumber;
    map['email'] = _email;
    map['photoUrl'] = _photoUrl;
    return map;
  }
}