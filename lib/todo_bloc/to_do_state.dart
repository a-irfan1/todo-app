part of 'to_do_bloc.dart';

enum ToDoStatus {initial, loading, success, error}

class ToDoState extends Equatable {
  final List<ToDo> todos;
  final ToDoStatus status;

  const ToDoState ({
    this.todos = const <ToDo> [],
    this.status = ToDoStatus.initial
  });

  ToDoState copyWith ({ToDoStatus? status, List<ToDo>? todos}) {
    return ToDoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  @override
  factory ToDoState.fromJSON(Map<String, dynamic> json){
    try {
        var listOfToDos = (json['todos'] as List<dynamic>).map((e) => ToDo.fromJSON(e as Map<String, dynamic>)).toList();

        return ToDoState (
          todos: listOfToDos,
          status: ToDoStatus.values.firstWhere((element) => element.name.toString() == json['status'])
        );
    }
    catch (e) {
      rethrow;
    }
  }
  Map<String, dynamic> toJSON() {
    return {
      'todos': todos,
      'status': status.name
    };
  }

  @override
  List<Object> get props => [status, todos];
}
