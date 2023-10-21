import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController butterflyNameController = TextEditingController();
  var butterflies = [
    'Butterfly1',
    'Butterfly2',
    'Butterfly3',
    'Butterfly4',
  ];

  void _submitForm() {
    String butterflyName = butterflyNameController.text.trim();
    try {
      addButterfly(butterflyName, butterflies);
    } catch (e) {
      if (e is DuplicateException) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('This butterfly is already on the list'),
          ),
        );
      }
    }
  }

  Future<void> addButterfly(butterfly, List<String> butterflies) async {
    await Future.delayed(const Duration(seconds: 3));
    if (butterflies.contains(butterfly)) {
      throw DuplicateException();
    } else {
      butterflies.add(butterfly);
      setState(() {
        butterflies.add;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            TextFormField(
              controller: butterflyNameController,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter butterfly name",
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black38)),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            TextButton(
              onPressed: _submitForm,
              child: const Text('add'),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: butterflies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                      style: const TextStyle(fontSize: 20),
                      butterflies.elementAt(index));
                }),
          ],
        ),
      ),
    );
  }
}

class DuplicateException implements Exception {
  String errorMessage() {
    return ("This butterfly is already on the list");
  }
}
