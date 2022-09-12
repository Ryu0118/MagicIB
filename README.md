<div align="center">  

  # MagicIB

  #### MagicIB is a CLI tool that quickly and automatically generates Swift code from Interface Builder files.
  
  ![IMG_0848](https://user-images.githubusercontent.com/87907656/189729513-96ef175e-c481-4e54-a3a0-e5d6608c1df3.PNG)
  
  ![Language:Swift](https://img.shields.io/static/v1?label=Language&message=Swift&color=orange&style=flat-square)
  ![License:MIT](https://img.shields.io/static/v1?label=License&message=MIT&color=blue&style=flat-square)
  [![Latest Release](https://img.shields.io/github/v/release/Ryu0118/MagicIB?style=flat-square)](https://github.com/Ryu0118/MagicIB/releases/latest)
  ![Platform Compatibility](https://img.shields.io/badge/Platform%20Compatibility-macos-green)
  [![Twitter](https://img.shields.io/twitter/follow/ryu_hu03?style=social)](https://twitter.com/ryu_hu03)
</div>

## Installation
```
$ brew install ryu0118/magicib/magicib
```

## Usage
```
USAGE: magicib [<project-path>] [<ib-path>] [--output-dir <output-dir>]

ARGUMENTS:
  <project-path>          The root directory of the project containing the IB
                          files you want to convert to Swift
  <ib-path>               Path of the Interface builder file you want to
                          convert to Swift

OPTIONS:
  -o, --output-dir <output-dir>
                          Output directory for files converted to Swift
  -h, --help              Show help information.
```
### Example1
Current directory is the target iOS project <br>

<p align="center"> 
  <img width="600" alt="スクリーンショット 2022-09-07 23 30 38" src="https://user-images.githubusercontent.com/87907656/188904416-fb38040d-ce91-4625-b934-2379865b5cb4.png"> 
</p>

then run this.
```
$ magicib .
```

<p align="center">
    <img width="600" alt="スクリーンショット 2022-09-07 23 38 01" src="https://user-images.githubusercontent.com/87907656/188906085-1872751c-079c-4e17-b864-d314bf7c47e9.png">
</p>

### Example2
Specify the output directory for the generated Swift files.

<p align="center"> 
  <img width="636" alt="スクリーンショット 2022-09-07 23 52 31" src="https://user-images.githubusercontent.com/87907656/188909606-bfd7cd25-f2fd-46d7-8ea0-0566c7db7cff.png">
</p>

then run this.
```
$ magicib . --output-dir ./output/
```
<p align="center"> 
  <img width="638" alt="スクリーンショット 2022-09-07 23 52 56" src="https://user-images.githubusercontent.com/87907656/188909698-603b90ab-1915-4859-9464-c4768cf61f33.png">
</p>

### Example3
Generate Swift code from a single storyboard file.
<p align="center"> 
  <img width="640" alt="スクリーンショット 2022-09-08 0 00 33" src="https://user-images.githubusercontent.com/87907656/188911563-20d0787c-acea-468b-97b9-d9e0d3f73b13.png">
</p>

then run this.
```
$ magicib ./Storyboards/HomeViewController.storyboard
```

<p align="center"> 
  <img width="640" alt="スクリーンショット 2022-09-08 0 00 57" src="https://user-images.githubusercontent.com/87907656/188911652-ca456aa5-685d-489a-b977-d41c2e80bd18.png">
</p>




