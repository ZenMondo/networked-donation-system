integer debit = FALSE;

//teamNum in the kiosk/vendor is accquired in config
integer teamNum = 1;
string teamName;
integer teamTotal;
integer kioskTotal;
string kioskOwner;
integer lastDonation;
string lastDonor;

integer displayTeamName = FALSE;
integer displayTeamTotal = FALSE;
integer displayKioskTotal = TRUE;
integer displayLastDonation = FALSE;
integer displayLastDonor = FALSE;

string myURL;

integer timerCounter;
integer choiceFlag;

integer configAbortFlag = FALSE;

//Handle for the Listen we won't need this all the time.
integer handle;

integer userChan = -11811;

//These variables are for the reconfig switch
integer touchTimerStart;
integer touchTimerStop;


key relayforlife = "dad6a0e4-41bf-49be-893b-b32933fdc0bb";

integer IsNumeric(string str)
{
   string numerics = "0123456789"; 
   integer x;
   integer n = llStringLength(str);
   if (str == "") return (FALSE);
   for (x=0; x<n; ++x)
   {
      if (llSubStringIndex(numerics,llGetSubString(str,x,x)) == -1)
        return (FALSE);
   }
   return (TRUE);
}

kioskDisplay()
{
    //string display = "2010 Relay For Life of Second Life\n";
    
    string display = "";
    
    if(displayTeamName)
    {
        display += "Team: " + teamName + "\n";
    }
    
    if(displayTeamTotal)
    {
        display += "Team Total: L$" + (string) teamTotal + "\n";
    }
    
    if(displayKioskTotal)
    {
        display += "Kiosk Total: L$" + (string) kioskTotal + "\n";
    }
    
    if(displayLastDonation)
    {
        display += "Last Donation Amount: L$" + (string) lastDonation + "\n";
    }
    
    if(displayLastDonor)
    {
        display += "Last Donation By: " + lastDonor + "\n";
    }
    
    //display += "Click me for More Info on the American Cancer Society\nOr to Verify this Kiosk";
    
    llSetText(display, <1.0, 1.0, 1.0>, 1.0);
}

default
{
    state_entry()
    {
        llSetText("Permissionifying...", <1.0, 1.0, 1.0>, 1.0);
        llRequestPermissions(llGetOwner(),PERMISSION_DEBIT);
        llSetTimerEvent(90); 
    }   
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_DEBIT)
        {
            llSetTimerEvent(0);
            debit=TRUE;
            state startConfig;
        }
        else
        {
            debit=FALSE;
            llOwnerSay("This kiosk requires PERMISSION_DEBIT permission! Please rez another copy and give permission.");
            llDie();
        }
    }
    
    timer()
    {
        if (debit == FALSE)
        {
            llOwnerSay("This kiosk requires PERMISSION_DEBIT permission! Please rez another copy and give permission.");
            llDie();
        }
    } 
    
    changed(integer change)
    {                
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }
}

state startConfig
{
    state_entry()
    {
        llSetText("Setting Team Name...", <1.0, 1.0, 1.0>, 1.0);
        
        handle = llListen(0, "", llGetOwner(), "");
        llSay(0, "Type the NUMBER of your team in open chat.  You can find your TEAMNUMBER at http://main.acsevents.org/slteamnumbers");
        llSetTimerEvent(60);
    }

    timer()
    {
        timerCounter++;
        
        if(timerCounter == 1)
        {
           llSay(0, "Type the NUMBER of your team in open chat.  You can find your TEAMNUMBER at http://main.acsevents.org/slteamnumbers");    
        }
        
        else
        {
            llSay(0, "Time has elapsed. This Kiosk will use Default Settings.");
            llSay(0, "If you wish to reconfigure Click and HOLD this Kiosk for 3 Seconds.");
            timerCounter = 0;
            llSetTimerEvent(0);
            configAbortFlag = TRUE;
            
            state getTeam; //Go to the next step in the configuration process
            
        }
    }    

    listen(integer channel, string name, key id, string message)
    {
        
        if (!IsNumeric(message))
        {  
           llSay(0,"A number was expected.");
           llSleep(0.001);
           llSay(0, "Type the NUMBER of your team in open chat.  You can find your TEAMNUMBER at http://main.acsevents.org/slteamnumbers");
           return;  
        }
        
        teamNum = (integer) message;
        
        if (teamNum == 0)
        {  
           llSay(0,"The team number cannot be zero (0).");
           llSleep(0.001);
           llSay(0, "Type the NUMBER of your team in open chat.  You can find your TEAMNUMBER at http://main.acsevents.org/slteamnumbers");
           return;  
        }       
        
        llSetTimerEvent(0);
        llListenRemove(handle);
        //teamNum = (integer) message;
        state getTeam; 
        
    }
    
    changed(integer change)
    {                
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }
}

