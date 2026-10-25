import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:souqna_anaqa/models/category.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/app_search_bar.dart';
import 'package:souqna_anaqa/widget/category_chip_list.dart';

void main() {
  testWidgets('category chips and search bar trigger their callbacks', (
    tester,
  ) async {
    int? selectedId;
    var searchTapped = false;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Responsive.designSize,
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CategoryChipList(
                  categories: [Category(id: 9, name: 'Clothing')],
                  selectedId: null,
                  onSelected: (id) => selectedId = id,
                ),
                AppSearchBar(hint: 'Search', onTap: () => searchTapped = true),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Clothing'));
    await tester.pump();
    expect(selectedId, 9);

    await tester.tap(find.byType(TextField));
    await tester.pump();
    expect(searchTapped, isTrue);
  });
}
