import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:expense_tracker/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _state = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _state.currentState!.dispose();
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        name: "Sign Up",
        isBold: true,
        isCenterTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _state,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _topTexts(),
                const SizedBox(height: 24),
                _textFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _topTexts() {
    return Column(
      children: [
        Text(
          NameConstants.welcomeMessage,
          style: CommonTextStyles.boldTextStyle(),
        ),
        const SizedBox(height: 2),
        Text(
          NameConstants.signUpToContinue,
          style: CommonTextStyles.semiBoldTextStyle(),
        ),
      ],
    );
  }

  _textFields() {
    return Column(
      children: [
        CommonTextFormField(
          controller: _nameController,
          labelText: NameConstants.enterName,
          validator: (value) {
            if (value != null) {
              if (value.trim().isEmpty) {
                return NameConstants.pleaseEnterValidName;
              }
              return null;
            } else {
              return NameConstants.nameCannotBeEmpty;
            }
          },
        ),
        const SizedBox(height: 12),
        CommonTextFormField(
          controller: _numberController,
          labelText: NameConstants.enterPhone,
          icon: IconConstants.phoneIcon,
          type: TextInputType.phone,
          validator: (value) {
            if (value != null) {
              if (value.length != 10) {
                return NameConstants.enterValidNumber;
              }
            } else {
              return NameConstants.numberCannotBeEmpty;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CommonElevatedButton(
          buttonText: NameConstants.saveDetails,
          onPressed: () {
            if (_state.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else {
              print("Error");
            }
          },
        ),
      ],
    );
  }
}
