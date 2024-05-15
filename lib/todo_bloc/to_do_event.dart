part of 'to_do_bloc.dart';

@immutable
abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends ToDoEvent {}

class AddToDo extends ToDoEvent {
  final ToDo todo;

  const AddToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class RemoveToDo extends ToDoEvent {
  final ToDo todo;

  const RemoveToDo(this.todo);

  @override
  List<Object> get props => [todo];
}

class EditToDo extends ToDoEvent {
  final int index;

  const EditToDo(this.index);

  @override
  List<Object> get props => [index];
}