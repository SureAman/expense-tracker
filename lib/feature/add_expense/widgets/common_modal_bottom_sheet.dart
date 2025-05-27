import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/models/contacts_model.dart';
import 'package:expense_tracker/core/models/expense_model.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/feature/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonModalBottomSheet extends StatelessWidget {
  final AddExpenseBloc bloc;
  final String groupId;
  final ExpenseModel model;
  const CommonModalBottomSheet({
    super.key,
    required this.bloc,
    required this.groupId,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _modalBottomSheet(context, bloc, groupId);
      },
    );
  }

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
        return _blocProvider(bloc);
      },
    );
  }

  BlocProvider<AddExpenseBloc> _blocProvider(AddExpenseBloc bloc) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<AddExpenseBloc, AddExpenseState>(
        listener: (context, state) {
          if (state.status == AddExpenseStatus.success) {
            Navigator.pop(context);
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
              return const Center(child: Text(NameConstants.noDataAvailable));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  Expanded(child: _contactWidget(contacts, selectedIndices)),
                  CommonElevatedButton(
                    buttonText: NameConstants.complete,
                    onPressed: () {
                      context.read<AddExpenseBloc>().add(
                        AddExpenseEvent(
                          expenseModel: model,
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
          }
          return const SizedBox(
            height: 100,
            child: Center(child: Text(NameConstants.noDataAvailable)),
          );
        },
      ),
    );
  }

  ListView _contactWidget(
    List<ContactsModel> contacts,
    Set<int> selectedIndices,
  ) {
    return ListView.builder(
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
  }

  Widget _numberWidget(ContactsModel eachContacts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          eachContacts.contactNumber
              .map(
                (number) =>
                    Text(number, style: CommonTextStyles.normalTextStyle()),
              )
              .toList(),
    );
  }

  void _onCheckboxChanged(bool? value, int index, BuildContext context) {
    context.read<AddExpenseBloc>().add(
      SelectedContactEvent(index: index, value: value),
    );
  }
}
