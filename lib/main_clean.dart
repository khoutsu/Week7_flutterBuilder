import 'package:flutter/material.dart';
import 'pages/text_field_page.dart';
import 'pages/dropdown_page.dart';
import 'pages/checkbox_page.dart';
import 'pages/checkbox_group_page.dart';
import 'pages/slider_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade200),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Builder - All Inputs Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNavigationTile(
              context,
              'FormBuilderTextField',
              'Text input field with validation',
              const TextFieldPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderDropdown',
              'Dropdown selection field',
              const DropdownPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderCheckbox',
              'Single checkbox field',
              const CheckboxPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderCheckboxGroup',
              'Multiple checkbox selection',
              const CheckboxGroupPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderRadioGroup',
              'Radio button selection',
              const RadioGroupPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderSwitch',
              'On/Off switch field',
              const SwitchPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderSlider',
              'Slider for numerical input',
              const SliderPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderRangeSlider',
              'Range selection slider',
              const RangeSliderPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderDateTimePicker',
              'Date and time picker',
              const DateTimePickerPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderDateRangePicker',
              'Date range picker',
              const DateRangePickerPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderChoiceChip',
              'Choice chip selection',
              const ChoiceChipPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderFilterChip',
              'Filter chip multi-selection',
              const FilterChipPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context,
    String title,
    String subtitle,
    Widget page,
  ) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

// Individual FormBuilder Pages
class RadioGroupPage extends StatefulWidget {
  const RadioGroupPage({super.key});

  @override
  State<RadioGroupPage> createState() => _RadioGroupPageState();
}

class _RadioGroupPageState extends State<RadioGroupPage> {
  String? _radioGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderRadioGroup'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderRadioGroup Example',
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
                  const Text('Gender', style: TextStyle(fontSize: 16)),
                  ...['Male', 'Female', 'Other'].map(
                    (gender) => RadioListTile<String>(
                      value: gender,
                      groupValue: _radioGroup,
                      onChanged: (value) {
                        setState(() {
                          _radioGroup = value;
                        });
                      },
                      title: Text(gender),
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
                    content: Text('Selected Gender: $_radioGroup'),
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

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderSwitch'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderSwitch Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              value: _switch,
              onChanged: (value) {
                setState(() {
                  _switch = value;
                });
              },
              title: const Text('Enable Push Notifications'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Switch Value: $_switch'),
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

class RangeSliderPage extends StatefulWidget {
  const RangeSliderPage({super.key});

  @override
  State<RangeSliderPage> createState() => _RangeSliderPageState();
}

class _RangeSliderPageState extends State<RangeSliderPage> {
  RangeValues _rangeSlider = const RangeValues(100, 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderRangeSlider'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderRangeSlider Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Range: \$${_rangeSlider.start.round()} - \$${_rangeSlider.end.round()}',
                ),
                RangeSlider(
                  values: _rangeSlider,
                  min: 0,
                  max: 1000,
                  divisions: 20,
                  onChanged: (values) {
                    setState(() {
                      _rangeSlider = values;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Price Range: \$${_rangeSlider.start.round()} - \$${_rangeSlider.end.round()}',
                    ),
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

class DateTimePickerPage extends StatefulWidget {
  const DateTimePickerPage({super.key});

  @override
  State<DateTimePickerPage> createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderDateTimePicker'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderDateTimePicker Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 8),
                    Text(
                      _selectedDateTime != null
                          ? _selectedDateTime.toString()
                          : 'Select Date and Time',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected DateTime: $_selectedDateTime'),
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

class DateRangePickerPage extends StatefulWidget {
  const DateRangePickerPage({super.key});

  @override
  State<DateRangePickerPage> createState() => _DateRangePickerPageState();
}

class _DateRangePickerPageState extends State<DateRangePickerPage> {
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderDateRangePicker'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderDateRangePicker Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final range = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (range != null) {
                  setState(() {
                    _selectedDateRange = range;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.date_range),
                    const SizedBox(width: 8),
                    Text(
                      _selectedDateRange != null
                          ? '${_selectedDateRange!.start.toString().split(' ')[0]} - ${_selectedDateRange!.end.toString().split(' ')[0]}'
                          : 'Select Date Range',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected Date Range: $_selectedDateRange'),
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

class ChoiceChipPage extends StatefulWidget {
  const ChoiceChipPage({super.key});

  @override
  State<ChoiceChipPage> createState() => _ChoiceChipPageState();
}

class _ChoiceChipPageState extends State<ChoiceChipPage> {
  String? _choiceChip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderChoiceChip'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderChoiceChip Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('T-Shirt Size'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['XS', 'S', 'M', 'L', 'XL']
                      .map(
                        (size) => ChoiceChip(
                          label: Text(size),
                          selected: _choiceChip == size,
                          onSelected: (selected) {
                            setState(() {
                              _choiceChip = selected ? size : null;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected Size: $_choiceChip'),
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

class FilterChipPage extends StatefulWidget {
  const FilterChipPage({super.key});

  @override
  State<FilterChipPage> createState() => _FilterChipPageState();
}

class _FilterChipPageState extends State<FilterChipPage> {
  List<String> _filterChips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FormBuilderFilterChip'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderFilterChip Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Interests'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children:
                      ['Sports', 'Music', 'Travel', 'Technology', 'Cooking']
                          .map(
                            (interest) => FilterChip(
                              label: Text(interest),
                              selected: _filterChips.contains(interest),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _filterChips.add(interest);
                                  } else {
                                    _filterChips.remove(interest);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected Interests: $_filterChips'),
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
