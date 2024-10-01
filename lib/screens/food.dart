// ignore_for_file: library_private_types_in_public_api

import 'package:google_generative_ai/google_generative_ai.dart';

import '../constants/prompts.dart';
import '../widgets/base_page.dart';

class FoodPage extends BasePage {
  const FoodPage({super.key});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends BasePageState<FoodPage> {
  @override
  String get title => 'Analisis Bahan Makanan 😋';

  @override
  TextPart get prompt => TextPart(foodAnalysisPrompt);

  @override
  String get task => 'Pilih gambar bahan makanan untuk eksplor.';

  @override
  String get backgroundAsset => 'assets/backgrounds/food_home_bk.json';

  @override
  String get loaderAsset => 'assets/backgrounds/food_loader.json';
}
