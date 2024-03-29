import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/localization/language.dart';
import 'package:samba_public_app/localization/language_app_provider.dart';
import 'package:samba_public_app/router/router.dart';
import 'package:samba_public_app/theme/theme_data.dart';
import 'package:samba_public_app/theme/theme_provider.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MainApp()));
}

///This widget is the root of your application.
class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final isTrueBlack = ref.watch(appThemeTrueBlackProvider);
    final language = ref.watch(languageAppProvider).valueOrNull;
    return MaterialApp.router(
      routerConfig: router,
      onGenerateTitle: (context) => context.loc.appTitle,
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme(trueBlack: isTrueBlack),
      themeMode: themeMode,
      themeAnimationStyle: AnimationStyle.noAnimation,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: language?.locale,
    );
  }
}
