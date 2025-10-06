import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tira_fe/data/atasan/data_atasan_cubit.dart';
import 'package:tira_fe/data/auth/auth_cubit.dart';
import 'package:tira_fe/data/data_reseller/data_reseller_cubit.dart';
import 'package:tira_fe/data/data_reseller/download_data_cubit.dart';
import 'package:tira_fe/data/member/data_member_cubit.dart';
import 'package:tira_fe/service/api_service.dart';
import 'package:tira_fe/utils/extension.dart';
import 'package:tira_fe/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ApiService().initializeAuthHeader();
  runApp(MyApp(appRoute: AppRoute()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});

  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    const phoneMaxWidth = 480.0;
    final mq = MediaQuery.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(ApiService())),
        BlocProvider(create: (context) => DataMemberCubit(ApiService())),
        BlocProvider(create: (context) => DataAtasanCubit(ApiService())),
        BlocProvider(create: (context) => DataResellerCubit(ApiService())),
        BlocProvider(create: (context) => DownloadDataCubit(ApiService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: ClampingScrollBehavior(),
        title: 'Test Tira',
        theme: ThemeData(useMaterial3: true),
        onGenerateRoute: appRoute.onGenerateRoute,
        builder: (context, child) {
          final currentScale = mq.textScaler.scale(16.0) / 16.0;
          final clampedScale = currentScale.clamp(1.0, 1.2);
          final clampedTextScaler = TextScaler.linear(clampedScale);

          final phoneWidth = mq.size.width.clamp(0.0, phoneMaxWidth);
          final horizontalLetterbox = (mq.size.width - phoneWidth) / 2.0;

          final phoneMQ = mq.copyWith(
            size: Size(phoneWidth, mq.size.height),
            textScaler: clampedTextScaler,
          );

          final framedChild = MediaQuery(
            data: phoneMQ,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalLetterbox),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: phoneMaxWidth),
                  child: child,
                ),
              ),
            ),
          );
          return framedChild;
        },
      ),
    );
  }
}
