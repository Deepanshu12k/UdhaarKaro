import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/basic_controller.dart';

//NameTextField
//PhoneTextField
//EmailTextField
//PasswordTextField
class NameTextField extends StatelessWidget {
  final String name;
  final String label;
  final Function callback;
  final TextEditingController controller;
  final InputDecoration decoration;

  const NameTextField(
      {this.name,
      @required this.label,
      @required this.callback,
        this.controller,
      @required this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: decoration.copyWith(labelText: label),
      initialValue: name,
      controller: controller,
      validator: (val) => val.isEmpty ? "This field is required" : null,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final String value;
  final String label;
  final TextEditingController controller;
  final Function callback;
  final bool enabled;
  final InputDecoration decoration;

  PhoneTextField(
      {this.value, this.label, this.controller, @required this.callback, this.enabled = true, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(labelText: label)
          : InputDecoration(labelText: label),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      enabled: enabled,
      keyboardType: TextInputType.number,
      initialValue: value,
      validator: (val) {
        if (val.length == 10 && int.parse(val[0]) >= 7) {
          return null;
        }
        return "Enter valid phone number";
      },
      cursorColor: redColor,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  final String value;
  final String label;
  final TextEditingController controller;
  final Function callback;
  final InputDecoration decoration;

  EmailTextField(
      {this.value, this.label, this.controller, @required this.callback, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(labelText: label)
          : InputDecoration(labelText: label),
      initialValue: value,
      validator: (val) {
        if (val.isNotEmpty &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val)) {
          return null;
        }
        return "Enter valid email";
      },
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String value;
  final String label;
  final Function callback;
  final TextEditingController controller;
  final InputDecoration decoration;

  PasswordTextField(
      {this.value, this.label, this.controller,  @required this.callback, this.decoration});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final basicController = Get.put(BasicController(), tag: "basic-control");

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      TextFormField(
        decoration: (widget.decoration != null)
            ? widget.decoration.copyWith(
                suffixIcon: IconButton(
                    color: blackColor,
                    onPressed: () => basicController.passToggle(),
                    icon: Icon(basicController.obscureText.value
                        ? Icons.lock_open
                        : Icons.lock)),
                labelText: widget.label,
              )
            : InputDecoration(
                suffixIcon: IconButton(
                    color: blackColor,
                    onPressed: () => basicController.passToggle(),
                    icon: Icon(basicController.obscureText.value
                        ? Icons.lock_open
                        : Icons.lock)),
                labelText: widget.label,
              ),
        initialValue: widget.value,
        validator: (val) => val.length < 6 || val.length > 20
            ? 'Password should be between 6 to 20 chars.'
            : null,
        onChanged: (val) {
          widget.callback(val);
        },
        obscureText: basicController.obscureText.value,
      )
    );
  }
}

class OTPTextField extends StatelessWidget {
  final String label;
  final Function callback;
  final InputDecoration decoration;

  OTPTextField({this.label, @required this.callback, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(labelText: label)
          : InputDecoration(labelText: label),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6)
      ],
      validator: (val) {
        if (val.length == 6) {
          return null;
        }
        return "Enter 4 digit otp number";
      },
      keyboardType: TextInputType.number,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class TransactionTextField extends StatelessWidget {
  final String value;
  final String label;
  final Function callback;
  final InputDecoration decoration;

  TransactionTextField({this.value, this.label, @required this.callback, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: (decoration != null)
          ? decoration.copyWith(labelText: label)
          : InputDecoration(labelText: label),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(7)
      ],
      validator: (val) => val.isEmpty ? "Enter Some Amount" : null,
      keyboardType: TextInputType.number,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}