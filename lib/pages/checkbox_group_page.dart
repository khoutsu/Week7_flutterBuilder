import 'package:flutter/material.dart';

class CheckboxGroupPage extends StatefulWidget {
  const CheckboxGroupPage({super.key});

  @override
  State<CheckboxGroupPage> createState() => _CheckboxGroupPageState();
}

class _CheckboxGroupPageState extends State<CheckboxGroupPage> {
  List<String> _checkboxGroup = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderCheckboxGroup'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderCheckboxGroup Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Programming Languages',
                    style: TextStyle(fontSize: 16),
                  ),
                  ...['Dart', 'Kotlin', 'Swift', 'JavaScript'].map(
                    (lang) => CheckboxListTile(
                      value: _checkboxGroup.contains(lang),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _checkboxGroup.add(lang);
                          } else {
                            _checkboxGroup.remove(lang);
                          }
                        });
                      },
                      title: Text(lang),
                      dense: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected Languages: $_checkboxGroup'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
