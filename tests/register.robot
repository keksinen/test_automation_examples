
*** Settings ***
Library    Browser
Suite Setup    New Browser    chromium    headless=True
Test Setup    New Page     ${URL}
Test Teardown    Close Page    CURRENT

*** Variables ***
${URL}    https://qa-practice.netlify.app/register
${VALID_FIRST_NAME}    Tommy
${VALID_LAST_NAME}    Middleton
${VALID_PHONE_NUMBER}    +358441234567
${VALID_EMAIL_ADDRESS}    keksispeksi@gmail.com
${INVALID_EMAIL_ADDRESS}    keksispeksi
${VALID_PASSWORD}    My5up3r53cr3tPa55w0rd

*** Test Cases ***
Valid Registration with all fields
    When User provides valid data to all fields
    Then Account should be successfully created

Valid Registration with email and password only
    When User provides email and password data
    Then Account should be successfully created

Invalid email address
    When User provides invalid email adress
    Then Account creation should fail

Empty password
    When User provides does not enter password
    Then Account creation should fail


*** Keywords ***
User provides valid data to all fields
    [Documentation]    Enter valid data to all fields on the registration form
    Fill Text    id=firstName    ${VALID_FIRST_NAME}
    Fill Text    id=lastName    ${VALID_LAST_NAME}
    Fill Text    id=phone    ${VALID_PHONE_NUMBER}
    Select Options By    select[id=countries_dropdown_menu]    value    Finland
    Fill Text    id=emailAddress    ${VALID_EMAIL_ADDRESS}
    Fill Text    id=password    ${VALID_PASSWORD}
    Click    id=exampleCheck1    #I agree with the terms and conditions
    Click    id=registerBtn

Account should be successfully created
     Get Text    id=message    equals    The account has been successfully created!

User provides email and password data
    Fill Text    id=emailAddress    ${VALID_EMAIL_ADDRESS}
    Fill Text    id=password    ${VALID_PASSWORD}
    Click    id=exampleCheck1    #I agree with the terms and conditions
    Click    id=registerBtn

User provides does not enter password
    Fill Text    id=emailAddress    ${VALID_EMAIL_ADDRESS}
    Click    id=exampleCheck1    #I agree with the terms and conditions
    Click    id=registerBtn

Account creation should fail
    Get Text    id=message    !=   The account has been successfully created!

User provides invalid email adress
    Fill Text    id=emailAddress    ${INVALID_EMAIL_ADDRESS}
    Fill Text    id=password    ${VALID_PASSWORD}
    Click    id=exampleCheck1    #I agree with the terms and conditions
    Click    id=registerBtn
    
    