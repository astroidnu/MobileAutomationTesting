*** Settings ***
Library           AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub
${PLATFORM_NAME}    Android
${PLATFORM_VERSION}    7.0
${DEVICE_NAME}    192.168.56.101:5555
${APP}             ${CURDIR}/apk/moviesapp.apk
${DELAY_TIME}   2s
${PACKAGE_NAME}     com.example.android.popularmoviesstage1

*** Keywords ***
Filter Function
     [Arguments]    ${POSITION} 
     Open Application  ${REMOTE_URL}  platformName=${PLATFORM_NAME}  platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}  app=${APP}  automationName=appium  appPackage=${PACKAGE_NAME}
     Click Element  xpath=//android.widget.FrameLayout/android.view.ViewGroup/android.support.v7.widget.LinearLayoutCompat/android.widget.ImageView[contains(@clickable,true)]
     Sleep  5s
     Click Element  xpath=//android.widget.FrameLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.LinearLayout[contains(@index,${POSITION})]
     Sleep  5s  
     [TearDown]     Close Application

*** Test Cases ***
sort_movie_test
    Filter Function     1


