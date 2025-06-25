# TCHA iOS
This is official private repo of TCHA iOS

![Logo](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/drawable-xxxhdpi/logo_tcha_horizontal.png?raw=true)

# TCHA Android (Technical documentation) (In progress, not finished)
A brief technical description of TCHA features and code. This document must be updated with each major code update.

## Tech Stack

**Langage and framework:** Kotlin as language with Compose(better) or AppCompat

**Server:** Firebase for authentification, Storage datas, storage medias, app distribution, etc.

## Main Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Primary Color | ![#19AE5F](https://via.placeholder.com/10/19ae5f?text=+) #19AE5F |
| Secondary Color | ![#FFCC00](https://via.placeholder.com/10/ffcc00?text=+) #FFCC00 |
| Thirth Color | ![#FFFFFF](https://via.placeholder.com/10/ffffff?text=+) #FFFFFF |

## Main Features

- [Authentification](https://github.com/Mekongoabanda/TCHA#authentification) : User shall be able to Sign up, sign in, use Conditions, reset password, email verification, add document informations, log out
- **User profile**: User shall be able to see her profile image and name, and differents options (settings, payment infos, informations, log out)
- **Share route**: User shall be able to share route after entering all the requested information
- **Retrieve route by admin**: Any user who publishes an itinerary must be able to find them in the “publish” tab
- **Manage itinerary by admin**: any user who has received one or more reservations on their itinerary must be able to manage them (accept or cancel a reservation, modify a reservation and track the status of the reservation)
- **Search routes** : User can be able to search route shared by other user in app, in search tab
- **Filter routes**: User can filter the route according to certain criteria
- **Book a route**: User can be able to book a route
- **Manage booked route**: User can retrieve and manage her booked route(s) in "vos trajets" tab
- **Add payment method and pay**: CB, OM, MOMO.
- **Chat**: After an accepted reservation, the owner of the route and the person who booked it must be able to communicate in the chat

## Authentification:
Authentication is managed by an [AuthManager.kt](https://github.com/Mekongoabanda/TCHA#authentification). All reusable methods related to authentication must be there
### Sign In:
Sign In workflow is managed by [SignInActivity.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Authentification/SignInActivity.kt) and [activity_sign_in.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/activity_sign_in.xml)
Regex for sign in: 
- No empty fields
- Check if email address is valid
- Password must have at least 8 characters
- Password must contain digit, special character, and uppercase
User can click on password reset link to reset her password via email

<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/signin.png?raw=true" width="300" height="600">

### Sign up:
Sign up workflow is managed by [SignUpActivity.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/activity_sign_up.xml) and [activity_sign_up.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Authentification/SignUpActivity.kt)
Regex for sign in: 
- No empty fields (except phone number)
- Check if email address is valid
- Check if pone number is correct if this one is filled
- Password must have at least 8 characters
- Password must contain digit, special character, and uppercase
When user click on sign up button, he can go on the use condition screen
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/signup.png?raw=true" width="300" height="600">

### Use conditions:
Use condition workflow is managed by [UsesConditionsActivity.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Authentification/UsesConditionsActivity.kt) and [activity_uses_conditions.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/activity_uses_conditions.xml)
User cannot create account without having **validate the use conditions.** . If all is done, account creation start.
User object is [TchaUser.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Authentification/Models/TchaUser.kt)
```
class TchaUser(val birthdate: Date? = null, val email: String? = null, val firstName: String?= null,
               val lastName: String?= null, var uid: String?= null, val userCertified: Boolean?= null,
               val profileImage: String?= null, val identityDocumentImage: String?= null,
               val documentType: String?= null, val documentId: String? = null) {

}
```

<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Use%20conditionsActivity.png?raw=true" width="300" height="600">

## User profile:
User profile screen is managed by [ProfileFragment.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/MainBottomBar/ProfileFragment.kt) and [fragment_profile.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/fragment_profile.xml)
Image and username should be updated in real time (already done)
Actions on buttons are not done for the moment


<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/userProfil.png?raw=true" width="300" height="600">

## Share a route:
Share route screen is managed by [ShareFormActivity.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/ShareATrip/ShareFormActivity.kt) and [activity_share_form.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/activity_share_form.xml)
each route objet must be an instance of [Route.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/ShareATrip/Models/Route.kt)
```
class Route(val admin: String, val arrivalCity: String, val departureCity: String, val departureDate: Date,
               val arrivalDate: Date, var transportCompany: String, val kilosAvailable: Int,
               val kiloPrice: Int, val packageGranted: String,
               val automaticAcceptation: Boolean, val inHub: Boolean, val inParticular: Boolean,
               val passportNumber: Int, val endOfValidity: Date, val ticketUrl: String, val passportUrl: String) {

}
```
Rules to share a route:
- No empty fields
- The departure date must not be later than the arrival date
- The passport cannot be expired
- Juste one "option de retrait" can be actived

<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/share%20route%20main%20page.png?raw=true" width="300" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20publier%20–%208.png?raw=true" width="300" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20publier%20–%202.png?raw=true" width="300" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20publier%20–%205.png?raw=true" width="300" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20publier%20–%206.png?raw=true" width="300" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20publier%20–%207.png?raw=true" width="300" height="600">

## Retrieve route by admin (TO DO):
Any user who publishes an itinerary must be able to find them in the “publish” tab. This activity will be called **ReservationsRoutesActivity.kt**
Each route list must be populated based on [item_routes.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/item_routes.xml).
The object linked to this functionality is not [Route.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/ShareATrip/Models/Route.kt) but **ReservationRoute.kt** (TO DO in "Book a route" part).
The **ReservationRoute.kt** class must be like:
```
data class ReservationRoute(
    val routeId: String,
    val customerId: String,
    val bookedKilos: Int,
    val status: String,
    val nameOfReceiver: String,
    val recipientDocumentNumber: Int,
    val receiverContact: String,
    val packageInformation: String
    val serviceFees: Double
    val KilosPrice: Double
)
```
This Kotlin class defines the following attributes for a route reservation (NB: this class should be create in "Book a route" part:

- **routeId**: Unique identifier of the booking route (String type). Allows you to retrieve route information from the [Routes firestore collection](https://console.firebase.google.com/project/tcha-bf965/firestore/data/~2FRoutes~2F62622942-feb4-4b94-8978-534a8b274670)
- **serviceFees**: service fees when the user validates (if they change after booking, the customer uses those that he has validated)
- **customerId**: Identifier of the customer who made the reservation (String type). Allows you to retrieve client information from the [Firestore Users collection](https://console.firebase.google.com/project/tcha-bf965/firestore/data/~2FUsers~2F3wwftFncpsO0cV4KsyW4e0SgzNw1)
- **KilosPrice**: kilos price when the user validates (if he change after booking, the customer uses those that he has validated)
- **bookedKilos**: Number of kilos booked on the route (Int type).
- **status**: Current status of the reservation (String type).
- **nameOfReceiver**: Name of the recipient of the package (String type).
- **recipientDocumentNumber**: Document number of the recipient (Int type).
- **receiverContact**: Receiver contact (String type).
- **packageInformation**: Information about the parcel (String type).

In the **ReservationsRoutesActivity.kt** we have four tabs:
- **booking tab**: When the route has received reservations and the admin needs to validate them.
- **Upcoming tab**: When the route is ready to starts but the journey has not yet started (all necessary reservations have been validated).
- **In progress tab**: When the journey start
- **Archived tab**: When the package has been delivered to the recipient after checking their identity document
**NB**: screen below is not up to date in tab. The correct tab alignement is **Reservation -> Upcoming - > In progress -> Archived**
Use this enum (or create him) :
```
enum class RoutesSteps(val stepName: String) {
    BOOKING("booking"),
    IN_PROGRESS("inProgress"),
    UPCOMING("coming"),
    ARCHIVED("archived")
}
```
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20ManageRoute%20-%20Booking.png" width="300" height="750"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20manageRoute%20-%20in%20progress.png" width="300" height="600">

# Manage Route by Admin (TO DO)
The design of this view will change depending on the type of route you want to display. We use an enumeration containing the following cases:
```
enum class TypeRoute(val routeName: String) {
    SEARCH("search"),
    USER_ROUTES("userRoutes"),
    BOOKING_SIDE_CUSTOMER("bookingSideCustomer"),
    BOOKING_SIDE_ADMIN("bookingSideAdmin"),
    BOOKING_BY_CLIENT_SIDE_ADMIN("bookingByClientSideAdmin")
}
```
- **Search** : Not for this part (check the explain in feature related to ***"search routes"*** )
- **userRoutes** : Simple route appearance (normally not for this feature also)
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/simpleRouteView.png?raw=true" width="600" height="200">

- **bookingSideCustomer** : Not for this part also but this case it's when the user check her reservation. The only difference with the case **bookingByClientSideAdmin** is the acceptation button. Client can cancel the reservation

  <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/bookingSideCustomer.png?raw=true" width="322" height="390">
- **bookingSideAdmin** : For this part. this case it's when the user check her reservation in reservation tab.
  * The user (admin) can see the number of reservations he has received for this trip
  * can see the number of kilos reserved in total
  * can see the number of kilos he has left to sell
  * can see the possible winnings he will have
  * can see a preview of the type of users who have reserved (just 05). NB: In order to see if there are certified users without entering the full reservation
  * can cancel all reservations linked on this route
  * when user clicks on info button he can see the list of all reservations related to that itinerary (this list presented the route cards with the case **bookingByClientSideAdmin** below).

  <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/routeItem_adminBooking.png?raw=true" width="322" height="292"> 
- **bookingByClientSideAdmin** : When user want to manage her route (reservations, etc). Admin can cancel or accept the reservation. when user clicks on info button he can see the list of all reservations with this design below. User can see the information of the package receiver if he click on the name or profile photo of this one as you can see in the second picture below
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/bookingByClienSideAdmin.png?raw=true" width="322" height="370"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20reservations%20-%20receiver%20documents.png" width="300" height="600">

NB: For the time line steps, use this enum:
```
enum class TimeLineStep(val step: String) {
    SUPPORTED("supported"),
    DEPARTURE("departure"),
    ARRIVAL("arrival"),
    DEPOSIT("deposit"),
}
```
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/routeItem_adminInProgress.png" width="322" height="413">

# Search routes
User can be able to search route shared by other user in app, in search tab ([SearchFragment.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/MainBottomBar/SearchFragment.kt)) with as xml [fragment_search.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/fragment_search.xml). In the homa page, user can search a route posted by another user in search tab According to differents criteria choosen in the search form. Search criterias:
- Departure: Routes with this departure city.
- Destination: Routes with an equivalent departure date.
- Departure date: Routes with this departure date.
- Number of desired kilos: all routes offering a number of kilos greater than or equal to the number we are looking for.
- 
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20acceuil%20–%20search.png?raw=true" width="322" height="650">

When user click on search button, he is directed towards [SearchRoutesActivity.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/SearchRoutes/SearchRoutesActivity.kt) with as xml [activity_search_routes.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/activity_search_routes.xml) and he can see the list of routes

<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/Tcha%20-%20rechercheListNOFilter.png" width="322" height="650">

if user click on route, he can able to see popup form to book this one. See the section related to **Book a route**

# Filter routes
User can filter the route according to certain criteria. Filter data should be stored in the class below, if is not exist already in the code, create it:
```
data class RouteFilter(
    val inHub: Boolean,
    val inParticular: Boolean,
    val certifiedUser: Boolean,
    val price: Double
)
```
<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/filter.png" width="322" height="550">
When filter is active, the filter icon should be in green color
When user click on reset filter, datas in RouteFilter return to the default value:
```
fun resetFilter() {
this.routeFilter = RouteFilter(false, true, false, 0.0)
}
```

# Book a route
User can be able to book a route according to the form below
The xml file: [dialog_booking.xml](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/res/layout/dialog_booking.xml)
To upload data in firestore database, use fun ```addDatas(anyObject: Any, document: DocumentReference, completion: (Exception?) -> Unit)``` function in [FirestoreManager.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Managers/FirestoreManager.kt)
TO DO also: use dialog_booking.xml as dialog with [PopupsManagers.kt](https://github.com/Mekongoabanda/TCHA/blob/main/app/src/main/java/com/organisation/tcha/Common/Managers/PopupsManagers.kt)
PopupsManagers is the Tcha android app manager to build and show dialog. Create an function to build it. Take an example from the methods that have already been done in this class

anyObject parameter should be take as value an instance of this class:
```
data class ReservationRoute(
    val routeId: String,
    val customerId: String,
    val bookedKilos: Int,
    val status: String,
    val nameOfReceiver: String,
    val recipientDocumentNumber: Int,
    val receiverContact: String,
    val packageInformation: String
    val serviceFees: Double
    val KilosPrice: Double
)
```
In android, edit dialog_booking.xml and add LinearLayout horizontal with "Kilos souhaités", "-" button, number of kilos, "+" button
TOTAL = total kilos * (total kilos * fee)/100
Normally we can able to have possibility to add scan of identity document of receiver (may be we should add this)


<img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/book%20a%20route1.png" width="322" height="600"> <img src="https://github.com/Mekongoabanda/TCHA/blob/main/screenshot/Auth/book%20a%20route2.png" width="322" height="600">



