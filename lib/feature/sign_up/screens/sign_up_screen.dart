import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/route/app_routes.dart';
import 'package:expense_tracker/core/route/route_names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/utils/validation_utils.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_text_form_field.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_bloc.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_event.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationUtils {
  final GlobalKey<FormState> _state = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _state.currentState?.dispose();
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
        child: Stack(
          children: [
            _buildForm(),
            _circularProgressIndicator(),
            _navigateToNewScreen(),
          ],
        ),
      ),
    );
  }

  BlocListener<SignupBloc, SignupState> _navigateToNewScreen() {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen:
          (previous, current) =>
              previous.isSubmittedSuccessfully !=
              current.isSubmittedSuccessfully,
      listener: (context, state) {
        if (state.isSubmittedSuccessfully) {
          Navigator.pushReplacementNamed(context, RouteNames.home);
        }
      },
      child: const SizedBox.shrink(),
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

  Widget _topTexts() {
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

  Widget _textFields() {
    return Column(
      children: [
        CommonTextFormField(
          controller: _nameController,
          labelText: NameConstants.enterName,
          validator: validateName,
        ),
        const SizedBox(height: 12),
        CommonTextFormField(
          controller: _numberController,
          labelText: NameConstants.enterPhone,
          icon: IconConstants.phoneIcon,
          type: TextInputType.phone,
          validator: validateNumber,
        ),
        const SizedBox(height: 16),
        CommonElevatedButton(
          buttonText: NameConstants.saveDetails,
          onPressed: () {
            if (_state.currentState!.validate()) {
              context.read<SignupBloc>().add(
                FormSubmitted(
                  name: _nameController.text,
                  number: _numberController.text,
                ),
              );
              print("Called");
            } else {
              print("Error");
            }
          },
        ),
      ],
    );
  }

  Widget _circularProgressIndicator() {
    return BlocBuilder<SignupBloc, SignupState>(
      //buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink();
      },
    );
  }
}
