import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/todo.dart';
import 'package:to_do_app/todo_bloc/to_do_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  addToDo (ToDo todo) {context.read<ToDoBloc>().add(AddToDo(todo));}
  removeToDo (ToDo todo) {context.read<ToDoBloc>().add(RemoveToDo(todo));}
  editToDo (int index) {context.read<ToDoBloc>().add(EditToDo(index));}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {

                TextEditingController controller1 = TextEditingController();
                TextEditingController controller2 = TextEditingController();

                return AlertDialog(
                  title: const Text(
                    'Add ToDo'
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller1,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: 'Task title....',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide (
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        controller: controller2,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: 'Task details....',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide (
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          onPressed: () {
                            addToDo(
                              ToDo(
                                  title: controller1.text,
                                  subtitle: controller2.text
                              ),
                            );
                            controller1.text = '';
                            controller2.text = '';
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            foregroundColor: Theme.of(context).colorScheme.secondary,
                          ),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Icon(
                                CupertinoIcons.check_mark,
                                color: Colors.green,
                              )
                          )
                      ),
                    )
                  ],
                );
              });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white70,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: const Text(
          'ToDo App',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ToDoBloc, ToDoState> (
          builder: (context, state) {
            if (state.status == ToDoStatus.success){
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, int i) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                              onPressed: (_) {
                                removeToDo(state.todos[i]);
                              },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          state.todos[i].title,
                        ),
                        subtitle: Text(
                          state.todos[i].subtitle
                        ),
                        trailing: Checkbox(
                          value: state.todos[i].isDone,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          onChanged: (value) {EditToDo(i);},
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else if (state.status == ToDoStatus.loading) {return const CircularProgressIndicator();}
            else {return Container();}
          },
        ),
      )
    );
  }
}
