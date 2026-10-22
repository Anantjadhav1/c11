# Q20 — features/steps/load_steps.py
from behave import given
import requests


@given("the following products")
def step_impl(context):
    for row in context.table:
        payload = {
            "name": row["name"],
            "description": row["description"],
            "price": float(row["price"]),
            "available": row["available"].lower() == "true",
            "category": row["category"],
        }

        response = requests.post(
            f"{context.base_url}/products",
            json=payload,
        )
        assert response.status_code == 201, (
            f"Could not create product: {response.text}"
        )
