import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderError = StateProvider.autoDispose<String?>((ref) => null);
final majorError = StateProvider.autoDispose<String?>((ref) => null);
final subjectError = StateProvider.autoDispose<String?>((ref) => null);
final registerSubjectError = StateProvider.autoDispose<String?>((ref) => null);
final advisorError = StateProvider.autoDispose<String?>((ref) => null);