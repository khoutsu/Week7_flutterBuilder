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

// Functional demo pages
class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FormBuilderTextField Examples',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Name field with required validation
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  if (value.length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email field with email validation
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone field with pattern validation
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(
                      r'^\d{10,15}$',
                    ).hasMatch(value.replaceAll(RegExp(r'[^\d]'), ''))) {
                      return 'Enter a valid phone number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _submittedData =
                            '''
Name: ${_nameController.text}
Email: ${_emailController.text}
Phone: ${_phoneController.text}''';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Form'),
                ),
              ),

              // Display submitted data
              if (_submittedData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Submitted Data:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_submittedData),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedLanguage;
  String _submittedData = '';

  final List<String> _countries = [
    'USA',
    'Canada',
    'UK',
    'Australia',
    'Germany',
    'France',
  ];
  final Map<String, List<String>> _cities = {
    'USA': ['New York', 'Los Angeles', 'Chicago', 'Houston'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal', 'Calgary'],
    'UK': ['London', 'Manchester', 'Birmingham', 'Liverpool'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane', 'Perth'],
    'Germany': ['Berlin', 'Munich', 'Hamburg', 'Frankfurt'],
    'France': ['Paris', 'Lyon', 'Marseille', 'Toulouse'],
  };
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FormBuilderDropdown Examples',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Country dropdown
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(value: country, child: Text(country));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _selectedCity = null; // Reset city when country changes
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // City dropdown (dependent on country)
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: _selectedCountry != null
                    ? _cities[_selectedCountry]?.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList()
                    : [],
                onChanged: _selectedCountry != null
                    ? (value) {
                        setState(() {
                          _selectedCity = value;
                        });
                      }
                    : null,
                hint: _selectedCountry == null
                    ? const Text('Select a country first')
                    : const Text('Select a city'),
              ),
              const SizedBox(height: 16),

              // Language dropdown with multiple selection simulation
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: const InputDecoration(
                  labelText: 'Primary Language',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.language),
                ),
                items: _languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Row(
                      children: [
                        Icon(_getLanguageIcon(language), size: 20),
                        const SizedBox(width: 8),
                        Text(language),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _submittedData =
                            '''
Country: ${_selectedCountry ?? 'Not selected'}
City: ${_selectedCity ?? 'Not selected'}
Language: ${_selectedLanguage ?? 'Not selected'}''';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Selections'),
                ),
              ),

              // Display submitted data
              if (_submittedData.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Selected Options:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_submittedData),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLanguageIcon(String language) {
    switch (language) {
      case 'English':
        return Icons.language;
      case 'Spanish':
        return Icons.translate;
      case 'French':
        return Icons.chat;
      case 'German':
        return Icons.forum;
      case 'Chinese':
        return Icons.keyboard_alt;
      case 'Japanese':
        return Icons.text_fields;
      default:
        return Icons.language;
    }
  }
}

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _agreeTerms = false;
  bool _subscribeNewsletter = false;
  bool _enableNotifications = true;
  bool _rememberMe = false;
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderCheckbox Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Terms and conditions checkbox (required)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _agreeTerms ? Colors.green : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                value: _agreeTerms,
                onChanged: (value) {
                  setState(() {
                    _agreeTerms = value ?? false;
                  });
                },
                title: const Text('I agree to the Terms and Conditions *'),
                subtitle: const Text('Required to proceed'),
                secondary: const Icon(Icons.gavel),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 16),

            // Newsletter subscription checkbox
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                value: _subscribeNewsletter,
                onChanged: (value) {
                  setState(() {
                    _subscribeNewsletter = value ?? false;
                  });
                },
                title: const Text('Subscribe to Newsletter'),
                subtitle: const Text('Get updates about new features'),
                secondary: const Icon(Icons.email_outlined),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 16),

            // Enable notifications checkbox (default true)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                value: _enableNotifications,
                onChanged: (value) {
                  setState(() {
                    _enableNotifications = value ?? false;
                  });
                },
                title: const Text('Enable Push Notifications'),
                subtitle: const Text('Receive real-time updates'),
                secondary: Icon(
                  _enableNotifications
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: _enableNotifications ? Colors.blue : Colors.grey,
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 16),

            // Remember me checkbox
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
                title: const Text('Remember Me'),
                subtitle: const Text('Stay signed in for 30 days'),
                secondary: const Icon(Icons.memory),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreeTerms
                    ? () {
                        setState(() {
                          _submittedData =
                              '''
Terms Accepted: $_agreeTerms
Newsletter: $_subscribeNewsletter
Notifications: $_enableNotifications
Remember Me: $_rememberMe''';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preferences saved successfully!'),
                          ),
                        );
                      }
                    : null,
                child: const Text('Save Preferences'),
              ),
            ),

            // Validation message
            if (!_agreeTerms) ...[
              const SizedBox(height: 8),
              const Text(
                'You must agree to the Terms and Conditions to continue',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Saved Preferences:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CheckboxGroupPage extends StatefulWidget {
  const CheckboxGroupPage({super.key});

  @override
  State<CheckboxGroupPage> createState() => _CheckboxGroupPageState();
}

class _CheckboxGroupPageState extends State<CheckboxGroupPage> {
  List<String> _selectedHobbies = [];
  List<String> _selectedSkills = [];
  List<String> _selectedLanguages = [];
  String _submittedData = '';

  final List<String> _hobbies = [
    'Reading',
    'Gaming',
    'Cooking',
    'Sports',
    'Music',
    'Photography',
  ];

  final List<String> _skills = [
    'Flutter',
    'React',
    'Python',
    'Java',
    'JavaScript',
    'UI/UX Design',
  ];

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox Group Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderCheckboxGroup Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Hobbies selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hobbies (${_selectedHobbies.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: _hobbies.map((hobby) {
                      final isSelected = _selectedHobbies.contains(hobby);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 4),
                        child: FilterChip(
                          label: Text(hobby),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedHobbies.add(hobby);
                              } else {
                                _selectedHobbies.remove(hobby);
                              }
                            });
                          },
                          selectedColor: Colors.blue.shade100,
                          checkmarkColor: Colors.blue,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Skills selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Technical Skills (${_selectedSkills.length} selected) *',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: _skills.map((skill) {
                      return CheckboxListTile(
                        title: Text(skill),
                        value: _selectedSkills.contains(skill),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedSkills.add(skill);
                            } else {
                              _selectedSkills.remove(skill);
                            }
                          });
                        },
                        secondary: Icon(_getSkillIcon(skill)),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                  if (_selectedSkills.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Please select at least one skill',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Languages selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Languages (${_selectedLanguages.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _languages.map((language) {
                      final isSelected = _selectedLanguages.contains(language);
                      return ChoiceChip(
                        label: Text(language),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              if (!_selectedLanguages.contains(language)) {
                                _selectedLanguages.add(language);
                              }
                            } else {
                              _selectedLanguages.remove(language);
                            }
                          });
                        },
                        selectedColor: Colors.green.shade100,
                        avatar: isSelected
                            ? const Icon(Icons.check, size: 16)
                            : null,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedSkills.isNotEmpty
                    ? () {
                        setState(() {
                          _submittedData =
                              '''
Hobbies: ${_selectedHobbies.isEmpty ? 'None' : _selectedHobbies.join(', ')}
Skills: ${_selectedSkills.join(', ')}
Languages: ${_selectedLanguages.isEmpty ? 'None' : _selectedLanguages.join(', ')}''';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile updated successfully!'),
                          ),
                        );
                      }
                    : null,
                child: const Text('Update Profile'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Your Profile:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getSkillIcon(String skill) {
    switch (skill) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'React':
        return Icons.web;
      case 'Python':
        return Icons.code;
      case 'Java':
        return Icons.coffee;
      case 'JavaScript':
        return Icons.javascript;
      case 'UI/UX Design':
        return Icons.design_services;
      default:
        return Icons.code;
    }
  }
}

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _ageValue = 25;
  double _priceValue = 500;
  double _volumeValue = 50;
  double _brightnessValue = 75;
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderSlider Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Age slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Age',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_ageValue.round()} years',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _ageValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${_ageValue.round()} years',
                    onChanged: (value) {
                      setState(() {
                        _ageValue = value;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0', style: TextStyle(fontSize: 12)),
                      Text('100', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Price range slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Budget',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${_priceValue.round()}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _priceValue,
                    min: 0,
                    max: 2000,
                    divisions: 40,
                    activeColor: Colors.green,
                    label: '\$${_priceValue.round()}',
                    onChanged: (value) {
                      setState(() {
                        _priceValue = value;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$0', style: TextStyle(fontSize: 12)),
                      Text('\$2000', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Volume slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _volumeValue == 0
                                ? Icons.volume_mute
                                : _volumeValue < 30
                                ? Icons.volume_down
                                : Icons.volume_up,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Volume',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        '${_volumeValue.round()}%',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _volumeValue,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    activeColor: Colors.orange,
                    label: '${_volumeValue.round()}%',
                    onChanged: (value) {
                      setState(() {
                        _volumeValue = value;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0%', style: TextStyle(fontSize: 12)),
                      Text('100%', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Brightness slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.brightness_6,
                            color: Colors.yellow.shade700,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Brightness',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        '${_brightnessValue.round()}%',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _brightnessValue,
                    min: 10,
                    max: 100,
                    divisions: 18,
                    activeColor: Colors.yellow.shade700,
                    label: '${_brightnessValue.round()}%',
                    onChanged: (value) {
                      setState(() {
                        _brightnessValue = value;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('10%', style: TextStyle(fontSize: 12)),
                      Text('100%', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
Age: ${_ageValue.round()} years
Budget: \$${_priceValue.round()}
Volume: ${_volumeValue.round()}%
Brightness: ${_brightnessValue.round()}%''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings saved successfully!'),
                    ),
                  );
                },
                child: const Text('Save Settings'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Current Settings:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class RadioGroupPage extends StatefulWidget {
  const RadioGroupPage({super.key});

  @override
  State<RadioGroupPage> createState() => _RadioGroupPageState();
}

class _RadioGroupPageState extends State<RadioGroupPage> {
  String? _selectedGender;
  String? _selectedEducation;
  String? _selectedPayment;
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Group Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderRadioGroup Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Gender selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender *',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Other'),
                        value: 'Other',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Prefer not to say'),
                        value: 'Prefer not to say',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Education level
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Education Level',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text('High School'),
                        value: 'High School',
                        groupValue: _selectedEducation,
                        onChanged: (value) {
                          setState(() {
                            _selectedEducation = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Bachelor\'s Degree'),
                        value: 'Bachelor\'s Degree',
                        groupValue: _selectedEducation,
                        onChanged: (value) {
                          setState(() {
                            _selectedEducation = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Master\'s Degree'),
                        value: 'Master\'s Degree',
                        groupValue: _selectedEducation,
                        onChanged: (value) {
                          setState(() {
                            _selectedEducation = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('PhD or higher'),
                        value: 'PhD or higher',
                        groupValue: _selectedEducation,
                        onChanged: (value) {
                          setState(() {
                            _selectedEducation = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment method
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferred Payment Method',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(Icons.credit_card, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Credit Card'),
                          ],
                        ),
                        value: 'Credit Card',
                        groupValue: _selectedPayment,
                        onChanged: (value) {
                          setState(() {
                            _selectedPayment = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(Icons.account_balance, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Bank Transfer'),
                          ],
                        ),
                        value: 'Bank Transfer',
                        groupValue: _selectedPayment,
                        onChanged: (value) {
                          setState(() {
                            _selectedPayment = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Icon(Icons.payment, color: Colors.orange),
                            SizedBox(width: 8),
                            Text('PayPal'),
                          ],
                        ),
                        value: 'PayPal',
                        groupValue: _selectedPayment,
                        onChanged: (value) {
                          setState(() {
                            _selectedPayment = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedGender != null
                    ? () {
                        setState(() {
                          _submittedData =
                              '''
Gender: $_selectedGender
Education: ${_selectedEducation ?? 'Not selected'}
Payment: ${_selectedPayment ?? 'Not selected'}''';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Information saved successfully!'),
                          ),
                        );
                      }
                    : null,
                child: const Text('Save Information'),
              ),
            ),

            // Validation message
            if (_selectedGender == null) ...[
              const SizedBox(height: 8),
              const Text(
                'Please select a gender to continue',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Selected Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
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
  bool _pushNotifications = true;
  bool _locationServices = false;
  bool _darkMode = false;
  bool _autoBackup = true;
  bool _offlineMode = false;
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderSwitch Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Push notifications switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive alerts and updates'),
                secondary: Icon(
                  _pushNotifications
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: _pushNotifications ? Colors.green : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Location services switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _locationServices,
                onChanged: (value) {
                  setState(() {
                    _locationServices = value;
                  });
                },
                title: const Text('Location Services'),
                subtitle: const Text('Allow app to access your location'),
                secondary: Icon(
                  _locationServices ? Icons.location_on : Icons.location_off,
                  color: _locationServices ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Dark mode switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
                title: const Text('Dark Mode'),
                subtitle: const Text('Use dark theme'),
                secondary: Icon(
                  _darkMode ? Icons.dark_mode : Icons.light_mode,
                  color: _darkMode ? Colors.indigo : Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Auto backup switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _autoBackup,
                onChanged: (value) {
                  setState(() {
                    _autoBackup = value;
                  });
                },
                title: const Text('Auto Backup'),
                subtitle: const Text('Automatically backup your data'),
                secondary: Icon(
                  _autoBackup ? Icons.cloud_done : Icons.cloud_off,
                  color: _autoBackup ? Colors.green : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Offline mode switch
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SwitchListTile(
                value: _offlineMode,
                onChanged: (value) {
                  setState(() {
                    _offlineMode = value;
                  });
                },
                title: const Text('Offline Mode'),
                subtitle: const Text('Work without internet connection'),
                secondary: Icon(
                  _offlineMode ? Icons.wifi_off : Icons.wifi,
                  color: _offlineMode ? Colors.red : Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
Push Notifications: $_pushNotifications
Location Services: $_locationServices
Dark Mode: $_darkMode
Auto Backup: $_autoBackup
Offline Mode: $_offlineMode''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings saved successfully!'),
                    ),
                  );
                },
                child: const Text('Save Settings'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Current Settings:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDateTime;
  DateTimeRange? _selectedDateRange;
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DateTime Picker Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderDateTimePicker Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Date picker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Birth Date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue),
                          const SizedBox(width: 12),
                          Text(
                            _selectedDate != null
                                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                : 'Select birth date',
                            style: TextStyle(
                              color: _selectedDate != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Time picker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferred Meeting Time',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedTime = time;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.orange),
                          const SizedBox(width: 12),
                          Text(
                            _selectedTime != null
                                ? _selectedTime!.format(context)
                                : 'Select meeting time',
                            style: TextStyle(
                              color: _selectedTime != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // DateTime picker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Event Date & Time',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDateTime ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                            _selectedDateTime ?? DateTime.now(),
                          ),
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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.event, color: Colors.green),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedDateTime != null
                                  ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} at ${TimeOfDay.fromDateTime(_selectedDateTime!).format(context)}'
                                  : 'Select event date and time',
                              style: TextStyle(
                                color: _selectedDateTime != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Date range picker
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vacation Period',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final dateRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDateRange: _selectedDateRange,
                      );
                      if (dateRange != null) {
                        setState(() {
                          _selectedDateRange = dateRange;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range, color: Colors.purple),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedDateRange != null
                                  ? '${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month}/${_selectedDateRange!.start.year} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}/${_selectedDateRange!.end.year}'
                                  : 'Select vacation period',
                              style: TextStyle(
                                color: _selectedDateRange != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
Birth Date: ${_selectedDate != null ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : 'Not selected'}
Meeting Time: ${_selectedTime?.format(context) ?? 'Not selected'}
Event: ${_selectedDateTime != null ? '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} at ${TimeOfDay.fromDateTime(_selectedDateTime!).format(context)}' : 'Not selected'}
Vacation: ${_selectedDateRange != null ? '${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month}/${_selectedDateRange!.start.year} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}/${_selectedDateRange!.end.year}' : 'Not selected'}''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Date/Time information saved!'),
                    ),
                  );
                },
                child: const Text('Save Date/Time Info'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Selected Date/Time Information:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
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
  RangeValues _priceRange = const RangeValues(100, 800);
  RangeValues _ageRange = const RangeValues(18, 65);
  RangeValues _timeRange = const RangeValues(9, 17);
  RangeValues _temperatureRange = const RangeValues(18, 25);
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Range Slider Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderRangeSlider Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Price range slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price Range',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    activeColor: Colors.green,
                    labels: RangeLabels(
                      '\$${_priceRange.start.round()}',
                      '\$${_priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$0', style: TextStyle(fontSize: 12)),
                      Text('\$1000', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Age range slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Target Age Group',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${_ageRange.start.round()} - ${_ageRange.end.round()} years',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: _ageRange,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    activeColor: Colors.blue,
                    labels: RangeLabels(
                      '${_ageRange.start.round()}',
                      '${_ageRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _ageRange = values;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0 years', style: TextStyle(fontSize: 12)),
                      Text('100 years', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Time range slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Working Hours',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${_timeRange.start.round()}:00 - ${_timeRange.end.round()}:00',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: _timeRange,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    activeColor: Colors.orange,
                    labels: RangeLabels(
                      '${_timeRange.start.round()}:00',
                      '${_timeRange.end.round()}:00',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _timeRange = values;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('00:00', style: TextStyle(fontSize: 12)),
                      Text('24:00', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Temperature range slider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thermostat, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Temperature Range',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${_temperatureRange.start.round()}°C - ${_temperatureRange.end.round()}°C',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: _temperatureRange,
                    min: 0,
                    max: 40,
                    divisions: 40,
                    activeColor: Colors.red,
                    labels: RangeLabels(
                      '${_temperatureRange.start.round()}°C',
                      '${_temperatureRange.end.round()}°C',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _temperatureRange = values;
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0°C', style: TextStyle(fontSize: 12)),
                      Text('40°C', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
Price Range: \$${_priceRange.start.round()} - \$${_priceRange.end.round()}
Age Group: ${_ageRange.start.round()} - ${_ageRange.end.round()} years
Working Hours: ${_timeRange.start.round()}:00 - ${_timeRange.end.round()}:00
Temperature: ${_temperatureRange.start.round()}°C - ${_temperatureRange.end.round()}°C''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Range settings saved successfully!'),
                    ),
                  );
                },
                child: const Text('Save Range Settings'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Selected Ranges:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SegmentedControlPage extends StatefulWidget {
  const SegmentedControlPage({super.key});

  @override
  State<SegmentedControlPage> createState() => _SegmentedControlPageState();
}

class _SegmentedControlPageState extends State<SegmentedControlPage> {
  String _selectedSize = 'Medium';
  String _selectedTheme = 'Light';
  String _selectedView = 'List';
  String _selectedDifficulty = 'Intermediate';
  String _submittedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segmented Control Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderSegmentedControl Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Size selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'T-Shirt Size',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: ['Small', 'Medium', 'Large', 'XL'].map((size) {
                        final isSelected = _selectedSize == size;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSize = size;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                size,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Theme selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'App Theme',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children:
                          [
                            {'name': 'Light', 'icon': Icons.light_mode},
                            {'name': 'Dark', 'icon': Icons.dark_mode},
                            {'name': 'Auto', 'icon': Icons.brightness_auto},
                          ].map((theme) {
                            final isSelected = _selectedTheme == theme['name'];
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTheme = theme['name'] as String;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        theme['icon'] as IconData,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black54,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        theme['name'] as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // View selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Display View',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children:
                          [
                            {'name': 'List', 'icon': Icons.list},
                            {'name': 'Grid', 'icon': Icons.grid_view},
                            {'name': 'Card', 'icon': Icons.view_agenda},
                          ].map((view) {
                            final isSelected = _selectedView == view['name'];
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedView = view['name'] as String;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.green
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        view['icon'] as IconData,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black54,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        view['name'] as String,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Difficulty selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Game Difficulty',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children:
                          [
                            {'name': 'Easy', 'color': Colors.green},
                            {'name': 'Intermediate', 'color': Colors.orange},
                            {'name': 'Hard', 'color': Colors.red},
                          ].map((difficulty) {
                            final isSelected =
                                _selectedDifficulty == difficulty['name'];
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDifficulty =
                                        difficulty['name'] as String;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? difficulty['color'] as Color
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    difficulty['name'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
T-Shirt Size: $_selectedSize
App Theme: $_selectedTheme
Display View: $_selectedView
Game Difficulty: $_selectedDifficulty''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preferences saved successfully!'),
                    ),
                  );
                },
                child: const Text('Save Preferences'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Selected Preferences:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
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
  List<String> _selectedCategories = ['Technology'];
  List<String> _selectedFeatures = [];
  List<String> _selectedTags = ['Popular'];
  List<String> _selectedInterests = [];
  String _submittedData = '';

  final List<String> _categories = [
    'Technology',
    'Sports',
    'Music',
    'Travel',
    'Food',
    'Art',
    'Business',
    'Health',
  ];

  final List<String> _features = [
    'WiFi',
    'Parking',
    'Pet Friendly',
    'Pool',
    'Gym',
    'Restaurant',
    'Spa',
    'Beach Access',
  ];

  final List<String> _tags = [
    'Popular',
    'New',
    'Featured',
    'Trending',
    'Sale',
    'Premium',
    'Limited',
    'Exclusive',
  ];

  final List<String> _interests = [
    'Coding',
    'Photography',
    'Gaming',
    'Reading',
    'Cooking',
    'Fitness',
    'Movies',
    'Podcasts',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Chip Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderFilterChip Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Categories filter chips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories (${_selectedCategories.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _categories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategories.add(category);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                        },
                        selectedColor: Colors.blue.shade100,
                        checkmarkColor: Colors.blue,
                        avatar: isSelected
                            ? null
                            : Icon(
                                _getCategoryIcon(category),
                                size: 16,
                                color: Colors.grey,
                              ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hotel features filter chips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotel Features (${_selectedFeatures.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _features.map((feature) {
                      final isSelected = _selectedFeatures.contains(feature);
                      return FilterChip(
                        label: Text(feature),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedFeatures.add(feature);
                            } else {
                              _selectedFeatures.remove(feature);
                            }
                          });
                        },
                        selectedColor: Colors.green.shade100,
                        checkmarkColor: Colors.green,
                        avatar: isSelected
                            ? null
                            : Icon(
                                _getFeatureIcon(feature),
                                size: 16,
                                color: Colors.grey,
                              ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Product tags filter chips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Tags (${_selectedTags.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _tags.map((tag) {
                      final isSelected = _selectedTags.contains(tag);
                      return FilterChip(
                        label: Text(tag),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedTags.add(tag);
                            } else {
                              _selectedTags.remove(tag);
                            }
                          });
                        },
                        selectedColor: Colors.orange.shade100,
                        checkmarkColor: Colors.orange,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.orange.shade800
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Personal interests filter chips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Interests (${_selectedInterests.length} selected)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _interests.map((interest) {
                      final isSelected = _selectedInterests.contains(interest);
                      return FilterChip(
                        label: Text(interest),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedInterests.add(interest);
                            } else {
                              _selectedInterests.remove(interest);
                            }
                          });
                        },
                        selectedColor: Colors.purple.shade100,
                        checkmarkColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.purple
                                : Colors.grey.shade300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _submittedData =
                        '''
Categories: ${_selectedCategories.isEmpty ? 'None' : _selectedCategories.join(', ')}
Hotel Features: ${_selectedFeatures.isEmpty ? 'None' : _selectedFeatures.join(', ')}
Product Tags: ${_selectedTags.isEmpty ? 'None' : _selectedTags.join(', ')}
Interests: ${_selectedInterests.isEmpty ? 'None' : _selectedInterests.join(', ')}''';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter preferences saved!')),
                  );
                },
                child: const Text('Apply Filters'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Applied Filters:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Technology':
        return Icons.computer;
      case 'Sports':
        return Icons.sports_soccer;
      case 'Music':
        return Icons.music_note;
      case 'Travel':
        return Icons.flight;
      case 'Food':
        return Icons.restaurant;
      case 'Art':
        return Icons.palette;
      case 'Business':
        return Icons.business;
      case 'Health':
        return Icons.favorite;
      default:
        return Icons.category;
    }
  }

  IconData _getFeatureIcon(String feature) {
    switch (feature) {
      case 'WiFi':
        return Icons.wifi;
      case 'Parking':
        return Icons.local_parking;
      case 'Pet Friendly':
        return Icons.pets;
      case 'Pool':
        return Icons.pool;
      case 'Gym':
        return Icons.fitness_center;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Spa':
        return Icons.spa;
      case 'Beach Access':
        return Icons.beach_access;
      default:
        return Icons.star;
    }
  }
}

class ChoiceChipPage extends StatefulWidget {
  const ChoiceChipPage({super.key});

  @override
  State<ChoiceChipPage> createState() => _ChoiceChipPageState();
}

class _ChoiceChipPageState extends State<ChoiceChipPage> {
  String? _selectedPriority;
  String? _selectedSize;
  String? _selectedColor;
  String? _selectedDelivery;
  String _submittedData = '';

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<Map<String, dynamic>> _colors = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Black', 'color': Colors.black},
  ];
  final List<Map<String, dynamic>> _deliveryOptions = [
    {'name': 'Standard', 'icon': Icons.local_shipping, 'desc': '5-7 days'},
    {'name': 'Express', 'icon': Icons.flash_on, 'desc': '2-3 days'},
    {'name': 'Overnight', 'icon': Icons.rocket_launch, 'desc': 'Next day'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choice Chip Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FormBuilderChoiceChip Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Priority selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Task Priority *',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: _priorities.map((priority) {
                      final isSelected = _selectedPriority == priority;
                      return ChoiceChip(
                        label: Text(priority),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedPriority = selected ? priority : null;
                          });
                        },
                        selectedColor: _getPriorityColor(
                          priority,
                        ).withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? _getPriorityColor(priority)
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        avatar: isSelected
                            ? Icon(
                                Icons.check,
                                size: 16,
                                color: _getPriorityColor(priority),
                              )
                            : null,
                      );
                    }).toList(),
                  ),
                  if (_selectedPriority == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Please select a priority level',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Size selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Clothing Size',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: _sizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return ChoiceChip(
                        label: Text(size),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSize = selected ? size : null;
                          });
                        },
                        selectedColor: Colors.blue.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Color selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favorite Color',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: _colors.map((colorData) {
                      final colorName = colorData['name'] as String;
                      final color = colorData['color'] as Color;
                      final isSelected = _selectedColor == colorName;
                      return ChoiceChip(
                        label: Text(colorName),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedColor = selected ? colorName : null;
                          });
                        },
                        selectedColor: color.withOpacity(0.2),
                        avatar: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: isSelected ? color : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Delivery option selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Option',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _deliveryOptions.map((option) {
                      final optionName = option['name'] as String;
                      final icon = option['icon'] as IconData;
                      final description = option['desc'] as String;
                      final isSelected = _selectedDelivery == optionName;
                      return ChoiceChip(
                        label: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              size: 20,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              optionName,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedDelivery = selected ? optionName : null;
                          });
                        },
                        selectedColor: Colors.green.shade100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedPriority != null
                    ? () {
                        setState(() {
                          _submittedData =
                              '''
Priority: $_selectedPriority
Size: ${_selectedSize ?? 'Not selected'}
Color: ${_selectedColor ?? 'Not selected'}
Delivery: ${_selectedDelivery ?? 'Not selected'}''';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Choices saved successfully!'),
                          ),
                        );
                      }
                    : null,
                child: const Text('Save Choices'),
              ),
            ),

            // Display submitted data
            if (_submittedData.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Your Selections:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(_submittedData),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Low':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
      case 'Urgent':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
