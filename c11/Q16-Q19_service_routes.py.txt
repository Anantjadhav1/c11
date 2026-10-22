# Q16 — READ route
@app.route("/products/<int:product_id>", methods=["GET"])
def read_product(product_id):
    product = Product.find(product_id)
    if product is None:
        return {"error": "Product not found"}, 404
    return product.serialize(), 200


# Q17 — UPDATE route (this answer received full credit; keep as-is)
@app.route("/products/<int:product_id>", methods=["PUT"])
def update_product(product_id):
    if not request.is_json:
        return {"error": "Content-Type must be application/json"}, 415

    product = Product.find(product_id)
    if product is None:
        return {"error": "Product not found"}, 404

    data = request.get_json()
    for field in ["name", "description", "price", "available", "category"]:
        if field in data:
            setattr(product, field, data[field])

    product.update()
    return product.serialize(), 200


# Q18 — DELETE route
@app.route("/products/<int:product_id>", methods=["DELETE"])
def delete_product(product_id):
    product = Product.find(product_id)
    if product is not None:
        product.delete()
    return "", 204


# Q19 — LIST ALL / FILTER BY NAME, CATEGORY, AVAILABILITY
@app.route("/products", methods=["GET"])
def list_products():
    name = request.args.get("name")
    category = request.args.get("category")
    available = request.args.get("available")

    if name:
        products = Product.find_by_name(name)
    elif category:
        products = Product.find_by_category(category)
    elif available is not None:
        is_available = available.lower() == "true"
        products = Product.find_by_availability(is_available)
    else:
        products = Product.all()

    return [product.serialize() for product in products], 200
