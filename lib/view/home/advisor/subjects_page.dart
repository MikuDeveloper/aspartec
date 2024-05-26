import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/advisor/subjects_delete_controller.dart';
import '../../../model/entities/subject_entity.dart';
import '../../../providers/subjects_provider.dart';
import '../../utils/list_keys.dart';

class SubjectsPage extends StatefulWidget {
  final List<SubjectEntity> subjects;
  const SubjectsPage({super.key, required this.subjects});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  late List<SubjectEntity> subjects;
  
  @override
  void initState() {
    subjects = widget.subjects;
    super.initState();
  }
  
  Widget _builder(context, index, animation, WidgetRef ref) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(subjects[index].subjectName!),
          trailing: SubjectsDeleteController(index: index, id: subjects[index].id!)
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) => AnimatedList(
        key: subjectsKey,
        initialItemCount: ref.read(subjectsProvider.notifier).subjects.length,
        itemBuilder: (context, index, animation) => _builder(context, index, animation, ref),
      ),
    );
  }
}
