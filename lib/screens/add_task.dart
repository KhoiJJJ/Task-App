import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/services/guid_gen.dart';
import 'package:task_app/widgets/textInput.dart';
import 'package:task_app/widgets/textInput2.dart';

class AddTaskDialog extends StatelessWidget {
  final Function(Task) onTaskAdded;

  const AddTaskDialog({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();

    return AlertDialog(
      title: const Text(
        'Add a Task',
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
              if (controller1.text.isNotEmpty) {
                onTaskAdded(Task(
                  id: GUIDGen.generate(),
                  title: controller1.text,
                  subtitle: controller2.text,
                  date: DateTime.now().toString(),
                ));

                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a task title'),
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
