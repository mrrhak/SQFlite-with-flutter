import 'package:flutter/material.dart';
import 'package:todo_list/helpers/drawer_navigation.dart';
import 'package:todo_list/models/category.dart';
import 'package:todo_list/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _categoryNameController = TextEditingController();
  TextEditingController _categoryDescriptionController =
      TextEditingController();

  var category;

  TextEditingController _editCategoryNameController = TextEditingController();
  TextEditingController _editCategoryDescriptionController =
      TextEditingController();

  Category _category = Category();
  CategoryService _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>();

  GlobalKey<ScaffoldState> _globalKeyScaffold = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, int categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text = category[0]['name'];
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async {
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;

                var result = await _categoryService.saveCategory(_category);
                print(result);
                if (result > 0) {
                  Navigator.pop(context);
                  getAllCategories();
                }
              },
              color: Colors.blue,
              child: Text("Save"),
            ),
          ],
          title: Text("Categories Form"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: "Write a category",
                    labelText: "Category",
                  ),
                ),
                TextField(
                  controller: _categoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: "Write a description",
                    labelText: "Description",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.red,
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async {
                _category.id = category[0]['id'];
                _category.name = _editCategoryNameController.text;
                _category.description = _editCategoryDescriptionController.text;

                var result = await _categoryService.updateCategory(_category);
                print(result);
                if (result > 0) {
                  Navigator.pop(context);
                  // Make it update real time
                  getAllCategories();
                  _showSuccessedSnackBar("updated");
                }
              },
              color: Colors.blue,
              child: Text("Update"),
            ),
          ],
          title: Text("Edit Categories Form"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: "Write a category",
                    labelText: "Category",
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: "Write a description",
                    labelText: "Description",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteFormDialog(BuildContext context, int _categoryId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.green,
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () async {
                var result = await _categoryService.deleteCategory(_categoryId);
                print(result);
                if (result > 0) {
                  Navigator.pop(context);
                  // Make it update real time
                  getAllCategories();
                  _showSuccessedSnackBar("Deleted");
                }
              },
              color: Colors.red,
              child: Text("Delete"),
            ),
          ],
          title: Text("Are you sure you want to delete this category?"),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  _showSuccessedSnackBar(message) {
    var _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKeyScaffold,
      appBar: AppBar(
        title: Text("Categories"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: IconButton(
                onPressed: () =>
                    _editCategory(context, _categoryList[index].id),
                icon: Icon(Icons.edit),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_categoryList[index].name),
                  IconButton(
                    onPressed: () =>
                        _deleteFormDialog(context, _categoryList[index].id),
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
              subtitle: Text(_categoryList[index].description),
              dense: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
