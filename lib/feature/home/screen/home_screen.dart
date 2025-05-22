import 'package:expense_tracker/core/constants/icons.dart';
import 'package:expense_tracker/core/constants/names.dart';
import 'package:expense_tracker/core/models/group_model.dart';
import 'package:expense_tracker/core/route/route_names.dart';
import 'package:expense_tracker/core/styles/text_styles.dart';
import 'package:expense_tracker/core/widgets/common_app_bar.dart';
import 'package:expense_tracker/core/widgets/common_elevated_button.dart';
import 'package:expense_tracker/feature/home/bloc/home_bloc.dart';
import 'package:expense_tracker/feature/home/bloc/home_event.dart';
import 'package:expense_tracker/feature/home/bloc/home_state.dart';
import 'package:expense_tracker/feature/home/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeBloc>().add(FetchInitialData());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        name: NameConstants.home,
        isCenterTitle: true,
        isBold: true,
      ),
      body: _blocBuilder(),
      floatingActionButton: _elevatedButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  BlocBuilder<HomeBloc, HomeState> _blocBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildUi(state);
      },
    );
  }

  Column _buildUi(HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "${NameConstants.name} : ${state.name}",
            style: CommonTextStyles.customTextStyle(fontSize: 18),
          ),
        ),
        const Divider(),
        Expanded(
          child:
              state.groupModel.isNotEmpty
                  ? _groupList(state.groupModel)
                  : Center(
                    child: Text(
                      "No group found create one..",
                      style: CommonTextStyles.semiBoldTextStyle(),
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _groupList(List<GroupModel> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (_, index) {
        return InkWell(
          onTap:
              () => Navigator.pushNamed(
                context,
                RouteNames.expensedetails,
                arguments: {"groupId": model[index].id},
              ),
          child: GroupList(
            title: model[index].name,
            members: model[index].members,
          ),
        );
      },
    );
  }

  Widget _elevatedButton(BuildContext context) {
    return CommonElevatedButton(
      onPressed: () async {
        final isAdded =
            await Navigator.pushNamed(
              context,
              RouteNames.creategroup,
              arguments: context.read<HomeBloc>(),
            ) ??
            false;

        if (isAdded == true) {
          context.read<HomeBloc>().add(FetchInitialData());
        }
      },

      icon: IconConstants.groupAddIcon,
      buttonText: NameConstants.createGroup,
    );
  }
}
