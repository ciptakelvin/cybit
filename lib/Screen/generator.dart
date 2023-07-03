import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Generator extends StatefulWidget {
  const Generator({super.key});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _passLengthSetting = TextEditingController();

  final ValueNotifier<bool> _character = ValueNotifier(false);
  final ValueNotifier<bool> _symbol = ValueNotifier(false);
  final ValueNotifier<bool> _number = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.2,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "GENERATOR",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: kToolbarHeight - 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _pass,
                    builder: (_, pass, ___) => TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      controller: _pass,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        suffixIcon: pass.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _pass.clear();
                                },
                                icon: const Icon(Icons.close))
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: _pass.text));

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Password Copied"),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const SizedBox(height: kToolbarHeight - 20),
            Text(
              "Generator Setting",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GeneratorSetting(
                  valueNotifier: _character,
                  label: 'Character',
                ),
                _GeneratorSetting(
                  valueNotifier: _symbol,
                  label: 'Symbol',
                ),
                _GeneratorSetting(
                  valueNotifier: _number,
                  label: 'Number',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _passLengthSetting,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text("Length"),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        if (!_character.value &&
                            !_number.value &&
                            !_symbol.value) {
                          _showError(context,
                              message: "Choose at least one setting.");

                          return;
                        }

                        if (_passLengthSetting.text.isEmpty) {
                          _showError(context, message: "Length cannot empty");

                          return;
                        }

                        var lengthCount = int.parse(_passLengthSetting.text);

                        // length di limit 30 karakter, review required
                        if (lengthCount > 30) {
                          _showError(context,
                              message:
                                  "The length cannot exceed 30 characters.");

                          return;
                        }

                        var generatedPass = generatePassword(
                          int.parse(_passLengthSetting.text),
                          includeCharacters: _character.value,
                          includeSymbols: _symbol.value,
                          includeNumbers: _number.value,
                        );

                        _pass.text = generatedPass;
                      },
                      child: const Text("Generate"),
                    ),
                    const SizedBox(width: 30),
                    ValueListenableBuilder(
                      valueListenable: _pass,
                      builder: (_, pass, ___) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: pass.text.isNotEmpty
                            ? () {
                                // Navigator.pop(context, _pass.text);
                                // Aksi ketika save
                              }
                            : null,
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showError(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message ?? ''),
      ),
    );
  }

  @override
  void dispose() {
    _character.dispose();
    _symbol.dispose();
    _number.dispose();
    _pass.dispose();
    _passLengthSetting.dispose();
    super.dispose();
  }
}

class _GeneratorSetting extends StatelessWidget {
  const _GeneratorSetting({
    Key? key,
    required ValueNotifier<bool> valueNotifier,
    required this.label,
  })  : _valueNotifier = valueNotifier,
        super(key: key);

  final ValueNotifier<bool> _valueNotifier;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        _valueNotifier.value = !_valueNotifier.value;
      },
      icon: ValueListenableBuilder(
        valueListenable: _valueNotifier,
        builder: (_, isChecked, ___) => Icon(
          isChecked
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank_outlined,
          color: Colors.black,
        ),
      ),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

// Sementara saya bikin di sini mas, mungkin nanti bisa dipindah ke utils folder
String generatePassword(
  int length, {
  bool includeCharacters = true,
  bool includeNumbers = true,
  bool includeSymbols = true,
}) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const numberChars = '0123456789';
  const symbolChars = '!@#\$%^&*()-=_+[]{}|;:,.<>/?';

  String chars = '';
  if (includeCharacters) chars += characters;
  if (includeNumbers) chars += numberChars;
  if (includeSymbols) chars += symbolChars;

  String password = '';
  final random = Random();

  for (int i = 0; i < length; i++) {
    final index = random.nextInt(chars.length);
    password += chars[index];
  }

  return password;
}
