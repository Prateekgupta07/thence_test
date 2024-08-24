import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence_test/services/http.dart';
import 'package:uni_links/uni_links.dart';
import 'bloc/plant_events.dart';
import 'models/plant_model.dart';
import 'screens/home_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/plant_detail_screen.dart';

void main() {
  runApp(MyApp());
  handleDeepLink();
}

void handleDeepLink() async {
  try {
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      _navigateToDeepLink(initialLink);
    }

    linkStream.listen((String? link) {
      if (link != null) {
        _navigateToDeepLink(link);
      }
    });
  } catch (e) {
    print("Error handling deep link: $e");
  }
}

void _navigateToDeepLink(String link) {
  final uri = Uri.parse(link);
  final id = uri.pathSegments.last;

  final context = navigatorKey.currentState?.overlay?.context;
  if (context != null) {
    Navigator.pushNamed(context, '/product', arguments: {'id': id});
  } else {
    print("Context is null. Unable to navigate.");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlantBloc()..add(FetchPlants()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Deep Linking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PlantListPage(),
          '/product': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            final id = args['id']!;
            return ProductDetailPage(productId: id);
          },
        },
        onGenerateRoute: (settings) {
          if (settings.name?.startsWith('/product') ?? false) {
            final uri = Uri.parse(settings.name!);
            final id = uri.pathSegments.last;

            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<PlantBloc>(context),
                child: ProductDetailPage(productId: id),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlantBloc, PlantState>(
        builder: (context, state) {
          if (state is PlantLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } else if (state is PlantLoaded) {
            final intId = int.tryParse(productId);
            if (intId == null) {
              return const NotFoundScreen();
            }

            final plant = state.plants.firstWhere(
                  (plant) => plant.id == intId,
              orElse: () => Plant(
                id: -1,
                imageUrl: '',
                name: 'Not Found',
                rating: 0.0,
                displaySize: 0,
                availableSize: [],
                unit: '',
                price: '',
                priceUnit: '',
                description: 'The requested plant was not found.',
              ),
            );

            if (plant.id==-1) {
              return const NotFoundScreen();
            }

            return PlantDetailPage(plant: plant);
          } else if (state is PlantError) {
            return const Center(child: Text('Failed to load plants'));
          } else {
            return const Center(child: Text('No plants available'));
          }
        },
      ),
    );
  }
}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
