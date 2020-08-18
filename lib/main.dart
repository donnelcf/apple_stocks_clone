import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_app_clone/screens/main_screen.dart';
import 'package:stocks_app_clone/state/search_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchState()),
      ],
      child: MainScreen(),
    ),
  );
}
