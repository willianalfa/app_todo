import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stores/user_store.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import 'configuracoes.dart';

class Home extends StatefulWidget {
  final UserStore userStore;

  const Home({Key? key, required this.userStore}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  bool _isSearchVisible = false;
  bool _isSearching = false;

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: inicioBg,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                if (!_isSearchVisible)
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                          ),
                          child: const Text(
                            'Tarefas',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (_foundToDo.isEmpty)
                          const Center(
                            child: Text(
                              'Nenhuma tarefa encontrada',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        else
                          for (ToDo todoo in _foundToDo.reversed.take(10))
                            ToDoItem(
                              todo: todoo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem,
                            ),
                      ],
                    ),
                  )
                else if (_isSearchVisible && _foundToDo.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: [
                        for (ToDo todoo in _foundToDo.reversed.take(10))
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            _showAddTaskModal(context);
          },
          backgroundColor: inicioBotaoAdd,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Adicionar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showAddTaskModal(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Adicionar Tarefa',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Digite a tarefa aqui...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma tarefa';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _addToDoItem(_todoController.text);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: inicioBotaoAdd,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              'Salvar',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
      _isSearching = false;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      _isSearching = true;
    }

    setState(() {
      _foundToDo = results;
      if (_foundToDo.isEmpty && _isSearching && enteredKeyword.length >= 2) {
        if (!_foundToDo.any((item) => item.id == 'notFound')) {
          _foundToDo.add(ToDo(
            id: 'notFound',
            todoText: 'Não Localizado',
          ));
        }
      }
    });
  }

  Widget searchBox() {
    return _isSearchVisible
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _foundToDo = todosList;
                });
                _runFilter(value);
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  minWidth: 25,
                ),
                border: InputBorder.none,
                hintText: 'Procurar Tarefa',
                hintStyle: TextStyle(color: inputProcurarFundo),
              ),
            ),
          )
        : Container();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: inicioBg,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: menuIcone,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              _isSearchVisible = !_isSearchVisible;
            });
          },
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'sair':
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmação'),
                      content: const Text('Você realmente deseja sair?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                break;
              case 'configuracoes':
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfiguracoesDialog(
                      userStore: widget.userStore,
                    );
                  },
                );
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: widget.userStore.username,
              enabled: false,
              child: Text(widget.userStore.username ?? 'Usuário'),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'configuracoes',
              child: Text('Configurações'),
            ),
            const PopupMenuItem<String>(
              value: 'sair',
              child: Text('Sair'),
            ),
          ],
          child: SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/perfil_willian.jpg'),
            ),
          ),
        ),
      ]),
    );
  }
}

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChanged;
  final Function(String) onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todo.id == 'notFound') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.only(top: 13),
        padding: const EdgeInsets.all(15),
        child: const Center(
          child: Text(
            'Não Localizado',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.only(top: 13),
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (bool? value) {
              onToDoChanged(todo);
            },
            activeColor: tarefaCheckbox,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: todo.isDone ? tarefaConcluida : tarefaPendente,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: tarefaIconeExcluir),
            onPressed: () {
              onDeleteItem(todo.id!);
            },
          ),
        ),
      );
    }
  }
}
