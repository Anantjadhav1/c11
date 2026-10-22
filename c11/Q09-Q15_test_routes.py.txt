# Q9 — READ route test
def test_read_a_product(self):
    product = ProductFactory()
    product.create()

    response = self.client.get(f"/products/{product.id}")

    self.assertEqual(response.status_code, 200)
    data = response.get_json()
    self.assertEqual(data["id"], product.id)
    self.assertEqual(data["name"], product.name)
    self.assertEqual(data["description"], product.description)
    self.assertEqual(float(data["price"]), float(product.price))


# Q10 — UPDATE route test
def test_update_a_product(self):
    Product.remove_all()
    product = ProductFactory()
    payload = {
        "name": product.name,
        "description": product.description,
        "price": float(product.price),
        "available": product.available,
        "category": product.category.name if hasattr(product.category, "name") else product.category,
    }

    response = self.client.post("/products", json=payload)
    self.assertEqual(response.status_code, 201)
    created = response.get_json()
    product_id = created["id"]

    update_response = self.client.put(
        f"/products/{product_id}",
        json={"description": "unknown"},
    )
    self.assertEqual(update_response.status_code, 200)
    updated = update_response.get_json()
    self.assertEqual(updated["description"], "unknown")


# Q11 — DELETE route test
def test_delete_a_product(self):
    Product.remove_all()
    product = ProductFactory()
    product.create()

    before_count = len(Product.all())
    self.assertEqual(before_count, 1)

    response = self.client.delete(f"/products/{product.id}")
    self.assertEqual(response.status_code, 204)
    self.assertEqual(response.get_data(as_text=True), "")

    check = self.client.get(f"/products/{product.id}")
    self.assertEqual(check.status_code, 404)

    after_count = len(Product.all())
    self.assertEqual(after_count, before_count - 1)
    self.assertEqual(after_count, 0)


# Q12 — LIST ALL route test
def test_list_all_products(self):
    Product.remove_all()
    self.assertEqual(len(Product.all()), 0)

    products = ProductFactory.create_batch(5)
    for product in products:
        product.create()

    response = self.client.get("/products")
    self.assertEqual(response.status_code, 200)
    data = response.get_json()
    self.assertIsInstance(data, list)
    self.assertEqual(len(data), 5)


# Q13 — LIST BY NAME route test
def test_list_products_by_name(self):
    Product.remove_all()
    product = ProductFactory(name="Hat")
    other = ProductFactory(name="Shoes")
    product.create()
    other.create()

    response = self.client.get("/products?name=Hat")
    self.assertEqual(response.status_code, 200)
    data = response.get_json()

    expected_count = sum(
        1 for item in Product.all() if item.name == "Hat"
    )
    self.assertEqual(len(data), expected_count)
    self.assertTrue(all(item["name"] == "Hat" for item in data))
    self.assertTrue(any(item["name"] == "Hat" for item in data))
    self.assertFalse(any(item["name"] == "Shoes" for item in data))


# Q14 — LIST BY CATEGORY route test
def test_list_products_by_category(self):
    Product.remove_all()
    product = ProductFactory(name="Big Mac", category=Category.FOOD)
    other = ProductFactory(name="Hat", category=Category.CLOTHS)
    product.create()
    other.create()

    response = self.client.get("/products?category=Food")
    self.assertEqual(response.status_code, 200)
    data = response.get_json()
    self.assertTrue(any(item["name"] == "Big Mac" for item in data))
    self.assertFalse(any(item["name"] == "Hat" for item in data))


# Q15 — LIST BY AVAILABILITY route test
def test_list_products_by_availability(self):
    Product.remove_all()
    available_product = ProductFactory(name="Hat", available=True)
    unavailable_product = ProductFactory(name="Shoes", available=False)
    available_product.create()
    unavailable_product.create()

    response = self.client.get("/products?available=true")
    self.assertEqual(response.status_code, 200)
    data = response.get_json()
    self.assertTrue(any(item["name"] == "Hat" for item in data))
    self.assertFalse(any(item["name"] == "Shoes" for item in data))
    self.assertTrue(all(item["available"] is True for item in data))
