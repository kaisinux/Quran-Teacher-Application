import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/ui/formatters.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../domain/grade_validator.dart';
import '../../domain/student_grade.dart';
import 'grade_stepper.dart';

/// Tablet layout: a real multi-column table close to the Google Sheet,
/// editable inline. Long remarks are edited in the student page.
class TabletGradesTable extends StatelessWidget {
  const TabletGradesTable({
    super.key,
    required this.grades,
    required this.enabled,
    required this.onChanged,
    required this.onOpenStudent,
  });

  final List<StudentGrade> grades;
  final bool enabled;
  final void Function(StudentGrade grade) onChanged;
  final ValueChanged<int> onOpenStudent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FixedColumnWidth(40), // #
          1: FlexColumnWidth(2), // student
          2: FixedColumnWidth(120), // presence
          3: IntrinsicColumnWidth(), // hifz
          4: IntrinsicColumnWidth(), // tajwid
          5: IntrinsicColumnWidth(), // discipline
          6: FlexColumnWidth(2), // remark
        },
        border: TableBorder.symmetric(
          inside: BorderSide(color: Theme.of(context).dividerColor),
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            children: [
              for (final title in [
                '#',
                l10n.fieldStudent,
                l10n.fieldPresence,
                l10n.fieldHifz,
                l10n.fieldTajwid,
                l10n.fieldDiscipline,
                l10n.fieldRemark,
              ])
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
            ],
          ),
          for (final (index, grade) in grades.indexed)
            _row(context, index, grade, l10n, colors),
        ],
      ),
    );
  }

  TableRow _row(
    BuildContext context,
    int index,
    StudentGrade grade,
    AppLocalizations l10n,
    StatusColors colors,
  ) {
    final issues = GradeValidator.validateStudent(grade);
    final missingRemark =
        issues.any((i) => i.code == IssueCode.missingDisciplineRemark);
    final gradeEnabled = enabled && grade.isPresent;

    Widget stepper(String label, double? value,
            StudentGrade Function(double?) update) =>
        Padding(
          padding: const EdgeInsets.all(6),
          child: GradeStepper(
            label: '${grade.studentName} — $label',
            value: grade.isPresent ? value : null,
            enabled: gradeEnabled,
            compact: true,
            onChanged: (v) => onChanged(update(v)),
          ),
        );

    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text('${index + 1}', textAlign: TextAlign.center),
      ),
      InkWell(
        onTap: () => onOpenStudent(index),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(grade.studentName,
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
      SwitchListTile(
        dense: true,
        value: grade.isPresent,
        onChanged: enabled
            ? (v) => onChanged(grade.copyWith(
                attendance: v ? Attendance.present : Attendance.absent))
            : null,
        title: Text(grade.isPresent ? l10n.present : l10n.absent),
      ),
      stepper(l10n.fieldHifz, grade.hifz, (v) => grade.copyWith(hifz: () => v)),
      stepper(l10n.fieldTajwid, grade.tajwid,
          (v) => grade.copyWith(tajwid: () => v)),
      stepper(l10n.fieldDiscipline, grade.discipline,
          (v) => grade.copyWith(discipline: () => v)),
      InkWell(
        onTap: () => onOpenStudent(index),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: missingRemark
              ? Row(children: [
                  Icon(Icons.error, color: colors.danger, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(l10n.issueMissingRemark,
                        style: TextStyle(color: colors.danger)),
                  ),
                ])
              : Text(grade.normalizedRemark ?? '',
                  maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ),
    ]);
  }
}

/// Read-only multi-column table (review on tablet, admin).
class ReadOnlyGradesTable extends StatelessWidget {
  const ReadOnlyGradesTable({super.key, required this.grades});

  final List<StudentGrade> grades;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text(l10n.fieldStudent)),
          DataColumn(label: Text(l10n.fieldPresence)),
          DataColumn(label: Text(l10n.fieldHifz), numeric: true),
          DataColumn(label: Text(l10n.fieldTajwid), numeric: true),
          DataColumn(label: Text(l10n.fieldDiscipline), numeric: true),
          DataColumn(label: Text(l10n.fieldRemark)),
        ],
        rows: [
          for (final g in grades)
            DataRow(cells: [
              DataCell(Text(g.studentName)),
              DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(g.isPresent ? Icons.check_box : Icons.disabled_by_default_outlined,
                    color: g.isPresent ? colors.success : colors.danger, size: 20),
                const SizedBox(width: 4),
                Text(g.isPresent ? l10n.present : l10n.absent),
              ])),
              DataCell(Text(formatGrade(context, g.hifz))),
              DataCell(Text(formatGrade(context, g.tajwid))),
              DataCell(Text(
                formatGrade(context, g.discipline),
                style: GradeValidator.requiresDisciplineRemark(g)
                    ? TextStyle(color: colors.danger, fontWeight: FontWeight.bold)
                    : null,
              )),
              DataCell(ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(g.normalizedRemark ?? ''),
              )),
            ]),
        ],
      ),
    );
  }
}
