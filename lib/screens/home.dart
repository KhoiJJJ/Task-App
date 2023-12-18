import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/screens/add_task.dart';
import 'package:task_app/screens/edit_task.dart';
import 'package:task_app/task_bloc/task_bloc.dart';
import 'package:task_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  addTask(Task task) {
    context.read<TaskBloc>().add(
          AddTask(task),
        );
  }

  removeTask(Task task) {
    context.read<TaskBloc>().add(
          RemoveTask(task),
        );
  }

  alertTask(int index) {
    context.read<TaskBloc>().add(AlterTask(index));
  }

  favoriteTask(int index) {
    context.read<TaskBloc>().add(MarkFavoriteTask(index));
  }

  void _addTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(
            onTaskAdded: addTask,
          );
        });
  }

  void _editTask(BuildContext context, Task oldTask) {
    showDialog(
      context: context,
      builder: (context) => EditTaskDialog(
        oldTask: oldTask,
        onTaskEdited: (updatedTask) {
          BlocProvider.of<TaskBloc>(context).add(
            EditTask(oldTask: oldTask, newTask: updatedTask),
          );

          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 3,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Task App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.status == TaskStatus.success) {
              return Column(
                children: [
                  Center(
                    child: Chip(
                      label: Text('Tasks: ${state.tasks.length}'),
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      side: BorderSide.none,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, int i) {
                            final tasks = state.tasks[i];
                            return Card(
                              color: Theme.of(context).colorScheme.background,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      width: 2)),
                              child: Slidable(
                                  key: const ValueKey(0),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) {
                                          removeTask(tasks);
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      tasks.title,
                                      style: TextStyle(
                                          decoration: tasks.isDone
                                              ? TextDecoration.lineThrough
                                              : null),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(tasks.subtitle),
                                        Text(DateFormat("HH:mm a - dd/MM/yyyy ")
                                            .format(DateTime.parse(tasks.date)))
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Checkbox
                                        Checkbox(
                                          value: tasks.isDone,
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          onChanged: (value) {
                                            alertTask(i);
                                          },
                                        ),
                                        // Favorite Icon
                                        GestureDetector(
                                          onTap: () {
                                            favoriteTask(i);
                                          },
                                          child: Icon(
                                            tasks.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: tasks.isFavorite
                                                ? Colors.red
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              _editTask(context, tasks),
                                          child:
                                              const Icon(Icons.edit_document),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                  ),
                ],
              );
            } else if (state.status == TaskStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
