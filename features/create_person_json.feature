Feature: Create person via JSON
  In order to create a person with addresses
  A mobile client
  wants access a JSON API
  
  Scenario: Create Person
    Given I make a POST request to /people.json with post body
    """
      { "person" : {"first_name" : "Joe", "last_name" : "Smith",
                    "addresses_attributes" : [{"street" : "123 Main", "city" : "SF", "state" : "CA", "zip" : "91234"}]
                   }
      }
    """
    Then I should get a 201 response code
    And there should be a Person record with first_name=="Joe"
    And there should be an Address record with street=="123 Main"