state getTeam
{
    state_entry()
    {
        llHTTPRequest("http://virtualrelay.org/teamname.php?team=" + (string) teamNum, [HTTP_METHOD,"GET"],"");   
    }
    
     http_response(key id,integer status , list data, string body)
    {
       integer start = llSubStringIndex(body, "<BODY>") +7;
       integer end = llSubStringIndex(body, "</body>") - 2;
       
       teamName = llGetSubString(body, start, end);
       
       //llSay(0, teamName);
       
       if(llSubStringIndex(teamName, "<br />") != -1) //Error
       {
            llSay(0, "That is an invalid Team Number");
            state startConfig;
        }
        
        else //Valid Team Number
        {
            llSay(0, "Team Name set to: " + teamName);
             //llSetText(teamName, <1,1,1>, 1.0);
             
            if(configAbortFlag)
            {
                state running; 
            }
            
            else
            {
                state setFlags;   
            }
            
        }   
        
           
    }
    
    changed(integer change)
    {                
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }  
}

state setFlags
{
    state_entry()
    {
        llSetText("Configuring Display...", <1.0, 1.0, 1.0>, 1.0);
        
        //Choose a random  negative channel to use to avoid crossttalk with other kiosks 
        userChan = -((integer)llFrand(2147483646.0) + 1);
        handle = llListen(userChan, "", llGetOwner(), "");
    
        choiceFlag = 1; //Display Team Name?    
        llDialog(llGetOwner(), "Display Team Name?", ["Yes", "No"], userChan);
        llSetTimerEvent(60);
         
    }
    
    listen(integer channel, string name, key id, string message)
    {
        llSetTimerEvent(0);
        
        if(choiceFlag == 1)  //Display Team Name?
        {
            if(message == "Yes")
            {
                displayTeamName = TRUE;
                llSay(0, "I will display your team name.");
            }
            
            else if(message == "No")
            {
                displayTeamName = FALSE;
                llSay(0, "I will not display your team name.");
            }
            
            choiceFlag = 2; //Display Team Total?
            llDialog(llGetOwner(), "Display Team Total?", ["Yes", "No"], userChan);
            llSetTimerEvent(60); 
            return;    
        }
        
        if(choiceFlag == 2)  //Display Team Total?
        {
           if(message == "Yes")
            {
                displayTeamTotal = TRUE;
                llSay(0, "I will display your team total.");
                
            }
            
            else if(message == "No")
            {
                displayTeamTotal = FALSE;
                llSay(0, "I will not display your team total.");
            }
            
            choiceFlag = 3; //Display Kiosk Total?
            llDialog(llGetOwner(), "Display Kiosk Total?", ["Yes", "No"], userChan);
            llSetTimerEvent(60);
            return;       
        } 
        
        if(choiceFlag == 3)  //Display Kiosk Total?
        {
           if(message == "Yes")
            {
                displayKioskTotal = TRUE;
                llSay(0, "I will display this kiosk's total.");
            }
            
            else if(message == "No")
            {
                displayKioskTotal = FALSE;
                llSay(0, "I will not display this kiosk's total.");
            }
               
            choiceFlag = 4; //Display Last Donation Anmount
            llDialog(llGetOwner(), "Display Last Donation Amount?", ["Yes", "No"], userChan);
            llSetTimerEvent(60);
            return;         
        }
        
        if(choiceFlag == 4) //Display Last Donation Amount
        {
            if(message == "Yes")
            {
                displayLastDonation = TRUE;
                llSay(0, "I will display the last donation amount.");
            }
            
            else if(message == "No")
            {   
                displayLastDonation = FALSE;
                llSay(0, "I will not display the last donation amount.");
            }
            
            choiceFlag = 5; //Display Last Donor
            llDialog(llGetOwner(), "Display Last Donor's Name?", ["Yes", "No"], userChan);
            llSetTimerEvent(60);
            return; 
        }
        
        if(choiceFlag == 5) //Display Last Donor
        {
            if(message == "Yes")
            {
                displayLastDonor = TRUE;
                llSay(0, "I will display the last donor's name.");
            }
            
            else if(message == "No")
            {   
                displayLastDonor = FALSE;
                llSay(0, "I will not display the last donor's name.");
            }
            
            choiceFlag = 0; //Clear for reconfig
            llListenRemove(handle); //Clean up listen
            
            state registerKiosk;   
        } 
    }
    
    timer()
    {
        llSetTimerEvent(0);
        
        if(choiceFlag == 1)  //Display Team Name?
        {
            if(displayTeamName)
            {
                llSay(0, "I will display your team name.");
            }
            
            else
            {
                llSay(0, "I will not display your team name.");
            }
            
            choiceFlag = 2; //Display Team Total?
            llDialog(llGetOwner(), "Display Team Total?", ["Yes", "No"], userChan);
            llSetTimerEvent(60);
            return; 
        }
        
        if(choiceFlag == 2) //Display Team Total
        {
            if(displayTeamTotal)
            {
                llSay(0, "I will display your team total.");
            }
            else
            {
                llSay(0, "I will not display your team total.");
            }
            
            choiceFlag = 3; //Display Kiosk Total?
            llDialog(llGetOwner(), "Display Kiosk Total?", ["Yes", "No"], userChan);
            llSetTimerEvent(60);
            return;   
        }
        
        if(choiceFlag == 3) //Display Kiosk Total?
        {
            if(displayKioskTotal)
            {
                llSay(0, "I will display this kiosk's total");
            }
            else
            {
                llSay(0, "I will not display this kiosk's total");
            }
            
            choiceFlag = 0; //Clear for reconfig
            llListenRemove(handle); //Clean up listen
            
            state registerKiosk;         
        }
    }
    
    changed(integer change)
    {                
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }   
}

