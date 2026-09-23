# ScreenMazer

ScreenMazer is a screensaver for Mac that builds a maze, and then solves it, repetitively.  I had this idea a while back watching some gifs of maze generation, and so I made it!

<p align="center">
  <img src="sampleMaze.gif" height="250" ><br>
  <i>Gif of it in action</i>
</p>


<p align="center">
  <img src="settings.jpg" height="250" ><br>
  <i>Settings Page</i>
</p>


## Installation

Download the archive for your Mac from the latest [release](../../releases/latest):

- `ScreenMazer-arm64.saver.zip` for Apple silicon Macs
- `ScreenMazer-x86_64.saver.zip` for Intel Macs

Extract `ScreenMazer.saver`, then double-click it to install it in System Settings.
Feel free to customize it!

Alternatively, you can build it from the source here.

Every push and pull request is also built by GitHub Actions. Development builds can
be downloaded from the latest successful [workflow run](../../actions/workflows/build.yml).

If macOS blocks the screen saver because it is not notarized, go to
`System Settings` -> `Privacy & Security` and click **Open Anyway**.

### With Help From
* [ScreenSaverMinimal](https://github.com/mirkofetter/ScreenSaverMinimal)
* [ColorClockSaver](https://github.com/edwardloveall/ColorClockSaver)
* [maze-generation-algorithms](https://github.com/lucas-tulio/maze-generation-algorithms)
