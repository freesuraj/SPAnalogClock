Clock-iOS
=========

*** A clone of native app clock ***

![SPClockView 1] (https://dl.dropboxusercontent.com/u/4280704/publicPhotos/spclockView.png)

###Features
1. Can set the time zone or choose from a list of time zone
2. Automatically detects the day or night and changes the background of the clock
3. Doesn't use `NSTimer	` to schedule the time, so it won't be blocked by any other UI operations.
4. Swipe to delete the added clock
5. Displays the name of the timezone and time in digital format
6. Digital clock to display the name in format: `HH:mm:ss`

### How to use

### CocoaPods
	Pod 'SPClockView'
	
### Manual

1. Import the files `SPClockView.h` and `SPClockView.m` into your projects.
2. After adding the `SPClockView` into your parent view, set its `time zone` by calling `setTimeZone:` method.
3. Digital clock `SPDigitalClock` is a subclass of `UILabel`, and is implemented inside the `SPClockView` class. To set the digital time also call the method `setTimeZone:` on `SPDigitalClock`.

### Example
1. `SPClockView`

		SPClockView *clockView = [[SPClockView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
		
		[clockView setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]]; // New York
		
2. `SPDigitalClock`
			
		SPDigitalClock *digClock = [[SPDigitalClock alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
		
		[digClock setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]]; // New York



### Contact
This is a quickly made project so could have few bugs. Feel free to add bug list or contact me at <freesuraj@gmail.com> or <http://www.twitter.com/freesuraj> !!
