import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_hike_flutter/pages/home.dart';
import 'package:m_hike_flutter/utils/colors.dart';
import 'package:m_hike_flutter/utils/dimens.dart';
import 'package:m_hike_flutter/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: backgroundColor,
          primaryColor: primaryColor,
          primarySwatch: primarySwatch,
          scaffoldBackgroundColor: backgroundColor,
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: primaryColor.withOpacity(0.6),
              selectionHandleColor: primaryColor,
              cursorColor: whiteColor
          ),
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: fontColor),
            toolbarTextStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: fontHeadingSubTitle,
                fontWeight: FontWeight.w500,
                color: blackColor
            ),
            titleTextStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: fontHeadingSubTitle,
                fontWeight: FontWeight.w500,
                color: blackColor
            ),
          ),
          iconTheme: IconThemeData(color: fontColor),
        ),
        home: const Home(),
      ),
    );
  }
}