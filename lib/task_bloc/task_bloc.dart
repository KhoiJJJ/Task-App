import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_app/model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<TaskStarted>(_onStarted);
    on<AddTask>(_onAddTask);
    on<RemoveTask>(_onRemoveTask);
    on<AlterTask>(_onAlterTask);
    on<MarkFavoriteTask>(_onMarkFavoriteTask);
    on<EditTask>(_onEditTask);
  }

  void _onStarted(
    TaskStarted event,
    Emitter<TaskState> emit,
  ) {
    if (state.status == TaskStatus.success) return;
    emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
  }

  void _onAddTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      List<Task> temp = List.from(state.tasks);
      temp.add(event.task);
      emit(state.copyWith(tasks: temp, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }

  void _onRemoveTask(
    RemoveTask event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      state.tasks.remove(event.task);
      emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }

  void _onAlterTask(
    AlterTask event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      state.tasks[event.index].isDone = !state.tasks[event.index].isDone;
      emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }

  void _onMarkFavoriteTask(
    MarkFavoriteTask event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      state.tasks[event.index].isFavorite =
          !state.tasks[event.index].isFavorite;
      emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }

  void _onEditTask(
    EditTask event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      int index = state.tasks.indexOf(event.oldTask);

      if (index >= 0) {
        state.tasks[index] = event.newTask;
        emit(state.copyWith(tasks: state.tasks, status: TaskStatus.success));
      } else {
        throw Exception("Task not found");
      }
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }
}
