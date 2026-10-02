import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/formatters.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../domain/grade_validator.dart';
import '../../domain/student_grade.dart';

/// Phone layout: one compact line per student, no horizontal scroll.
///
/// Élève | Hifz | Tajwid | Prés. | Discipline
class CompactGradesList extends StatelessWidget {
  const CompactGradesList({
    super.key,
    required this.grades,
    this.onTap,
    this.onTogglePresence,
    this.shrinkWrap = false,
  });

  final List<StudentGrade> grades;
  final ValueChanged<int>? onTap;

  /// `null` = read-only.
  final ValueChanged<int>? onTogglePresence;
  final bool shrinkWrap;

  static const _gradeWidth = 52.0;
  static const _presenceWidth = 48.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final header = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
    final list = ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemCount: grades.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) => _Row(
        grade: grades[index],
        onTap: onTap == null ? null : () => onTap!(index),
        onTogglePresence:
            onTogglePresence == null ? null : () => onTogglePresence!(index),
      ),
    );
    return Column(
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Material(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              const SizedBox(width: 28),
              Expanded(child: Text(l10n.fieldStudent, style: header)),
              _HeaderCell(l10n.fieldHifz, _gradeWidth, header),
              _HeaderCell(l10n.fieldTajwid, _gradeWidth, header),
              _HeaderCell(l10n.fieldPresence, _presenceWidth, header),
              _HeaderCell(l10n.fieldDiscipline, _gradeWidth, header),
            ]),
          ),
        ),
        if (shrinkWrap) list else Expanded(child: list),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, this.width, this.style);
  final String text;
  final double width;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        child: Text(text,
            style: style,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      );
}

class _Row extends StatelessWidget {
  const _Row({required this.grade, this.onTap, this.onTogglePresence});

  final StudentGrade grade;
  final VoidCallback? onTap;
  final VoidCallback? onTogglePresence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    final issues = GradeValidator.validateStudent(grade);
    final blocking = issues.any((i) => i.isBlocking);
    final warning = issues.isNotEmpty;
    final lowDiscipline = GradeValidator.requiresDisciplineRemark(grade);
    final style = Theme.of(context).textTheme.bodyLarge;

    Widget gradeCell(double? value, {bool alert = false}) => SizedBox(
          width: CompactGradesList._gradeWidth,
          child: Text(
            grade.isPresent ? formatGrade(context, value) : '--',
            textAlign: TextAlign.center,
            style: style?.copyWith(
              color: alert ? colors.danger : null,
              fontWeight: alert ? FontWeight.bold : null,
            ),
          ),
        );

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(children: [
            SizedBox(
              width: 28,
              child: blocking
                  ? Icon(Icons.error, size: 20, color: colors.danger,
                      semanticLabel: l10n.summaryBlocking)
                  : warning
                      ? Icon(Icons.warning_amber_rounded, size: 20,
                          color: colors.warning,
                          semanticLabel: l10n.issueNotEvaluated)
                      : null,
            ),
            Expanded(
              child: Text(grade.studentName,
                  style: style, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            gradeCell(grade.hifz),
            gradeCell(grade.tajwid),
            SizedBox(
              width: CompactGradesList._presenceWidth,
              child: IconButton(
                tooltip: grade.isPresent ? l10n.present : l10n.absent,
                onPressed: onTogglePresence,
                icon: Icon(
                  grade.isPresent ? Icons.check_box : Icons.disabled_by_default_outlined,
                  color: grade.isPresent ? colors.success : colors.danger,
                ),
              ),
            ),
            gradeCell(grade.discipline, alert: lowDiscipline),
          ]),
        ),
      ),
    );
  }
}
