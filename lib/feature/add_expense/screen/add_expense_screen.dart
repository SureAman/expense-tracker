import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/utils/validation_utils.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/core/widgets/common_scaffold_messanger.dart';
import 'package:expense_tracker/feature/add_expense/bloc/add_expense_bloc.dart';
import 'package:expense_tracker/feature/add_expense/widgets/add_expense_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpenseScreen extends StatefulWidget {
  final String groupId;
  const AddExpenseScreen({super.key, required this.groupId});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen>
    with ValidationUtils {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: _commonAppBar(),
      body: _buildForm(),
    );
  }

  CommonAppBar _commonAppBar() => const CommonAppBar(
    name: NameConstants.addExpense,
    isCenterTitle: true,
    backArrow: true,
    isBold: true,
  );

  Widget _buildForm() => Column(
    children: [
      Center(
        child: AddExpenseForm(
          descriptionController: _descriptionController,
          amountController: _amountController,
          formKey: _formkey,
        ),
      ),
      const SizedBox(height: 24),
      CommonElevatedButton(
        buttonText: NameConstants.selectContacts,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _modalBottomSheet(
              context,
              context.read<AddExpenseBloc>(),
              widget.groupId,
            );
          } else {
            return;
          }
        },
        icon: IconConstants.addIcon,
      ),
    ],
  );

  Future<dynamic> _modalBottomSheet(
    BuildContext context,
    AddExpenseBloc bloc,
    String groupId,
  ) {
    bloc.add(FetchContactsList(groupId: groupId));
    return showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      builder: (newContext) {
        return _blocProvider(bloc, context);
      },
    );
  }

  BlocProvider<AddExpenseBloc> _blocProvider(
    AddExpenseBloc bloc,
    BuildContext addExpenseContext,
  ) => BlocProvider.value(
    value: bloc,
    child: BlocConsumer<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state.status == AddExpenseStatus.success) {
          CommonScaffoldMessenger.show(
            context: context,
            message: "Expense Added Successfully",
            errorType: ErrorType.success,
          );
          Navigator.pop(context);
          Future.microtask(() => Navigator.of(addExpenseContext).pop(true));
        }
      },
      builder: (context, state) {
        if (state.status == AddExpenseStatus.loading ||
            state.contactStatus == FetchContactsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.contactStatus == FetchContactsStatus.success) {
          final contacts = state.model;
          final selectedIndices = state.selectedIndices;
          if (contacts.isEmpty) {
            return const Center(child: Text("No contacts available"));
          }
          return _modalBottomWidget(contacts, selectedIndices, context);
        }
        return const SizedBox(
          height: 100,
          child: Center(child: Text(NameConstants.noDataAvailable)),
        );
      },
    ),
  );

  Padding _modalBottomWidget(
    List<ContactsModel> contacts,
    Set<int> selectedIndices,
    BuildContext context,
  ) => Padding(
    padding: const EdgeInsets.only(top: 24),
    child: Column(
      children: [
        Expanded(child: _contactWidget(contacts, selectedIndices)),
        CommonElevatedButton(
          buttonText: NameConstants.complete,
          onPressed: () {
            context.read<AddExpenseBloc>().add(
              AddExpenseEvent(
                expenseModel: ExpenseModel(
                  expenseName: _descriptionController.text,
                  id: "${UniqueKey()}",
                  expenseAmount: double.tryParse(_amountController.text) ?? 0.0,
                  groupId: widget.groupId,
                ),
                contactModel: contacts,
              ),
            );
          },
          icon: IconConstants.addIcon,
        ),
        const SizedBox(height: 20),
      ],
    ),
  );

  ListView _contactWidget(
    List<ContactsModel> contacts,
    Set<int> selectedIndices,
  ) => ListView.builder(
    itemCount: contacts.length,
    itemBuilder: (context, index) {
      final eachContacts = contacts[index];
      return ListTile(
        title: Text(
          eachContacts.contactName,
          style: CommonTextStyles.semiBoldTextStyle(),
        ),
        subtitle: _numberWidget(eachContacts),
        trailing: Checkbox(
          key: ValueKey(eachContacts.contactId),
          value: selectedIndices.contains(index),
          onChanged: (value) {
            _onCheckboxChanged(value, index, context);
          },
        ),
      );
    },
  );

  Widget _numberWidget(ContactsModel eachContacts) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        eachContacts.contactNumber
            .map(
              (number) =>
                  Text(number, style: CommonTextStyles.normalTextStyle()),
            )
            .toList(),
  );

  void _onCheckboxChanged(bool? value, int index, BuildContext context) {
    context.read<AddExpenseBloc>().add(
      SelectedContactEvent(index: index, value: value),
    );
  }
}
