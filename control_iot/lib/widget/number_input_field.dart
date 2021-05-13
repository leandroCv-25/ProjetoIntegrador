import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  final String name;
  final Function(String)? function;
  final String edit;
  final Function(String?)? save;
  final String Function(String?)? validator;
  final dynamic value;
  const NumberInputField({
    required this.name,
    required this.value,
    this.function,
    this.save,
    this.edit = "numero",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: 100,
        child: TextFormField(
          textAlign: TextAlign.end,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onSaved: save,
          initialValue: "$value",
          onChanged: (text) {
            if (text.isNotEmpty && function != null) {
              function!(text);
            }
          },
          onFieldSubmitted: (text) {
            if (text.isNotEmpty && save != null) save!(text);
          },
          validator: (text) {
            if (validator != null) {
              validator!(text);
            }
            if (text!.isEmpty) {
              return "Digite um $edit valido.";
            }
            return null;
          },
          decoration: InputDecoration(
              prefix: Text(name),
              prefixStyle: Theme.of(context).textTheme.bodyText1),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
