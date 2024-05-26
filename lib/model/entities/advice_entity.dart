import 'dart:convert';
/// id : ""
/// adviceSubjectName : ""
/// adviceTopicName : ""
/// adviceDate : ""
/// adviceStatus : ""
/// advisorControlNumber : ""
/// advisorName : ""
/// advisorPhoneNumber : ""
/// advisorMajor : ""
/// studentControlNumber : ""
/// studentName : ""
/// studentPhoneNumber : ""
/// studentMajor : ""
/// adviceAdvisorRating : ""
/// adviceStudentRating : ""
/// adviceEvidenceUrl : ""

AdviceEntity adviceEntityFromJson(String str) => AdviceEntity.fromJson(json.decode(str));
String adviceEntityToJson(AdviceEntity data) => json.encode(data.toJson());

class AdviceEntity {
  String? _id;
  String? _adviceSubjectName;
  String? _adviceTopicName;
  String? _adviceDate;
  String? _adviceStatus;
  String? _advisorControlNumber;
  String? _advisorName;
  String? _advisorPhoneNumber;
  String? _advisorMajor;
  String? _studentControlNumber;
  String? _studentName;
  String? _studentPhoneNumber;
  String? _studentMajor;
  int? _adviceAdvisorRating;
  int? _adviceStudentRating;
  String? _adviceEvidenceUrl;

  String? get id => _id;
  String? get adviceSubjectName => _adviceSubjectName;
  String? get adviceTopicName => _adviceTopicName;
  String? get adviceDate => _adviceDate;
  String? get adviceStatus => _adviceStatus;
  String? get advisorControlNumber => _advisorControlNumber;
  String? get advisorName => _advisorName;
  String? get advisorPhoneNumber => _advisorPhoneNumber;
  String? get advisorMajor => _advisorMajor;
  String? get studentControlNumber => _studentControlNumber;
  String? get studentName => _studentName;
  String? get studentPhoneNumber => _studentPhoneNumber;
  String? get studentMajor => _studentMajor;
  int? get adviceAdvisorRating => _adviceAdvisorRating;
  int? get adviceStudentRating => _adviceStudentRating;
  String? get adviceEvidenceUrl => _adviceEvidenceUrl;

  AdviceEntity({
      String? id, 
      String? adviceSubjectName, 
      String? adviceTopicName, 
      String? adviceDate, 
      String? adviceStatus, 
      String? advisorControlNumber, 
      String? advisorName, 
      String? advisorPhoneNumber, 
      String? advisorMajor, 
      String? studentControlNumber, 
      String? studentName, 
      String? studentPhoneNumber, 
      String? studentMajor, 
      int? adviceAdvisorRating,
      int? adviceStudentRating,
      String? adviceEvidenceUrl,}){
    _id = id;
    _adviceSubjectName = adviceSubjectName;
    _adviceTopicName = adviceTopicName;
    _adviceDate = adviceDate;
    _adviceStatus = adviceStatus;
    _advisorControlNumber = advisorControlNumber;
    _advisorName = advisorName;
    _advisorPhoneNumber = advisorPhoneNumber;
    _advisorMajor = advisorMajor;
    _studentControlNumber = studentControlNumber;
    _studentName = studentName;
    _studentPhoneNumber = studentPhoneNumber;
    _studentMajor = studentMajor;
    _adviceAdvisorRating = adviceAdvisorRating;
    _adviceStudentRating = adviceStudentRating;
    _adviceEvidenceUrl = adviceEvidenceUrl;
  }

  AdviceEntity.fromJson(dynamic json) {
    _id = json['id'];
    _adviceSubjectName = json['adviceSubjectName'];
    _adviceTopicName = json['adviceTopicName'];
    _adviceDate = json['adviceDate'];
    _adviceStatus = json['adviceStatus'];
    _advisorControlNumber = json['advisorControlNumber'];
    _advisorName = json['advisorName'];
    _advisorPhoneNumber = json['advisorPhoneNumber'];
    _advisorMajor = json['advisorMajor'];
    _studentControlNumber = json['studentControlNumber'];
    _studentName = json['studentName'];
    _studentPhoneNumber = json['studentPhoneNumber'];
    _studentMajor = json['studentMajor'];
    _adviceAdvisorRating = json['adviceAdvisorRating'];
    _adviceStudentRating = json['adviceStudentRating'];
    _adviceEvidenceUrl = json['adviceEvidenceUrl'];
  }

  AdviceEntity copyWith({  String? id,
    String? adviceSubjectName,
    String? adviceTopicName,
    String? adviceDate,
    String? adviceStatus,
    String? advisorControlNumber,
    String? advisorName,
    String? advisorPhoneNumber,
    String? advisorMajor,
    String? studentControlNumber,
    String? studentName,
    String? studentPhoneNumber,
    String? studentMajor,
    int? adviceAdvisorRating,
    int? adviceStudentRating,
    String? adviceEvidenceUrl,
  }) => AdviceEntity(  id: id ?? _id,
    adviceSubjectName: adviceSubjectName ?? _adviceSubjectName,
    adviceTopicName: adviceTopicName ?? _adviceTopicName,
    adviceDate: adviceDate ?? _adviceDate,
    adviceStatus: adviceStatus ?? _adviceStatus,
    advisorControlNumber: advisorControlNumber ?? _advisorControlNumber,
    advisorName: advisorName ?? _advisorName,
    advisorPhoneNumber: advisorPhoneNumber ?? _advisorPhoneNumber,
    advisorMajor: advisorMajor ?? _advisorMajor,
    studentControlNumber: studentControlNumber ?? _studentControlNumber,
    studentName: studentName ?? _studentName,
    studentPhoneNumber: studentPhoneNumber ?? _studentPhoneNumber,
    studentMajor: studentMajor ?? _studentMajor,
    adviceAdvisorRating: adviceAdvisorRating ?? _adviceAdvisorRating,
    adviceStudentRating: adviceStudentRating ?? _adviceStudentRating,
    adviceEvidenceUrl: adviceEvidenceUrl ?? _adviceEvidenceUrl,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['adviceSubjectName'] = _adviceSubjectName;
    map['adviceTopicName'] = _adviceTopicName;
    map['adviceDate'] = _adviceDate;
    map['adviceStatus'] = _adviceStatus;
    map['advisorControlNumber'] = _advisorControlNumber;
    map['advisorName'] = _advisorName;
    map['advisorPhoneNumber'] = _advisorPhoneNumber;
    map['advisorMajor'] = _advisorMajor;
    map['studentControlNumber'] = _studentControlNumber;
    map['studentName'] = _studentName;
    map['studentPhoneNumber'] = _studentPhoneNumber;
    map['studentMajor'] = _studentMajor;
    map['adviceAdvisorRating'] = _adviceAdvisorRating;
    map['adviceStudentRating'] = _adviceStudentRating;
    map['adviceEvidenceUrl'] = _adviceEvidenceUrl;
    return map;
  }

}