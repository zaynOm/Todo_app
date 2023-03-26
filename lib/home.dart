import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final Map<String, bool?> _list = {};

class _MyHomePageState<T> extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static const _radius = Radius.circular(20);

  String imageUrl =
      'https://cdni.iconscout.com/illustration/premium/thumb/young-business-woman-working-on-todo-list-2644452-2206521.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: myBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a TO-DO',
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add a TO-DO'),
                content: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                      hintText: "Play soccer with friends."),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    },
                  ),
                  TextButton(
                    child: const Text('SAVE'),
                    onPressed: () {
                      setState(() {
                        _list[_textFieldController.text] = false;
                        scrollController.animateTo(
                          _list.length * 110.0,
                          duration: const Duration(seconds: 5),
                          curve: Curves.easeInOut,
                        );
                      });
                      Navigator.pop(context);
                      _textFieldController.clear();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  ScrollController scrollController = ScrollController();
  todoList() {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 70, top: 10),
      children: _list.keys.map((String key) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: CheckboxListTile(
            // contentPadding: EdgeInsets.symmetric(vertical: 5),
            activeColor: Colors.red,
            tileColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            value: _list[key],
            onChanged: (bool? value) {
              setState(() {
                _list[key] = value;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  myBody(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: _radius, bottomLeft: _radius),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes! * 1.0)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 250,
          child: todoList(),
        ),
      ],
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

TextEditingController _textFieldController = TextEditingController();
/* Future<void> _displayTextInputDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add a TO-DO'),
        content: TextField(
          controller: _textFieldController,
          decoration:
              const InputDecoration(hintText: "Play soccer with friends."),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
              _textFieldController.clear();
            },
          ),
          TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              _list[_textFieldController.text] = false;
              Navigator.pop(context);

              _textFieldController.clear();
            },
          ),
        ],
      );
    },
  );
} */
