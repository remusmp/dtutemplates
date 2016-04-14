# DTU Templates #

## Contributors ##

* @remusmp **dtubeamer**
* @jorritw **dtuposter**
* Tobias Steinmann **dtuletter**
* @s124320 (martinjlowm) **maintenance**

## Installation ##
1. Download the repository as a .zip-file and store it somewhere.
2. Depending on which LaTeX distribution you have, follow the corresponding
   section next.

### MiKTeX ###

Open the MiKTeX settings (Start Menu -> MiKTeX -> Maintenance -> Settings) and
note the directories listed under the `Roots` tab and leave this window open.

Navigate to the directory with the `UserData` description and extract the
downloaded template zip file.

Back in the MiKTeX settings window hit the `Refresh FNDB` button under the
`General` tab.


### TeXLive ###
#### Option 1: Using the terminal ####

If you are familiar with the terminal, you can perform the following commands to
install the templates.

Linux:
```
$ mkdir -p ~/texmf/
$ cd ~/texmf/
```

or OS X:
```
$ mkdir -p ~/Library/texmf/
$ cd ~/Library/texmf/
```

followed by
```
$ unzip PATH/TO/ZIP/FILE.zip
$ texhash
```

#### Option 2: Using a file manager ####

Linux:

1. Navigate to your home directory and open the texmf directory if it
   exists. If texmf does not exist then create it. (/home/username/)

OS X:
1. Open `Finder` then hold down the `Alt` key and go to `Go -> Library` and
   navigate to the `texmf` directory if it exists. If it doesn't then create it.

![Step 1](/latex/dtutemplates/raw/master/screenshots/osx_step_1.png)

2. Open the texmf directory

3. Extract the template zip file here (copy the tex directory from the zip file here)

4. Open a terminal and type `texhash` and hit enter
