import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../todo.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends HydratedBloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const ToDoState()) {
    on<AppStarted>(_onStarted);
    on<AddToDo>(_onAdd);
    on<RemoveToDo>(_onRemove);
    on<EditToDo>(_onEdit);
  }

  void _onStarted (AppStarted event, Emitter<ToDoState> emit){
    if(state.status == ToDoStatus.success) return;
    emit (state.copyWith(todos: state.todos, status: ToDoStatus.success));
  }

  void _onAdd (AddToDo event, Emitter<ToDoState> emit) {
    emit (state.copyWith(status: ToDoStatus.loading));
    try {
      List<ToDo> temp = [];
      temp.addAll(state.todos);
      temp.insert(0, event.todo);
      emit (state.copyWith(todos: temp, status: ToDoStatus.success));
    }
    catch (e) {
      emit (state.copyWith(status: ToDoStatus.error));
    }
  }

  void _onRemove (RemoveToDo event, Emitter<ToDoState> emit) {
    emit (state.copyWith(status: ToDoStatus.loading));
    try {
      state.todos.remove(event.todo);
      emit (state.copyWith(todos: state.todos, status: ToDoStatus.success));
    }
    catch (e) {
      emit (state.copyWith(status: ToDoStatus.error));
    }
  }

  void _onEdit (EditToDo event, Emitter<ToDoState> emit){
    emit (state.copyWith(status: ToDoStatus.loading));
    try {
      state.todos[event.index].isDone = !state.todos[event.index].isDone;
      emit (state.copyWith(todos: state.todos, status: ToDoStatus.success));
    }
    catch (e) {
      emit (state.copyWith(status: ToDoStatus.error));
    }
  }

  @override
  ToDoState? fromJson(Map<String, dynamic> json) {
    return ToDoState.fromJSON(json);
  }

  @override
  Map<String, dynamic>? toJson(ToDoState state) {
    return state.toJSON();
  }
}
