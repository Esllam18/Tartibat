import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/profile_cubit.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'features/customer/data/services/favorites_service.dart';
import 'features/customer/data/services/cart_service.dart';
import 'features/customer/data/services/checkout_service.dart';
import 'features/customer/data/services/profile_service.dart';
import 'features/splash/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final favoritesService = await FavoritesService.getInstance();
  final cartService = await CartService.getInstance();
  final checkoutService = await CheckoutService.getInstance();
  final profileService = await ProfileService.getInstance();

  runApp(MyApp(
    favoritesService: favoritesService,
    cartService: cartService,
    checkoutService: checkoutService,
    profileService: profileService,
  ));
}

class MyApp extends StatelessWidget {
  final FavoritesService favoritesService;
  final CartService cartService;
  final CheckoutService checkoutService;
  final ProfileService profileService;

  const MyApp({
    super.key,
    required this.favoritesService,
    required this.cartService,
    required this.checkoutService,
    required this.profileService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (_) => FavoritesCubit(favoritesService),
        ),
        BlocProvider(
          create: (_) => CartCubit(cartService),
        ),
        BlocProvider(
          create: (_) => CheckoutCubit(checkoutService),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(profileService),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ترتيبات',
            locale: state.locale,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: ThemeData(
              primarySwatch: Colors.brown,
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
