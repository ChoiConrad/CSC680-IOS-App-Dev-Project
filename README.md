# CSC680-IOS-App-Dev-Project
Final Project for CSC 680 Application Development for Mobile Devices by Conrad Choi 

### Idea: Good Finance Bad Calculator 
 This calculator will do everything a loan calculator will do but on the cellphone. This idea stemmed from when I was buying a Car and was trying to find out my monthly payment. 

### Features for Loan Calculator: 
The features of this application is to calculate monthly payments, time remaining on payments, Total money spent with the interest and compare it to buying it outright. However if a user wishes to have, for example certain monthly payment the app will offer how to achieve the certain monthly payments. 
This application will be implementing gyroscope to input the user information. For example if someone wants to input their finance percentage for a car they are buying they need to tilt the screen so the arrow will slide to the correct percentage. 

### Why?
The process for buying a vehicle is difficult, this app will achieve making the buying process and any financial advice given even more difficult to obtain. 


### API for UI 
The api that I will be using for the UI is called Core Motion https://developer.apple.com/documentation/coremotion this is to utilize the gyroscope or orientation of the iphone to set the number. 


### How will this work: 
Everything will be written in Swift.

### Must Haves: 
- User shall be able to input information by tilting their phone ONLY.
- If user is trying to tilt the phone for one input, the other inputs will change as well. 
- user will be able to submit information and the number present on the screen.


### Nice to Have: 
- a bar and an arrow visually indicating how close the user is to maximum input
- Results boxes can be expanded pushing other boxes out of the way to go into detail about the payment plan.
- a button to integrate finance plan  with the  Calendar Application to remind user to pay the monthly payments.
- a toggle where the user can turn off the gyroscope
- Application will calculate the submited input and display different finance plan from most efficient to least. 


### Problems faced developing the application: 
One problem that I faced was that I cannot test the application on a physical object. For me to test the application onto my phone, it required me to spend an additional 100 dollars for apple's certification. So to replace I had to make a unit test. 