state registerKiosk
{
    state_entry()
    {
       llSetText("Registering...", <1.0, 1.0, 1.0>, 1.0); 
       
       kioskOwner = llKey2Name(llGetOwner());
       
       llHTTPRequest("http://virtualrelay.org/registerthekiosk.php?uuid=" + (string)llGetKey() + "&region=" + llEscapeURL(llGetRegionName()) + "&position=" + (string)llGetPos() + "&team=" + (string)teamNum + "&owner=" + llEscapeURL(kioskOwner) + "&kioskname=" + llEscapeURL(llGetObjectName()) + "&pixie=bug_fairy", [HTTP_METHOD,"GET"],"");
    
       if(myURL!= "")
       {
           llReleaseURL(myURL);
        }
         
        llRequestURL();
        
    }
    
    http_request(key id, string method, string body) 
     {
        if (method == URL_REQUEST_GRANTED) 
        {
            myURL= body;
            
            llHTTPRequest("http://virtualrelay.org/setURL.php?uuid=" + (string) llGetKey() + "&url=" + myURL, [HTTP_METHOD,"GET"],"");
 
            
            state running;
        } 
        
        else if (method == URL_REQUEST_DENIED) 
        {
            llSay(0, "This Parcel has no available URLs and this kiosk needs one to function properly. Please rez a kiosk on another parcel or free up this parcel's available URLs.");
            llSleep(3.0);
            llDie();
            
        } 
        
    }
    
    changed(integer change)
    {                
        
        if(change & CHANGED_REGION_START)
        {
            llRequestURL();
        }
        
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
            
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }   
}


