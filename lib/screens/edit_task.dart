import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_app/model/task.dart';

import 'package:task_app/widgets/textInput.dart';
import 'package:task_app/widgets/textInput2.dart';

class EditTaskDialog extends StatelessWidget {
  final Function(Task) onTaskEdited;
  final Task oldTask;

  const EditTaskDialog(
      {Key? key, required this.onTaskEdited, required this.oldTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 =
        TextEditingController(text: oldTask.title);
    final TextEditingController controller2 =
        TextEditingController(text: oldTask.subtitle);

    return AlertDialog(
      title: const Text(
        'Edit Task',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInput(controller: controller1),
          const SizedBox(height: 10),
          TextInput2(controller: controller2),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextButton(
            onPressed: () {
              if (controller1.text != oldTask.title ||
                  controller2.text != oldTask.subtitle) {
                onTaskEdited(Task(
                    id: oldTask.id,
                    title: controller1.text,
                    subtitle: controller2.text,
                    date: DateTime.now().toString(),
                    isFavorite: oldTask.isFavorite,
                    isDone: false));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You haven't made any changes yet "),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Icon(CupertinoIcons.check_mark),
            ),
          ),
        ),
      ],
    );
  }
}
