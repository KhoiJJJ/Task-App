part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskStarted extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TaskEvent {
  final Task task;

  const RemoveTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask(this.task);

  @override
  List<Object> get props => [task];
}

class AlterTask extends TaskEvent {
  final int index;

  const AlterTask(this.index);

  @override
  List<Object> get props => [index];
}

class MarkFavoriteTask extends TaskEvent {
  final int index;

  const MarkFavoriteTask(this.index);

  @override
  List<Object> get props => [index];
}

class EditTask extends TaskEvent {
  final Task oldTask;
  final Task newTask;

  const EditTask({required this.oldTask, required this.newTask});

  @override
  List<Object> get props => [oldTask, newTask];
}
