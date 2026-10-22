# Q21-Q27 — Add these scenarios under one existing Feature: heading in
# features/products.feature. Do not repeat the Feature heading per scenario.

Scenario: Read a product
  When I visit the "Home Page"
  And I set the "Name" field to "Hat"
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Hat" in the results
  And I should see "A red fedora" in the results
  And I should see "True" in the results
  And I should see "Cloths" in the results
  And I should see "59.95" in the results
  When I copy the ID of the product named "Hat"
  And I press the "Clear" button
  And I paste the copied ID into the "Id" field
  And I press the "Retrieve" button
  Then I should see the message "Success"
  And the "Name" field should contain "Hat"
  And the "Description" field should contain "A red fedora"
  And the "Available" dropdown should be set to "True"
  And the "Category" dropdown should be set to "Cloths"
  And the "Price" field should contain "59.95"


Scenario: Update a product
  When I visit the "Home Page"
  And I set the "Name" field to "Hat"
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Hat" in the results
  When I copy the ID of the product named "Hat"
  And I press the "Clear" button
  And I paste the copied ID into the "Id" field
  And I press the "Retrieve" button
  Then I should see the message "Success"
  And the "Name" field should contain "Hat"
  When I set the "Name" field to "Fedora"
  And I press the "Update" button
  Then I should see the message "Success"
  And the "Name" field should contain "Fedora"
  When I press the "Clear" button
  And I set the "Name" field to "Fedora"
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Fedora" in the results
  And I should not see "Hat" in the results


Scenario: Delete a product
  When I visit the "Home Page"
  And I set the "Name" field to "Hat"
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Hat" in the results
  And I should see "A red fedora" in the results
  When I copy the ID of the product named "Hat"
  And I press the "Clear" button
  And I paste the copied ID into the "Id" field
  And I press the "Delete" button
  Then I should see the message "Product has been Deleted!"
  When I press the "Clear" button
  And I press the "Search" button
  Then I should see the message "Success"
  And I should not see "Hat" in the results


Scenario: List all products
  When I visit the "Home Page"
  And I press the "Clear" button
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Hat" in the results
  And I should see "Shoes" in the results
  And I should see "Big Mac" in the results
  And I should see "Sheets" in the results


Scenario: Search products by category
  When I visit the "Home Page"
  And I press the "Clear" button
  And I select "Food" in the "Category" dropdown
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Big Mac" in the results
  And I should not see "Hat" in the results
  And I should not see "Shoes" in the results
  And I should not see "Sheets" in the results


Scenario: Search products by availability
  When I visit the "Home Page"
  And I press the "Clear" button
  And I select "True" in the "Available" dropdown
  And I press the "Search" button
  Then I should see the message "Success"
  And I should see "Hat" in the results
  And I should see "Big Mac" in the results
  And I should see "Sheets" in the results
  And I should not see "Shoes" in the results


Scenario: Search by name
  When I visit the "Home Page"
  And I set the "Name" field to "Hat"
  And I press the "Search" button
  Then I should see the message "Success"
  And the "Name" field should contain "Hat"
  And the "Description" field should contain "A red fedora"
  And I should not see "Shoes" in the results
  And I should not see "Big Mac" in the results
  And I should not see "Sheets" in the results
