# Q28 — Button click
from behave import when
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


@when('I press the "{button_text}" button')
def step_impl(context, button_text):
    wait = WebDriverWait(context.driver, 10)
    button = wait.until(
        EC.element_to_be_clickable(
            (By.XPATH, f"//button[normalize-space()='{button_text}']")
        )
    )
    button.click()


# Q29 — Verify text IS present in search results
from behave import then


@then('I should see "{expected_text}" in the results')
def step_impl(context, expected_text):
    wait = WebDriverWait(context.driver, 10)
    results = wait.until(
        EC.visibility_of_element_located((By.ID, "search_results"))
    )
    wait.until(lambda driver: expected_text in results.text)
    assert expected_text in results.text, (
        f"Expected '{expected_text}' in the search results"
    )


# Q30 — Verify text is NOT present in search results
@then('I should not see "{unexpected_text}" in the results')
def step_impl(context, unexpected_text):
    wait = WebDriverWait(context.driver, 10)
    results = wait.until(
        EC.visibility_of_element_located((By.ID, "search_results"))
    )
    wait.until(lambda driver: unexpected_text not in results.text)
    results_text = context.driver.find_element(
        By.ID, "search_results"
    ).text
    assert unexpected_text not in results_text, (
        f"Unexpected text '{unexpected_text}' found in search results"
    )


# Q31 — Verify flash message is present
@then('I should see the message "{expected_message}"')
def step_impl(context, expected_message):
    wait = WebDriverWait(context.driver, 10)
    message = wait.until(
        EC.visibility_of_element_located(
            (By.CSS_SELECTOR, ".alert-success, .flash-success, #flash-message")
        )
    )
    assert expected_message in message.text, (
        f"Expected message '{expected_message}', "
        f"but received '{message.text}'"
    )
