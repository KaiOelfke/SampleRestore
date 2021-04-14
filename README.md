## TLDR:
func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) doesn’t get called apparently.

Using the responder mechanism or alternativeResponder breaks scene and view ctrl values. The delegate seems to be reliable.

We can either use the responder, altResponder and delegate mechanisms or scene, view controller and delegate calls.

# Test results

`[.responder, .sceneDelegate, .userActivityDelegate, .viewController]`
|||
|---|---|
Has scene value| false
Has delegate value| true
Has responder value| true
Has view ctrl value| false


Missing view ctrl and scene value ❌

`[.sceneDelegate]`
|||
|---|---|
Has scene value| true
Has delegate value| false
Has responder value| false
Has view ctrl value| false

Matches flags ✅

`[.viewController]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| false
Has view ctrl value| true

Matches flags ✅

`[.responder]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| true
Has view ctrl value| false

Matches flags ✅

`[.userActivityDelegate]`
|||
|---|---|
Has scene value| false
Has delegate value| true
Has responder value| false
Has view ctrl value| false

Matches flags ✅

`[.sceneDelegate, .userActivityDelegate, .viewController]`
|||
|---|---|
Has scene value| true
Has delegate value| true
Has responder value| false
Has view ctrl value| true

Matches flags ✅

`[.responder, .viewController]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| true
Has view ctrl value| false

Missing view ctrl ❌

`[.responder, .sceneDelegate]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| true
Has view ctrl value| false

Missing scene value ❌

`[.alternativeResponder]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| false
Has view ctrl value| false
Has alt responder value| true

Matches flags ✅

`[.alternativeResponder, .sceneDelegate, .viewController]`
|||
|---|---|
Has scene value| false
Has delegate value| false
Has responder value| false
Has view ctrl value| false
Has alt responder value| true

Missing scene and view ctrl value ❌

`[.alternativeResponder, .responder, .userActivityDelegate]`
|||
|---|---|
Has scene value| false
Has delegate value| true
Has responder value| true
Has view ctrl value| false
Has alt responder value| true

Matches flags ✅

`[.viewController, .sceneDelegate, .userActivityDelegate]`
|||
|---|---|
Has scene value| true
Has delegate value| true
Has responder value| false
Has view ctrl value| true
Has alt responder value| false

Matches flags ✅
