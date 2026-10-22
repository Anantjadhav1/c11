# Q2 — READ model test
def test_read_a_product(self):
    product = ProductFactory()
    product.create()

    found = Product.find(product.id)

    self.assertIsNotNone(found)
    self.assertEqual(found.id, product.id)
    self.assertEqual(found.name, product.name)
    self.assertEqual(found.description, product.description)
    self.assertEqual(float(found.price), float(product.price))


# Q3 — UPDATE model test
def test_update_a_product(self):
    Product.remove_all()
    product = ProductFactory()
    product.id = None
    product.create()
    original_id = product.id

    self.assertEqual(len(Product.all()), 1)

    product.description = "testing"
    product.update()

    updated = Product.find(original_id)
    found = Product.all()

    self.assertIsNotNone(updated)
    self.assertEqual(updated.id, original_id)
    self.assertEqual(updated.description, "testing")
    self.assertEqual(len(found), 1)
    self.assertEqual(found[0].id, original_id)
    self.assertEqual(found[0].description, "testing")


# Q4 — DELETE model test
def test_delete_a_product(self):
    Product.remove_all()
    product = ProductFactory()
    product.create()

    self.assertEqual(len(Product.all()), 1)
    product.delete()
    self.assertEqual(len(Product.all()), 0)
    self.assertIsNone(Product.find(product.id))


# Q5 — LIST ALL model test
def test_list_all_products(self):
    Product.remove_all()
    self.assertEqual(len(Product.all()), 0)

    products = ProductFactory.create_batch(5)
    for product in products:
        product.create()

    found = Product.all()
    self.assertEqual(len(found), 5)


# Q6 — FIND BY NAME model test
def test_find_by_name(self):
    Product.remove_all()
    products = ProductFactory.create_batch(5)
    products[0].name = "Hat"

    for product in products:
        product.create()

    expected_count = sum(1 for product in products if product.name == "Hat")
    found = Product.find_by_name("Hat")

    self.assertEqual(len(found), expected_count)
    self.assertTrue(all(product.name == "Hat" for product in found))


# Q7 — FIND BY CATEGORY model test
def test_find_by_category(self):
    Product.remove_all()
    products = ProductFactory.create_batch(10)
    products[0].category = Category.CLOTHS

    for product in products:
        product.create()

    expected_count = sum(
        1 for product in products if product.category == Category.CLOTHS
    )
    found = Product.find_by_category(Category.CLOTHS)

    self.assertEqual(len(found), expected_count)
    self.assertTrue(all(product.category == Category.CLOTHS for product in found))


# Q8 — FIND BY AVAILABILITY model test
def test_find_by_availability(self):
    Product.remove_all()
    products = ProductFactory.create_batch(10)
    products[0].available = True
    products[1].available = False

    for product in products:
        product.create()

    expected_count = sum(1 for product in products if product.available is True)
    found = Product.find_by_availability(True)

    self.assertEqual(len(found), expected_count)
    self.assertTrue(all(product.available is True for product in found))
