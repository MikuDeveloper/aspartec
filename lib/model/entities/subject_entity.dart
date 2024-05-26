import 'dart:convert';

/// id : ""
/// subjectName : ""
/// advisorControlNumber : ""
/// advisorMajor
/// advisorName : ""
/// advisorPhoneNumber : ""
/// advisorEmail : ""

SubjectEntity subjectEntityFromJson(String str) => SubjectEntity.fromJson(json.decode(str));
String subjectEntityToJson(SubjectEntity data) => json.encode(data.toJson());

class SubjectEntity {
  String? _id;
  String? _subjectName;
  String? _advisorControlNumber;
  String? _advisorMajor;
  String? _advisorName;
  String? _advisorPhoneNumber;
  String? _advisorEmail;

  String? get id => _id;
  String? get subjectName => _subjectName;
  String? get advisorControlNumber => _advisorControlNumber;
  String? get advisorMajor => _advisorMajor;
  String? get advisorName => _advisorName;
  String? get advisorPhoneNumber => _advisorPhoneNumber;
  String? get advisorEmail => _advisorEmail;

  SubjectEntity({
    String? id,
    String? subjectName,
    String? advisorControlNumber,
    String? advisorMajor,
    String? advisorName,
    String? advisorPhoneNumber,
    String? advisorEmail
  }){
    _id = id;
    _subjectName = subjectName;
    _advisorControlNumber = advisorControlNumber;
    _advisorMajor = advisorMajor;
    _advisorName = advisorName;
    _advisorPhoneNumber = advisorPhoneNumber;
    _advisorEmail = advisorEmail;
  }

  SubjectEntity.fromJson(dynamic json) {
    _id = json['id'];
    _subjectName = json['subjectName'];
    _advisorControlNumber = json['advisorControlNumber'];
    _advisorMajor = json['advisorMajor'];
    _advisorName = json['advisorName'];
    _advisorPhoneNumber = json['advisorPhoneNumber'];
    _advisorEmail = json['advisorEmail'];
  }

  SubjectEntity copyWith({
    String? id,
    String? subjectName,
    String? advisorControlNumber,
    String? advisorMajor,
    String? advisorName,
    String? advisorPhoneNumber,
    String? advisorEmail,
  }) => SubjectEntity(
    id: id ?? _id,
    subjectName: subjectName ?? _subjectName,
    advisorControlNumber: advisorControlNumber ?? _advisorControlNumber,
    advisorMajor: advisorMajor ?? _advisorMajor,
    advisorName: advisorName ?? _advisorName,
    advisorPhoneNumber: advisorPhoneNumber ?? _advisorPhoneNumber,
    advisorEmail: advisorEmail ?? _advisorEmail,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subjectName'] = _subjectName;
    map['advisorControlNumber'] = _advisorControlNumber;
    map['advisorMajor'] = _advisorMajor;
    map['advisorName'] = _advisorName;
    map['advisorPhoneNumber'] = _advisorPhoneNumber;
    map['advisorEmail'] = _advisorEmail;
    return map;
  }
}