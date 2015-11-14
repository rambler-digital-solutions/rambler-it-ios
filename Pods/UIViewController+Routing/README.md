# UIViewController+Routing

**UIViewController+Routing** is a handy category, which helps with implementing a better navigation in iOS applications using *Routers*.

It does the following things at the moment:
- Holds an abstract router,
- Swizzles *-prepareForSegue:* method, forwarding it to the router.
- Provides the *-performSegueWithBlock:* method, which helps to get rid of fat *-prepareForSegue:* method.

###Installation
You can install this category in two ways:
 - *Recommended:* Install the Cocoapods gem, create Podfile and add the following line:
 
   ```ruby
   pod 'UIViewController+Routing', '~> 0.1'
   ```
 - Copy two files, *UIViewController+Routing.h* and *UIViewController+Routing.m* to your project.

###Usage
 1. Create a new class, *Router*, which inherits from NSObject. Make this class conform to *YDRouter* protocol:

 ```objc
 @interface YDRouterBase : NSObject <YDRouter>

 @end
 ```
 2. Implement any number of navigation methods with the following implementation:

    ```objc
- (void)showDetailViewControllerFromSourceViewController:(UIViewController *)sourceViewController withDictionary:(NSDictionary *)detailDictionary {
    YDSeguePreparationBlock preparationBlock =  ^void(UIStoryboardSegue *segue) {
        YDDetailViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.detailDictionary = detailDictionary;
        destinationViewController.router = self;
    };
    
    [sourceViewController performSegueWithIdentifier:YDDetailSegueIdentifier sender:self preparationBlock:preparationBlock];
}
    ```
 3. Implement the *- prepareForSegue:* method in your router:

    ```objc
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *sourceViewController = segue.sourceViewController;
    YDSeguePreparationBlock block = [sourceViewController preparationBlockForSegue:segue];
    
    if (block) {
        block(segue);
    }
}
    ```

 4. From now on, every time you called for *-performSegue:withIdentifier:* method, use the appropriate method of your router.

###Example
The project now contains a nice demo project, which shows some aspects of using this category and Routers objects. Remember to run *pod install* before building the demo app. Feel free to ask your questions in the Issues.

###Additional Info
[Here] you can read about using this category for a simple test case (in Russian). And check this [project] for an example of usage this concept in a more realistic app.

### Author
[Egor Tolstoy] - [@igrekde].

### License
*UIViewController+Routing* is available under the MIT license. See the LICENSE file for more info.

[Here]:http://etolstoy.ru/slim-routers/
[demo project]:https://github.com/igrekde/MultipleStoryboardsSample
[Egor Tolstoy]:http://etolstoy.ru
[@igrekde]:http://twitter.com/igrekde
