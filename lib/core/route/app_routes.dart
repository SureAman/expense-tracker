import 'package:expense_tracker/core/route/route_names.dart';
import 'package:expense_tracker/feature/add_expense/screen/add_expense_screen.dart';
import 'package:expense_tracker/feature/create_group/bloc/bloc/create_group_bloc.dart';
import 'package:expense_tracker/feature/create_group/screen/create_group_screen.dart';
import 'package:expense_tracker/feature/expense_details/bloc/expense_details_bloc.dart';
import 'package:expense_tracker/feature/expense_details/screen/expense_details_screen.dart';
import 'package:expense_tracker/feature/home/bloc/home_bloc.dart';
import 'package:expense_tracker/feature/home/screen/home_screen.dart';
import 'package:expense_tracker/feature/sign_up/bloc/signup_bloc.dart';
import 'package:expense_tracker/feature/sign_up/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signup:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => SignupBloc(),
                child: const SignUpScreen(),
              ),
        );

      case RouteNames.home:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => HomeBloc(),
                child: const HomeScreen(),
              ),
        );

      case RouteNames.expensedetails:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => ExpenseDetailsBloc(),
                child: ExpenseDetailsScreen(groupId: args['groupId'] as String),
              ),
        );
      case RouteNames.addexpense:
        return MaterialPageRoute(builder: (_) => const AddExpenseScreen());
      case RouteNames.creategroup:
        //final args = settings.arguments as HomeBloc;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => CreateGroupBloc(),
                child: const CreateGroupScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}
