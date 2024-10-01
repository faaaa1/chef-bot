import 'package:google_generative_ai/google_generative_ai.dart';
import '../constants/gemini_api_key.dart';

final GenerativeModel geminiModel = GenerativeModel(
  model: 'gemini-1.5-flash',
  apiKey: geminiApiKey,
);
