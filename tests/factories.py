# Q1 — tests/factories.py
import factory
from factory.fuzzy import FuzzyChoice, FuzzyDecimal

from service.models import Product, Category


class ProductFactory(factory.Factory):
    """Factory for creating fake Product objects."""

    class Meta:
        model = Product

    id = factory.Sequence(lambda n: n + 1)
    name = FuzzyChoice([
        "Hat", "Shoes", "Pants", "Shirt", "Big Mac",
        "Apple", "Banana", "Sheets", "Dog", "Truck",
    ])
    description = factory.Faker("sentence")
    price = FuzzyDecimal(0.5, 2000.0, 2)
    available = FuzzyChoice([True, False])
    category = FuzzyChoice([
        Category.CLOTHS,
        Category.FOOD,
        Category.HOUSEHOLD,
        Category.AUTOMOTIVE,
        Category.TOOLS,
        Category.OUTDOOR,
    ])
