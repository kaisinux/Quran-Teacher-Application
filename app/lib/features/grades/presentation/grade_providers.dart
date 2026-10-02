import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/errors/app_error.dart';
import '../../../core/utils/date_only.dart';
import '../../auth/domain/app_user.dart';
import '../data/grades_repository.dart';

/// Local id of the teacher's session for [date] (downloaded if needed).
final openSessionProvider = FutureProvider.family<String, DateOnly>((ref, date) {
  final user = ref.watch(currentUserProvider);
  if (user is! Teacher) throw const AppException(AppErrorCode.notAuthorized);
  return ref.read(gradesRepositoryProvider).openSession(user.groupId, date);
});
