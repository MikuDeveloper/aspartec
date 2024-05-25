import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderError = StateProvider.autoDispose<String?>((ref) => null);
final majorError = StateProvider.autoDispose<String?>((ref) => null);