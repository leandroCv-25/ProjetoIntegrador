import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  const InputField(
      {required this.icon,
      required this.hint,
      required this.obscure,
      required this.stream,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                  icon: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: hint,
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  contentPadding: const EdgeInsets.only(
                      left: 5, right: 30, bottom: 15, top: 30),
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  errorStyle: const TextStyle(fontSize: 12, color: Colors.red)),
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: obscure,
            ),
          );
        });
  }
}
