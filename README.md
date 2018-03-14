# networked-donation-system
A Networked Donation System for Virtual Worlds such as Second Life

This is a snapshot of a Networked Donation System that I wrote in 2009-2010 for use in Second Life. It relies on an in-world object, which uses the LSL script which then communicates with a server back-end which uses the suite of php scripts and a MySQL database.  In order to use this system you will need to modify the scripts to point to your server, backend, and database.  Most of the backend scripts should be located in a directory protected with an .htaccess file.  There are a few php scripts however that are web-facing.

There are things in this system I would not do today.  You should rename header.inc and footer.inc to header.php and footer.php for security reasons and change the require line at the top and bottom of each php file to reflect that. 

This is not in active development the reasons for which I will explain below. But if you would like to use this system and need help setting it up, feel free to contact me at zenmondo@gmail.com and we can get it up to modern standards.  This is mostly to reflect my work in 2009-2010 and release it open source.




Set the Wayback Machine for 2009, Sherman.

The American Cancer Society has a fundraiser called Relay For Life. Seeing an avenue for more money, they decided to hold a virtual Relay For Life in the virtual world of Second Life.  It is very popular, raising a lot of money. But the donation system is buggy. It is unreliable. It crashes often which means that the American Cancer Society cannot collect and track donations during the down time.

I was brought in as tech chair for the 2009 Relay season and it was a mess.  I had very short time to get to speed, and the system that was in place was what we had to go by.  The backend was hosted on a server I did not control so when it crashed I had to wait to get the owner of the server to reboot it.  There was a lot of downtime.

I stayed on as Tech Chair for the 2010 seasons and having several months lead time I decided to do a complete rewrite of the donation system, starting from scratch writing both the in-world element in LSL and the backend in php and using a MySQL database. I added new functionality, invented a networked communication system that kept track of team totals in real time, and an interactive element to verify that a kiosk was not counterfeit by typing a phrase in a webpage and have it echoed by the kiosk in the virtual world in Second Life.

Except for a hitch where the source code was accidently distributed in such a way that it might be read (and could be used to inject fake data into the system) with the one maintenance patch to add security in case someone found the script, the 2010 Relay Season went off without any downtime or crashes, raising hundreds of thousands of dollars and tracking all the donations in real time.

While American Cancer Society raised over a quarter million dollars using my software, I at the time was very poor. I was not food-secure. There were times when I could not afford food.  During the relay, "Stingray9798 Raymaker" (Jeff Montegut) a paid ACS employee and the head of the fundraising efforts in second life asked me to do a small technical job.  I had not eaten in about 3 days and was too fatigued to work. I asked for him to paypal me $5 so I could buy a cheeseburger and then be able to do what he asked. His response was "nevermind".

At the end of the relay season, I received the following e-mail:

Hello Zen, 

We just wanted to touch base with you and let you know about our plans for the 2011 Relay as far as Technology goes.  We understand that you had some difficult times during the last Relay season, often times not having enough money for food.  We want to give you the opportunity to focus on your RL, so we have recruited a few new scripters for the Technology Committee.  Thank you for your efforts and time on behalf of Relay For Life.  We wish you well and hope that things in your RL improve for you.

Sincerely,

MamaP Beerbaum, 2001 RFL Even Chair

Stingray9798 Raymaker, ACS Staff Partner

At which point they took my code, the code shared in this repository, took my name off it, and uses a derivative of it to this day. I was not given so much as a Relay For Life keychain, though I was promised a t-shirt which never came. Since I was not given any consideration for my work, this code does not fall under as work for hire for American Cancer Society.

So I am deciding to Open Source the code I wrote, 8 years down the line.  The current donation system I believe is derived from this code, but I am sure many improvements and modifications have been added.  I now give this snapshot of the project from 2010 so that other organizations that want a donation system can start from the same place American Cancer Society has.


