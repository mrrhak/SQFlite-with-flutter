class Category {
  int id;
  String name;
  String description;

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = this.id;
    mapping['name'] = this.name;
    mapping['description'] = this.description;

    return mapping;
  }
}
