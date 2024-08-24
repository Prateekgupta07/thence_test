import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:thence_test/models/plant_model.dart';
import 'package:thence_test/screens/plant_detail_screen.dart';

void main() {
  testWidgets('PlantDetailPage displays plant details correctly and handles back navigation', (WidgetTester tester) async {
    // Create a sample plant
    final plant = Plant(
      id: 1,
      name: 'Fiddle Leaf Fig',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/temp-e18cd.appspot.com/o/files%2Fplant1.png?alt=media&token=fdab412a-258d-4c8f-810c-6582698121af', // Use the original image URL
      price: "50",
      priceUnit: '\$',
      rating: 4.5,
      availableSize: [20, 30, 40],
      description: 'A large, striking plant with broad leaves.',
      displaySize: 21,
      unit: 'cm',
    );

    // Mock network image loading
    mockNetworkImagesFor(() async {
      // Build the PlantDetailPage widget
      await tester.pumpWidget(
        MaterialApp(
          home: PlantDetailPage(plant: plant),
        ),
      );

      // Verify that the plant details are displayed correctly
      expect(find.text('Fiddle Leaf Fig'), findsOneWidget);
      expect(find.text('50\$'), findsOneWidget);
      expect(find.text('⭐ 4.5'), findsOneWidget);
      expect(find.text('A large, striking plant with broad leaves.'), findsOneWidget);
      expect(find.text('Choose size'), findsOneWidget);

      // Verify that the image is displayed
      expect(find.byType(Image), findsOneWidget);

      // Tap the back button and verify navigation
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Ensure that the page was popped
      expect(find.text('Fiddle Leaf Fig'), findsNothing);
    });
  });
}