state running
{
    state_entry()
    {
         kioskDisplay();
         llSay(0, "If you wish to reconfigure, Click and HOLD this Kiosk for 3 Seconds.");

        llHTTPRequest("http://virtualrelay.org/teamtotal.php?team=" + (string) teamNum + "&url=" + myURL, [HTTP_METHOD,"GET"],"");

        handle = llListen(userChan, "", NULL_KEY, "");
        llListenControl(handle, FALSE);
    }
    
    money(key id, integer amount)
    {
        llGiveMoney(relayforlife, amount);
        kioskTotal += amount;
        lastDonation = amount;
        lastDonor = llKey2Name(id);
        
        llHTTPRequest("http://virtualrelay.org/realdonation.php?amount=" + (string) amount + "&team=" + (string)teamNum + "&sponsor=" + llEscapeURL(llKey2Name(id)) + "&owner=" + llEscapeURL(kioskOwner) + "&region=" + llEscapeURL(llGetRegionName()) + "&position=" + (string)llGetPos() + "&uuid=" + (string)llGetKey() + "&kioskname=" + llEscapeURL(llGetObjectName()) + "&pixie=bug_fairy", [HTTP_METHOD,"GET"],""); 

                
        //Backchannel Communication
        vector pos = llGetPos();
        string loc=(string)llRound(pos.x) + "," + (string)llRound(pos.y) + "," + (string)llRound(pos.z);

        // next line produces  x,y,z coordinates|av name|av key|amount donated
        llRegionSay(-11811,loc+"|"+llKey2Name(id)+"|"+(string)id+"|"+(string)amount);

        llInstantMessage(id, "Thank you for your donation!");         
    }
    
    http_request(key id, string method, string body) 
     {
        if (method == URL_REQUEST_GRANTED) 
        {
            myURL= body;
            
            llHTTPRequest("http://virtualrelay.org/setURLphp?uuid=" + (string) llGetKey() + "&url=" + myURL, [HTTP_METHOD,"GET"],"");
 
            
        } 
        
        else if (method == URL_REQUEST_DENIED) 
        {
            llInstantMessage(llGetOwner(), "This Parcel has no available URLs and this kiosk needs one to function properly. Please rez a kiosk on another parcel or free up this parcel's available URLs.");
            llSleep(3.0);
            llDie();
            
        } 
        
        else if (method == "GET") 
        {                    
            
            
            string query_string = llGetHTTPHeader(id, "x-query-string");
            
            //llSay(0, "Query=" + query_string);
            
            list queries = llParseString2List(query_string, ["&"], []);
        
            //Break the list from the web into each element
            //This depends on the url talking to the kiosk to be 
            //formed correctly
            
            list querytype = llParseString2List(llList2String(queries, 0), ["="], []);
            list queryvalue = llParseString2List(llList2String(queries, 1), ["="], []);
            
            string type = llList2String(querytype, 1);
            string value = llList2String(queryvalue, 1);
            
            //llSay(0, "Type=" + type + " Value=" + value);
            
            //Now Evaluate type and take action
            
            if(type == "update") //Team Total Update
            {
                teamTotal = (integer) value;
                kioskDisplay();
                llHTTPResponse(id, 200, "Hello World");
            }
            
            else if(type == "verify") //Kiosk Verification
            {
                
                llSay(0, "Your personal verification phrase is: " + llUnescapeURL(value));
                llHTTPResponse(id, 200, "Your Verified Kiosk has said your personal verification phrase in world.");
                
            }
            
            else if(type == "die") //End of Season Message
            {
                llHTTPResponse(id, 200, "Good Bye, Cruel World!");
                llDie();   
            }
            
        }
        
    }
    
     touch_start(integer total_number)
    {
        touchTimerStart = llGetUnixTime();
    }
    
    touch_end(integer num_detected)
    {
        touchTimerStop = llGetUnixTime();   
        integer touchTime = touchTimerStop - touchTimerStart;
        
        if(touchTime >= 3 && llDetectedKey(0) == llGetOwner())
        {
            llSay(0, "Admin Mode");
            state startConfig; //Reconfigure
        }
        
        else
        {
            //llSay(0, "Click Mode");
            //User Click Menu goes here.
                        
            llListenControl(handle, TRUE);
            llDialog(llDetectedKey(0), "Please choose one of the following options:", ["INFO" , "VERIFY"], userChan);
            llSetTimerEvent(60);
        }
            
        
    }
    
    listen(integer channel, string name, key id, string message)
    {
            if(message == "INFO")
            {
              llGiveInventory(id, llGetInventoryName(INVENTORY_NOTECARD, 0));
            }
            
            else if(message == "VERIFY")
            {
              llSay(0, " I am kisok ID:" + (string)llGetKey() +  ".\n I am owned by " + kioskOwner + ".\n I am in the Region of " + llGetRegionName() + "\n at the position of:  " + (string)llGetPos() + "\n Collecting donations for " + teamName + ".\n  You can verify this information at http://virtualrelay.org/verifykiosk.php?uuid="+ (string) llGetKey() + " where you can enter a verification phrase that I will echo back to you.");            

        }
             
    }
    
    
    timer()
    {
        llSetTimerEvent(0);
        llListenControl(handle, FALSE);
        //llWhisper(0, "I'm sorry time for a choice has expired.");
    }
    
    changed(integer change)
    {
        if(change & CHANGED_REGION_START)
        {
            llRequestURL();
        }
        
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    on_rez(integer start_param)
    {
        llResetScript();
    }  
}