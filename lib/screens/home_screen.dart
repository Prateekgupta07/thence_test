import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence_test/models/plant_model.dart';
import 'package:thence_test/screens/plant_detail_screen.dart';
import '../bloc/plant_events.dart';
import '../services/http.dart';
import '../utils/widgets.dart';

class PlantListPage extends StatelessWidget {
  final List<String> category = [
    "All",
    "Succulents",
    "In pots",
    "Dried Flowers",
    "Ferns",
    "Air Plants",
    "Orchids",
    "Cacti",
    "Flowering Plants",
    "Herbs",
    "Vegetables"
  ];

  PlantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlantBloc()..add(FetchPlants()),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 6.0, top: 10),
            child: Text(
              'All plants',
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Houseplants",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 32,
              ),
              BlocBuilder<PlantBloc, PlantState>(
                builder: (context, state) {
                  if (state is PlantLoading) {
                    return shimmer_loading(category);
                  } else if (state is PlantLoaded) {
                    final plants = state.plants;
                    return Expanded(
                      child: Column(
                        children: [
                          horizontal_listview(category),
                          const SizedBox(height: 24),
                          Expanded(
                            child: ListView.builder(
                              itemCount: plants.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 2) {
                                  return free_shipping_banner();
                                }

                                final plantIndex =
                                    index > 2 ? index - 1 : index;
                                final plant = plants[plantIndex];

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlantDetailPage(plant: plant),
                                      ),
                                    );
                                  },
                                  child: plant_tile(index, plant),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is PlantError) {
                    return const Center(child: Text('Failed to load plants'));
                  } else {
                    return const Center(child: Text('Unexpected state'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
