import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:locale_explore/nstack/nstack.dart';
import 'package:locale_explore/presentation/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const <LocalizationsDelegate>[
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (c, widget) {
        return NStackWidget(
          platformOverride: AppOpenPlatform.android,
          child: _SystemLocaleHandlerWidget(child: widget!),
        );
      },
      home: const HomeScreen(),
    );
  }
}

class _SystemLocaleHandlerWidget extends StatefulWidget {
  const _SystemLocaleHandlerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<_SystemLocaleHandlerWidget> createState() =>
      _SystemLocaleHandlerWidgetState();
}

class _SystemLocaleHandlerWidgetState extends State<_SystemLocaleHandlerWidget>
    with WidgetsBindingObserver {
  void _changeAppLocale(Locale locale) {
    final scope = NStackScope.of(context);
    final supportedLocales = scope.nstack.supportedLocales;
    final supportedLocale = supportedLocales.firstWhere(
      (e) => locale.languageCode.startsWith(e.languageCode),
      orElse: () => supportedLocales.first,
    );

    scope.changeLanguage(supportedLocale);
  }

  Locale _getDefaultSystemLocale() {
    return Locale(Platform.localeName);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _changeAppLocale(_getDefaultSystemLocale());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (locales != null) {
      _changeAppLocale(locales.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
