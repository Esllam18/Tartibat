import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tartibat/core/services/seed_data_service.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/profile_cubit.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'features/merchant/bloc/merchant_products_cubit.dart';
import 'features/merchant/bloc/merchant_orders_cubit.dart';
import 'features/merchant/bloc/merchant_profile_cubit.dart';
import 'features/customer/data/services/favorites_service.dart';
import 'features/customer/data/services/cart_service.dart';
import 'features/customer/data/services/checkout_service.dart';
import 'features/customer/data/services/profile_service.dart';
import 'features/merchant/data/services/merchant_products_service.dart';
import 'features/merchant/data/services/merchant_orders_service.dart';
import 'features/merchant/data/services/merchant_profile_service.dart';
import 'features/splash/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SeedDataService.clearAllData();
  await SeedDataService.initialize();
  // Initialize Customer services
  final favoritesService = await FavoritesService.getInstance();
  final cartService = await CartService.getInstance();
  final checkoutService = await CheckoutService.getInstance();
  final profileService = await ProfileService.getInstance();

  // Initialize Merchant services
  final merchantProductsService = await MerchantProductsService.getInstance();
  final merchantOrdersService = await MerchantOrdersService.getInstance();
  final merchantProfileService = await MerchantProfileService.getInstance();

  runApp(MyApp(
    favoritesService: favoritesService,
    cartService: cartService,
    checkoutService: checkoutService,
    profileService: profileService,
    merchantProductsService: merchantProductsService,
    merchantOrdersService: merchantOrdersService,
    merchantProfileService: merchantProfileService,
  ));
}

class MyApp extends StatelessWidget {
  final FavoritesService favoritesService;
  final CartService cartService;
  final CheckoutService checkoutService;
  final ProfileService profileService;
  final MerchantProductsService merchantProductsService;
  final MerchantOrdersService merchantOrdersService;
  final MerchantProfileService merchantProfileService;

  const MyApp({
    super.key,
    required this.favoritesService,
    required this.cartService,
    required this.checkoutService,
    required this.profileService,
    required this.merchantProductsService,
    required this.merchantOrdersService,
    required this.merchantProfileService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..getSavedLanguage()),

        // Customer Cubits
        BlocProvider(create: (_) => FavoritesCubit(favoritesService)),
        BlocProvider(create: (_) => CartCubit(cartService)),
        BlocProvider(create: (_) => CheckoutCubit(checkoutService)),
        BlocProvider(create: (_) => ProfileCubit(profileService)),

        // Merchant Cubits
        BlocProvider(
            create: (_) => MerchantProductsCubit(merchantProductsService)),
        BlocProvider(create: (_) => MerchantOrdersCubit(merchantOrdersService)),
        BlocProvider(
            create: (_) => MerchantProfileCubit(merchantProfileService)),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ترتيبات',
            locale: state.locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
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
