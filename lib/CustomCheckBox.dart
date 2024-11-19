import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: _onCheckboxChanged,
    );
  }
}
