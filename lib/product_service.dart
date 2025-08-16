import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'appwrite_service.dart';
import 'store_model.dart';

class ProductService {
  final Databases _databases;

  ProductService(this._databases);

  Future<List<Product>> getProductsByStore(
    String storeId, {
    int limit = 20,
    int offset = 0,
    String? categoryId,
  }) async {
    try {
      final queries = [
        Query.equal('storeId', storeId),
        Query.limit(limit),
        Query.offset(offset),
        if (categoryId != null) Query.equal('categoryId', categoryId),
      ];

      final response = await _databases.listDocuments(
        databaseId: 'mahllnadb',
        collectionId: 'Products',
        queries: queries,
      );

      return response.documents
          .map((doc) => Product.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Error fetching products: $e');
      throw Exception('فشل في تحميل المنتجات');
    }
  }

  Future<List<Product>> getProductsByCategory(
    String categoryId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: 'mahllnadb',
        collectionId: 'Products',
        queries: [
          Query.equal('categoryId', categoryId),
          Query.limit(limit),
          Query.offset(offset),
        ],
      );

      return response.documents
          .map((doc) => Product.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Error fetching products by category: $e');
      throw Exception('فشل في تحميل المنتجات حسب التصنيف');
    }
  }
}
