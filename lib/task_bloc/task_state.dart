part of 'task_bloc.dart';

enum TaskStatus { initial, loading, success, error }

class TaskState extends Equatable {
  final List<Task> tasks;
  final TaskStatus status;

  const TaskState(
      {this.tasks = const <Task>[], this.status = TaskStatus.initial});

  TaskState copyWith({
    TaskStatus? status,
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
    );
  }

  @override
  factory TaskState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTasks = (json['task'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList();

      return TaskState(
          tasks: listOfTasks,
          status: TaskStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'task': tasks, 'status': status.name};
  }

  @override
  List<Object?> get props => [tasks, status];
}
