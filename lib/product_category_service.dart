import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'appwrite_service.dart';
import 'product_category_model.dart';

class ProductCategoryService {
  final Databases _databases;

  ProductCategoryService(this._databases);

  Future<List<ProductCategory>> getCategoriesByStore(String storeId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: 'mahllnadb',
        collectionId: 'ProductCategories',
        queries: [Query.equal('storeId', storeId), Query.orderAsc('order')],
      );

      return response.documents
          .map((doc) => ProductCategory.fromMap(doc.data))
          .toList();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      throw Exception('فشل في تحميل التصنيفات');
    }
  }

  Future<ProductCategory> createCategory(ProductCategory category) async {
    try {
      final response = await _databases.createDocument(
        databaseId: 'mahllnadb',
        collectionId: 'ProductCategories',
        documentId: ID.unique(),
        data: category.toMap(),
      );

      return ProductCategory.fromMap(response.data);
    } catch (e) {
      debugPrint('Error creating category: $e');
      throw Exception('فشل في إنشاء التصنيف');
    }
  }

  Future<ProductCategory> updateCategory(ProductCategory category) async {
    try {
      final response = await _databases.updateDocument(
        databaseId: 'mahllnadb',
        collectionId: 'ProductCategories',
        documentId: category.id,
        data: category.toMap(),
      );

      return ProductCategory.fromMap(response.data);
    } catch (e) {
      debugPrint('Error updating category: $e');
      throw Exception('فشل في تحديث التصنيف');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _databases.deleteDocument(
        databaseId: 'mahllnadb',
        collectionId: 'ProductCategories',
        documentId: categoryId,
      );
    } catch (e) {
      debugPrint('Error deleting category: $e');
      throw Exception('فشل في حذف التصنيف');
    }
  }

  Future<bool> canDeleteCategory(String categoryId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: 'mahllnadb',
        collectionId: 'Products',
        queries: [Query.equal('categoryId', categoryId), Query.limit(1)],
      );

      return response.documents.isEmpty;
    } catch (e) {
      debugPrint('Error checking category usage: $e');
      return false;
    }
  }
}
