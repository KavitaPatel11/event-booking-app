import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/domain/entities/booking.dart';
import 'features/home/domain/entities/home_event.dart';
import 'features/home/presentation/providers/theme_providers.dart';
import 'l10n/app_localizations.dart';

final box = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Directory dir =
      await getApplicationDocumentsDirectory(); // 💡 Ensure this is not null
  Hive.init(dir.path);

  Hive.registerAdapter(BookingAdapter());
  Hive.registerAdapter(HomeEventAdapter()); // 👈 Register here

  await Hive.openBox<Booking>('bookings');
  runApp(const ProviderScope(child: EventBookingApp()));
}

class EventBookingApp extends ConsumerWidget {
  const EventBookingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Event Booking',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
    );
  }
}
