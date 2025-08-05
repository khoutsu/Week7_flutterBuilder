import 'package:flutter/material.dart';

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
              'Text input with validation',
              const TextFieldPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderDropdown',
              'Dropdown selection with options',
              const DropdownPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderCheckbox',
              'Single checkbox with boolean value',
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
              'FormBuilderSlider',
              'Numeric slider with range',
              const SliderPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderRadioGroup',
              'Single choice from multiple options',
              RadioGroupPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderSwitch',
              'Boolean toggle switch',
              SwitchPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderDateTimePicker',
              'Date and time selection',
              DateTimePickerPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderRangeSlider',
              'Range selection with two handles',
              RangeSliderPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderSegmentedControl',
              'iOS-style segmented control',
              SegmentedControlPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderFilterChip',
              'Multiple selection chips',
              FilterChipPage(),
            ),
            const Divider(),
            _buildNavigationTile(
              context,
              'FormBuilderChoiceChip',
              'Single selection from choice chips',
              ChoiceChipPage(),
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

// Simple placeholder pages for now
class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Demo')),
      body: const Center(child: Text('TextField Demo Page')),
    );
  }
}

class DropdownPage extends StatelessWidget {
  const DropdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Demo')),
      body: const Center(child: Text('Dropdown Demo Page')),
    );
  }
}

class CheckboxPage extends StatelessWidget {
  const CheckboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox Demo')),
      body: const Center(child: Text('Checkbox Demo Page')),
    );
  }
}

class CheckboxGroupPage extends StatelessWidget {
  const CheckboxGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox Group Demo')),
      body: const Center(child: Text('Checkbox Group Demo Page')),
    );
  }
}

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider Demo')),
      body: const Center(child: Text('Slider Demo Page')),
    );
  }
}

class RadioGroupPage extends StatelessWidget {
  const RadioGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Group Demo')),
      body: const Center(child: Text('Radio Group Demo Page')),
    );
  }
}

class SwitchPage extends StatelessWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Demo')),
      body: const Center(child: Text('Switch Demo Page')),
    );
  }
}

class DateTimePickerPage extends StatelessWidget {
  const DateTimePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DateTime Picker Demo')),
      body: const Center(child: Text('DateTime Picker Demo Page')),
    );
  }
}

class RangeSliderPage extends StatelessWidget {
  const RangeSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Range Slider Demo')),
      body: const Center(child: Text('Range Slider Demo Page')),
    );
  }
}

class SegmentedControlPage extends StatelessWidget {
  const SegmentedControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segmented Control Demo')),
      body: const Center(child: Text('Segmented Control Demo Page')),
    );
  }
}

class FilterChipPage extends StatelessWidget {
  const FilterChipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Chip Demo')),
      body: const Center(child: Text('Filter Chip Demo Page')),
    );
  }
}

class ChoiceChipPage extends StatelessWidget {
  const ChoiceChipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choice Chip Demo')),
      body: const Center(child: Text('Choice Chip Demo Page')),
    );
  }
}
