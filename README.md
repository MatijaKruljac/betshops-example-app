# betshops-example-app
Betshops is one page example application.

## Behavior:

* Application shows betshops for client on map (using default mapping library for platform) -> bet shops are located in Romania
* User can move the map and zoom-in/zoom-out
* When clicking on betshop icon, detail pops out and user can see the relevant information about the betshop
* When clicking on the "Route" button, user is transfered into default navigation application to navigate to betshop location

## Tips:

* User makes the defined API call and draws markers on the map
* If user denies the location, center of the map is set to center of Bucharest *44.435105, 26.100019* 
* Working time
  * If betshop is OPEN at the moment, clock label should present *Open now until [END TIME]]
  * If betshop is CLOSED, clock label should present *Opens tomorrow at [START TIME]*
* Betshop detail data is presented in 3 rows:
  1. Name
  2. Address
  3. [City] - [County] 
* Selected betshop has different asset (large green pin)

## Rest API:

**Host**:

* https://sa-api.info

**Resource**:

* GET /api/casapariurilor/shop/list?boundingBox={0}

**Query parameters**:

 * boundingBox (required, string, `44.581149,26.304202,44.299059,25.553844`) ... bounding box in CSV format "top-right latitude (lat1), top-right longitude (lon1), bottom-left latitude (lat2), bottom-left longitude (lon2)"
    
 **Response** : (HTTP 200)

       [{
		"Id": 2362,
		"Name": "B1 BANEASA",
		"Location": {
			"Lat": 44.493698,
			"Lng": 26.084641
		},
		"Address": "Str. Aerogarii, nr. 14, bl. 2/7, sc. A, ap. 1",
		"CityId": 716,
		"City": "Sector 1",
		"County": "Bucuresti",
		"WorkingHourStart": "12:00",
		"WorkingHourEnd": "20:00",
        "Phone": "(033)216-0058 x0344"
	}, {
		"Id": 2363,
		"Name": "B1 CHIBRIT",
		"Location": {
			"Lat": 44.469661,
			"Lng": 26.050632
		},
		"Address": "Calea Grivitei, nr. 395",
		"CityId": 716,
		"City": "Sector 1",
		"County": "Bucuresti",
		"WorkingHourStart": "12:00",
		"WorkingHourEnd": "20:00",
        "Phone": "(033)216-0058 x0344"
	}]

Example CURL request and response is provided in "curl.log".

### Screenshot
https://github.com/MatijaKruljac/betshops-example-app/blob/master/betshops_screenshot.jpg
