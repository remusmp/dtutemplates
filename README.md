# DTU Templates #

## Contributors ##

* @remusmp **dtubeamer**
* @jorritw **dtuposter**
* Tobias Steinmann **dtuletter**
* @s124320 (martinjlowm) **maintenance**

## Installation ##
1. Download the repository as a .zip-file and store it somewhere.
2. Depending on which LaTeX distribution you have, follow the corresponding
   section next. For using the templates on ShareLaTeX, see the ShareLaTeX
   section below.

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

![Step 1](https://gitlab.gbar.dtu.dk/latex/dtutemplates/raw/master/screenshots/osx_step_1.png)

2. Open the texmf directory

3. Extract the template zip file here (copy the tex directory from the zip file here)

4. Open a terminal and type `texhash` and hit enter

## ShareLaTeX ##

ShareLaTeX is different from a local LaTeX setup and the templates cannot be
installed and indexed as such. Instead, the templates have to be extracted and
stored per project. To do so, pick the template you wish to use (`dtubeamer`,
`dtucover`, `dtuletter`, `dtuposter`) and upload the `.sty` and/or `.cls` files
for that specific template as found in their respective folders. E.g., for
`dtubeamer`, the root file tree on ShareLaTeX should have the following files
present:

```
beamercolorthemeDTU.sty
beamerfontthemeDTU.sty
beamerinnerthemeDTU.sty
beamerouterthemeDTU.sty
beamerthemeDTU.sty
```

The templates attempt to load `departments.tex` and `dtucolours.tex` and they
also depend on logos as supplied in the `dturesources` directory. This means,
the contents of `dturesources` must exist alongside the template files on
ShareLaTeX. Upload the contents of `dturesources` and you are good to go!

The complete file tree for the Beamer template should consist of the following
files and directories:

```
F beamercolorthemeDTU.sty
F beamerfontthemeDTU.sty
F beamerinnerthemeDTU.sty
F beamerouterthemeDTU.sty
F beamerthemeDTU.sty
F departments.tex
D dtu_background
D dtu_dep_logo
D dtu_dep_name_logo
D dtu_frise
D dtu_logo
F dtucolours.tex
D frieze
F main.tex
F tex_dtu_elektro_a_uk.pdf (moved from dtu_dep_logo)
F tex_dtu_frise.pdf (moved from dtu_frise)
F tex_dtu_logo.pdf (moved from dtu_logo)
```

We recommend that you synchronise your ShareLaTeX projects with Dropbox to make
the uploading process more convenient. The web interface has a limit of
uploading 40 files at a time.

Once synchronised, your ShareLaTeX projects will be available in
`Dropbox/Apps/ShareLaTeX` and you can copy/paste the directories in there.

In general, if ShareLaTeX complains about not being able to find a specific
file, then move that file to the root of your project. ShareLaTeX looks for
files relative to the root directory and it does _not_ index subdirectories.
