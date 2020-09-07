import 'package:todo_list/models/category.dart';
import 'package:todo_list/repositiries/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    this._repository = Repository();
  }

  // Create data
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  deleteCategory(int categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }

  readCategories() async {
    return await _repository.readData('categories');
  }

  readCategoryById(int categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }
}
