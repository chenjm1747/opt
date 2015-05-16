This is a Delphi implementation of the Windows Telephony headers.
There's a test program that can monitor calls made with other TAPI
enabled programs like Remote Access and can also dial calls.
Also there's a mini-terminal that shows how to use TAPI to place calls and
obtain the COM handle.

This is version 2.0

******************
NOTE FOR 1.x USERS
******************
Some functions have changed to accept pointers instead of var parameters.
This was done for those functions that can accept null pointers for parameters.
These functions are:
* lineForward
* lineGenerateTone
* lineGetAppPriority
* lineMakeCall
* lineMonitorTones
* lineOpen
* linePark
* linePrepareAddToConference
* lineSetAppPriority
* lineSetCallParams
* lineSetupConference
* lineSetupTransfer


This code is freeware and you can do with it anything you want.
Just email me if you are using it, so I will know how many guys use my code.

Davide Moretti
<dave@rimini.com>

