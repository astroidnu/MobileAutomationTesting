
*** Settings ***
Library           Selenium2Library
Library           CustomSeleniumLibrary.py
Library           OperatingSystem 
Library           DateTime
Library           Collections
Library           SendFTPSelenium.py
*** Keywords ***
Set Environment Variable   webdriver.gecko.driver  geckodriver.exe
#Set Environment Variable    webdriver.chrome.driver chromedriver.exe

#Create Profile Chrome   ${path}
*** Variables ***
${Username}       ####
${Password}       ######
${Browser}        Firefox
${SiteUrl}        https://testadmin.cyberpay.co.id/airtime_gw/index/
${FromDate}       20/03/2017
${ToDate}         30/03/2017
${Delay}          4s
${PathDownload}     C://Users/Lalala/Downloads/
#${profile_path}     D:/robotframework/belajar/profilewebdriver/chrome/muzzakkiri
${profile_path_mozilla}     D:/robotframework/belajar/profilewebdriver/firefox/gshjcxp8.airpaytime
*** Keywords ***
Open page
    ${profile_path}     create_profile      ${profile_path_mozilla} 
    open browser    ${SiteUrl}      ${Browser}     ff_profile_dir=${profile_path_mozilla}  
    Maximize Browser Window

Select Menu Manage Airtime Gateway
    Click Element   xpath=//a[contains(text(),'Manage Airtime Gateway')]
  
Login Bank Account
    #Iframe Danamonline
    Select Frame     xpath=//frameset/frame
    #Input Username dan Password
    Input Text       id=txtAccessCode   ${Username}
    Input Password   id=txtPin          ${Password}
    #Klik button login
    Click Element    id=cmdLogin
 
Go To Menu
    Sleep   ${Delay}
    #Click Submenu
    Click Element   xpath=//a[contains(text(),'Rekening Simpanan')]
    Sleep   ${Delay}
    #Click Riwayat Transaksi Menu 
    Click Element   xpath=//a[contains(text(),'Riwayat Transaksi')]

Do Filter Transaction 
    Sleep   ${Delay}
    #Select Radio Button 
    Click Element  xpath=//input[@id='_ctl0_rbtnFromTo']
    #input from and to Date Filter
    Input Text   id=_ctl0_txtFromDate    ${FromDate}
    Input Text   id=_ctl0_txtToDate      ${ToDate}
    #Click Show History Account Number
    Click Element  id=_ctl0_btnGetDetails
    Sleep   ${Delay}
    #Download File
    Click Element   id=_ctl0_btnDownload

Assert Warning Message
    Element Text Should Be    id=session_key-login-error    ${ExpectedWarningMessage}    ${WarningMessage}

Handle Column
    ${countColumn}      Get Matching Xpath Count    xpath=//table[@id='datatable']/thead/tr/th
    : FOR     ${column}       IN RANGE      ${countColumn}
    \   Handle Row  ${column}

Check Position Cell
    [Arguments]     ${operator}     ${denom}    ${row}
    Run Keyword If  '${operator}' == 'AXIS' and '${denom}' == '100000'  Display Row Selected    ${row}

Display Row Selected
    [Arguments]     ${row}
    log     ${row}
    ${total_column_in_row}        Get Matching Xpath Count       xpath=//table[@id='datatable']   ${row}   3

    Exit For Loop
Handle Row 
    [Arguments]    ${column}
    ${countRow}      Get Matching Xpath Count    xpath=//table[@id='datatable']/tbody/tr
    : FOR     ${row}       IN RANGE      ${countRow}
    \       ${operator}       Get Table Cell      xpath=//table[@id='datatable']   ${row}   1
    \       ${denom}          Get Table Cell      xpath=//table[@id='datatable']   ${row}   2       
    \       Check Position Cell     ${operator}       ${denom}       ${row}        



*** Test Cases ***
Open Page Airtime Gateway 
    Open page
Select Menu Airtime Gateway    
    Select Menu Manage Airtime Gateway
    Sleep   5s
    Handle Column  
# Checkin All Process in Table


#     : FOR     ${column}       IN RANGE      ${countColumn}
#         : FOR     ${row}       IN RANGE      ${countRow}
     
    # log     ${countColumn}
    # log     ${countRow}
    # ${table_cell}       Get Table Cell      xpath=//table[@id='datatable']   1   3
    # log     ${table_cell}
    # ${listGateway}      Get Matching Xpath Count    xpath=//td[contains(text(),'AXIS')]
    # @{listFile}     List Files In Directory     ${PathDownload}     pattern=*.xls
    # : FOR   ${file}     IN      @{listFile}
    # \   send_file   ${file}
    # \   ${filePathRemove}   get_file_path   ${PathDownload}     ${file} 
    # \   Remove File     ${filePathRemove}       
    # \   log     ${file}
    # Move File   /download/c.txt    /download/d.txt
    # Sleep   5s
    # Remove File     C://download/d.txt
    #Login Bank Account 
    #Go To Menu
    #Do Filter Transaction 
    [Teardown]    Close Browser
# datatimetest
#     ${d}=    get time   result_format=%Y-%m-%d
#     log    {d}
# ftptestcase
  
 