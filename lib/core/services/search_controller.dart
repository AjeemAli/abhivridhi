import 'dart:async';

import 'package:abhivridhiapp/core/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/search_reponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchOrderController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<String> recentSearches = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<SearchData> searchResult = Rxn<SearchData>();

  Timer? _saveTimer;
  static const String _storageKey = 'recentSearches';

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedSearches = prefs.getStringList(_storageKey) ?? [];
      recentSearches.assignAll(savedSearches);
    } catch (e) {
      debugPrint('Error loading recent searches: $e');
    }
  }

  Future<void> _saveRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, recentSearches);
    } catch (e) {
      debugPrint('Error saving recent searches: $e');
    }
  }

  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 300), _saveRecentSearches);
  }

  Future<void> searchOrder(String orderId) async {
    if (orderId.isEmpty) return;

    isLoading.value = true;
    isSearching.value = true;
    errorMessage.value = '';
    searchResult.value = null;

    try {
      final response = await _apiService.postRequest(
        'app/search_order',
        requiresAuth: true,
        data: {
          'order_id': orderId.trim(),
        },
      );

      if (response != null && response['status'] == true) {
        if (response['searchData'] != null) {
          searchResult.value = SearchData.fromJson(response['searchData']);
          _addToRecentSearches(orderId);
        } else {
          errorMessage.value = response['message'] ?? 'Order not found';
        }
      } else {
        errorMessage.value = response?['message'] ?? 'This order is not available';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isSearching.value = false;
    }
  }





  void _addToRecentSearches(String orderId) {
    if (!recentSearches.contains(orderId)) {
      recentSearches.insert(0, orderId);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
      _scheduleSave();
    }
  }

  void removeRecentSearch(String search) {
    recentSearches.remove(search);
    _scheduleSave();
  }

  void clearRecentSearches() {
    recentSearches.clear();
    _saveRecentSearches();
  }

  Future<void> scanQRCode() async {
    // Implement actual QR scanning logic
    const scannedOrderId = 'ORD12345'; // Mock data
    searchOrder(scannedOrderId);
  }

  @override
  void onClose() {
    _saveTimer?.cancel();
    super.onClose();
  }
}