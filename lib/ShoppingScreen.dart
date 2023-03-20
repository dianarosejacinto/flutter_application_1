import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

final inputController = TextEditingController();

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {},
        ),
        title: const Text('Shopping List'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: inputController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'item',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        final String inController = inputController.text;
                        if (inController.isNotEmpty) {
                          Hive.box<String>('shoppingList').add(inController);
                          inputController.clear();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<String>('shoppingList').listenable(),
                  builder: ((context, input, child) {
                    return ListView.builder(
                      itemCount: input.length,
                      itemBuilder: (context, index) {
                        final String? item = input.getAt(index);
                        return Card(
                          child: ListTile(
                              title: Text(item!),
                              trailing: IconButton(
                                onPressed: () => input.deleteAt(index),
                                icon: const Icon(Icons.delete),
                              )),
                        );
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}