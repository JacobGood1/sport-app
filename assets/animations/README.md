# Rive Animations

This directory is for storing Rive animation files (.riv) that will be used in the application.

## How to add a Rive animation

1. Create or download a Rive animation file (.riv)
2. Place the file in this directory
3. Make sure the file is named `example.riv` or update the path in `src/sports_app/rive_widget.cljd`

## Getting Rive animations

You can create your own animations using the Rive editor at [rive.app](https://rive.app/) or download sample animations from the Rive community.

Some sample animations can be found at:
- [Rive's official examples](https://rive.app/community/)
- [Rive's GitHub repository](https://github.com/rive-app/rive-examples)

## Using in the app

The current implementation in `rive_widget.cljd` expects a file named `example.riv` with an animation named "idle".
If your animation has a different name, update the code accordingly:

```clojure
;; Change this line in rive_widget.cljd
(rive/SimpleAnimation. "idle")  ;; Replace "idle" with your animation name
```