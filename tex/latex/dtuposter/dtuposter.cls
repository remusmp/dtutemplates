%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dtuposter}[2012/06/18 v0.8 - package to create posters]

% Standard options that you should pass to the class
\RequirePackage{kvoptions}
\DeclareStringOption[This is the Poster Title]{title} % default title
\DeclareStringOption[This Ismyname]{author}           % default author
\DeclareStringOption[Subject of the Poster]{subject}  % default subject
\DeclareStringOption[poster, DTU, LaTex]{keywords}    % default keywords
\DeclareStringOption[black]{bgcolor}                  % default colour
%
%
%======================================================================
%===  Default paper and font sizes
\RequirePackage{calc,fp}
%
%% Convert mm to pt
\FPset{\dtuposter@mmpt}{2.66}
\FPmul{\dtuposter@refsize}{\dtuposter@mmpt}{1189}
%
\DeclareOption{a0paper}{
  %%A0 paper 841 x 1189 mm
  \FPmul\dtuposterwidth{841}{\dtuposter@mmpt}
  \FPmul\dtuposterheight{1189}{\dtuposter@mmpt}
  \FPdiv\dtuposter@sizeratio{\dtuposterheight}{\dtuposter@refsize}
  \PassOptionsToClass{\CurrentOption}{scrartcl}
  \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{a1paper}{
  %%A1 paper 594 x 841 mm
  \FPmul\dtuposterwidth{594mm}
  \FPmul\dtuposterheight{841mm}
  \FPdiv\dtuposter@sizeratio{\dtuposterheight}{\dtuposter@refsize}
  \PassOptionsToClass{\CurrentOption}{scrartcl}
  \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{a2paper}{
  %%A4 paper 420 x 595 mm
  \FPmul\dtuposterwidth{420mm}
  \FPmul\dtuposterheight{595mm}
  \FPdiv\dtuposter@sizeratio{\dtuposterheight}{\dtuposter@refsize}
  \PassOptionsToClass{\CurrentOption}{scrartcl}
  \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{a3paper}{
  %%A4 paper 297 x 421 mm
  \FPmul\dtuposterwidth{297mm}
  \FPmul\dtuposterheight{421mm}
  \FPdiv\dtuposter@sizeratio{\dtuposterheight}{\dtuposter@refsize}
  \PassOptionsToClass{\CurrentOption}{scrartcl}
  \PassOptionsToPackage{\CurrentOption}{geometry}
}
\DeclareOption{a4paper}{
  %%A4 paper 210 x 297 mm
  \FPmul\dtuposterwidth{210mm}
  \FPmul\dtuposterheight{297mm}
  \FPdiv\dtuposter@sizeratio{\dtuposterheight}{\dtuposter@refsize}
  \PassOptionsToClass{\CurrentOption}{scrartcl}
  \PassOptionsToPackage{\CurrentOption}{geometry}
}
% default
\ExecuteOptions{a0paper}
%
%======================================================================
%===  Define margins according to "DTU_Poster_A0_HOEJ_2sp.Skabelon.cs2"
\newcommand\dtuposter@setpapersize{
  \FPmul\dtuposter@tmp{\dtuposter@mmpt}{\dtuposter@sizeratio}
  %
  \newlength{\bgmarginleftright}%
  \setlength{\bgmarginleftright}{\dtuposter@tmp pt * 20}
  \newlength{\bgmargintop}%
  \setlength{\bgmargintop}{\dtuposter@tmp pt * 30}
  \newlength{\bgheight}%
  \setlength{\bgheight}{\dtuposter@tmp pt * 0}
  \addtolength{\bgheight}{\paperheight}
  %
  \newlength{\bgfirstline}%
  \setlength{\bgfirstline}{\dtuposter@tmp pt * 120}
  \newlength{\bgsecondline}%
  \setlength{\bgsecondline}{\dtuposter@tmp pt * 1080}
  \newlength{\bglinewidth}%
  \setlength{\bglinewidth}{\dtuposter@tmp pt * 5}
  %
  \newlength{\textmarginleftright}%
  \setlength{\textmarginleftright}{\dtuposter@tmp pt * 40}
  \newlength{\textmargintop}%
  \setlength{\textmargintop}{\dtuposter@tmp pt * 150}
  \newlength{\textmarginbottom}%
  \setlength{\textmarginbottom}{\dtuposter@tmp pt * 130}
  %
  \newlength{\textintercolumn}%
  \setlength{\textintercolumn}{\dtuposter@tmp pt * 20}
  %
  \newlength{\footerimage}%
  \setlength{\footerimage}{\paperwidth}
  \addtolength{\footerimage}{-2\textmarginleftright} % left and right
  \addtolength{\footerimage}{-3\textmarginleftright} % in between the 4 images
  \addtolength{\footerimage}{-0.75\footerimage} % 4 images => 1/4 of length
  %
  \PassOptionsToPackage{%
    centering,%
    left=\textmarginleftright,%
    right=\textmarginleftright,%
    top=\textmargintop,%
    bottom=\textmarginbottom,%
    nohead}{geometry}
    
  \newlength{\camwidth}%
  \setlength{\camwidth}{\dtuposterwidth pt + 30mm}
  \newlength{\camheight}%
  \setlength{\camheight}{\dtuposterheight pt + 30mm}
  \PassOptionsToPackage{cam,axes,info,width=\the\camwidth,height=\the\camheight,pdflatex,center}{crop}
  
  \FPmul\dtuposter@tmp{\dtuposter@mmpt}{\dtuposter@sizeratio}
  \FPmul\dtuposter@tmp{\dtuposter@tmp}{0.1}
  \newlength{\cropleftright}%
  \setlength{\cropleftright}{\dtuposter@tmp pt * 195} % (880 - 841) / 2
  \newlength{\croptopbottom}%
  \setlength{\croptopbottom}{\dtuposter@tmp pt * 205} % (1230 - 1189) / 2
}
%
%======================================================================
%===  Default font size, enlarge the font size for 2 columns
%
\DeclareOption{3columns}{
  \FPset\dtuposter@columncount{3}
  \FPset\dtuposter@fontsizefactor{1}
}
\DeclareOption{2columns}{
  \FPset\dtuposter@columncount{2}
  \FPdiv\dtuposter@fontsizefactor{48}{35}
}
% default
\ExecuteOptions{3columns}
%
%======================================================================
%===  Define fonts according to "DTU_Poster_A0_HOEJ_2sp.Skabelon.cs2"
%
\newlength\dtuposter@tmpfontsize
\newcommand{\dtuposter@fs}[1]{%
  \setlength{\dtuposter@tmpfontsize}{#1}%
  \fontsize{#1}{1.2\dtuposter@tmpfontsize}%
  \selectfont
}
%
\newcommand\dtuposter@setfonts{
  \FPmul\dtuposter@titlefontsize{\dtuposter@sizeratio}{160}
  \FPmul\dtuposter@minisecfontsize{\dtuposter@sizeratio}{60}
  \FPmul\dtuposter@tmp{\dtuposter@sizeratio}{35}
  \FPmul\dtuposter@dictumfontsize{\dtuposter@tmp}{\dtuposter@fontsizefactor}
  \FPmul\dtuposter@sectionfontsize{\dtuposter@tmp}{\dtuposter@fontsizefactor}
  \FPmul\dtuposter@subsectionfontsize{\dtuposter@tmp}{\dtuposter@fontsizefactor}
  \FPmul\dtuposter@captionfontsize{\dtuposter@sizeratio}{15}

  \setkomafont{title}{\normalfont\dtuposter@fs{\dtuposter@titlefontsize pt}}     % used with title
  \setkomafont{minisec}{\normalfont\dtuposter@fs{\dtuposter@minisecfontsize pt}}     % used for authors
  \setkomafont{dictum}{\normalfont\dtuposter@fs{\dtuposter@dictumfontsize pt}}      % used for affiliation
  \setkomafont{section}{\normalfont\dtuposter@fs{\dtuposter@sectionfontsize pt}}    % section
  \setkomafont{subsection}{\normalfont\dtuposter@fs{\dtuposter@subsectionfontsize pt}} % subsection
  \setkomafont{caption}{\normalfont\dtuposter@fs{\dtuposter@captionfontsize pt}}     % table and figure caption
  \setkomafont{captionlabel}{\usekomafont{caption}}                       % label looks the same
}
%\AtEndOfClass{\dtuposter@setfonts} 
\AtBeginDocument{\dtuposter@setfonts} 


%% Process given options
\ProcessOptions\relax

% After parsing the options, all variables are populated
\FPmul\dtuposter@tmp{\dtuposter@sizeratio}{35}
\FPmul\dtuposter@basefontsize{\dtuposter@tmp}{\dtuposter@fontsizefactor}
\PassOptionsToClass{fontsize=\dtuposter@basefontsize pt}{scrartcl}

\newlength\dtupostersizeratio
\setlength\dtupostersizeratio{\dtuposter@sizeratio pt}
\newlength\dtuposterbasefontsize
\setlength\dtuposterbasefontsize{\dtuposter@basefontsize pt}

\newlength\dtupostermmpt
\setlength\dtupostermmpt{\dtuposter@mmpt pt}
\newlength\dtuposterrefsize
\setlength\dtuposterrefsize{\dtuposter@refsize pt}


%}
%
%%======================================================================
%%===  use empty command for normal processing
%\newcommand\@drawTheGrid{%
%    
%} 
%
%%======================================================================
%%===  change the background for drafting
%\DeclareOption{draft}{%
%  \renewcommand\@drawTheGrid{%
%    \begin{scope}[shift={(current page.north west)}] %
%      \draw[xshift=\cropleftright,yshift=\croptopbottom,step=2cm,color=gray] (0,-\paperheight) grid (\paperwidth,0); %
%    \end{scope} %
%  } %
%  \PassOptionsToClass{draft}{scrartcl}%
%}
%%
%======================================================================
%===  Passes unknown options to the underlying scrartcl class
%\DeclareOption*{%
%  \PassOptionsToClass{\CurrentOption}{scrartcl}%  
%}
%
%======================================================================
%===  Process options and load class
%\ProcessOptions\relax
%
%\ProcessKeyvalOptions*
%%
%% \ifx\DTU@postercolour\@empty
%% % \@empty is a predefined macro with empty contents.
%% % the option value of option emph is empty, thus
%% % we do not want a redefinition.
%% \else
%%   \renewcommand\@postercolour{%
%%     \definecolor{DTUposter}{named}{\DTU@postercolour}                                   % colour scheme for poster
%%   }
%% \fi
%%
%\title{\DTU@title}
%\author{\DTU@author}
%% \subject{\DTU@subject}
%% \keywords{\DTU@keywords}
%%
%\AtEndOfClass{\colorlet{DTUposter}{\DTU@postercolour}}
%%
\LoadClass{scrartcl}
% Set the papersize
\dtuposter@setpapersize
\RequirePackage{geometry}
\RequirePackage{crop}

\RequirePackage{multicol}
\setlength{\columnsep}{\textintercolumn}
\AtBeginDocument{\begin{multicols}{\dtuposter@columncount}}
\AtEndDocument{\end{multicols}}


%%
%%======================================================================
%%===  Load additional packages
%%
%% Load some other required packages
%\RequirePackage{%
%  babel,
%  csquotes,  % flexible quotation marks
%  calc,        % calculate length
%  %fancybox,    % shadowbox, doublebox, ovalbox, Ovalbox
%  %fancyvrb,    % verbatim boxes
%  %moreverb,    % verbatim-hnlich: boxedverbatim, listing
%  %verbatim,    % source code listings
%  %listings,    % more source code listings
%  xcolor,      % use different colours 
%  adjustbox,
%  graphicx,   %
%  url,           %
%%==========================================
%%    tables
%%==========================================
%  booktabs,    % prof. tables
%  tabularx,    % justified table cells
%  %longtable,   % tables on several pages
%  %ltablex,     % long tables with justified cells
%  multirow,    % 
%  multicol,
%%==========================================
%%    Math and Symbols
%%==========================================
%  %aastex_hack, % use aastex macros without the package
%  amsmath,      % Math package
%  amsfonts,     % Math font
%  amssymb,      % Math symbols
%  exscale,      % scale math symbols
%  ucs,          % Unicode
%  %cjk,          % Chinese, Japanese und Korean Symbols
%  %gensymb,      % Symbols  -> replaced by package 'was' -> not with siunitx
%  marvosym,     % Symbols for different things. hazards, laundry, ...
%  eurosym,      % official euro sign, defines \euro{}
%  %bbding,       % more symbols
%  textcomp,     % Text-Companion-Font from EC-family, provides \textdegree and \textcelsius
%  %upgreek,      % non-slanted greek letters -> replaced by package 'was'
%  trfsigns,     % more symbols: Fourier transformation, Euler's Number, imaginary numbers...
%  xfrac,        % for fractions in siunitx
%  cancel,       % cancel out passages or equation
%%==========================================
%%    Mixed
%%==========================================
%  %float,        % 
%  %floatflt,     % floating table and figures
%  %subfig,       % several figures in one
%  %soul,         % hyphenatable letterspacing (spacing out), underlining, and some derivatives
%  %multicol,     % several columns
%  %bibtopic,    %
%  blindtext,    % dummy text and structures
%  setspace,     % fix spacing
%  %algorithms,   % 
%  microtype,    % better letter spacing in pdflatex
%  ragged2e,     % non-justified layout
%  ellipsis,     %
%  titlesec,
%  %tocstyle,     %
%  %pdfpages,     %to include pages
%  %pdflscape,    %
%  scrhack,       % listings float etx are not compatible with new koma script
%%==========================================
%%    Diagrams etc.
%%==========================================
%%    gnuplottex,
%%    pdftricks,
%%    pstricks,
%%    pstricks-add,
%%    color,
%%    pstcol,
%%    pst-plot,
%%    pst-tree,
%%    pst-eps,
%%    multido,
%%    pst-node,
%%    pstricks,
%%    pstricks-add,
%%    pst-node,
%%    pst-plot,
%%    pst-math,
%%    pst-pdf,
%%    epspdf,
%}
%\RequirePackage[section]{placeins}       % don't move floats to new sections, provides \FloatBarrier%
%%\usepackage[version=3]{mhchem}       % chemical reactions and compounds
%%\usepackage[absolute]{textpos}
%\RequirePackage[pdftex]{thumbpdf}        % thumbnails for pdflatex
%%
%%======================================
%%    Details for pdf files
%%======================================
%\RequirePackage[pdftex,       % hyper-references for pdflatex
%    bookmarks=true,           % generate bookmarks ...
%    bookmarksnumbered=true,   % ... with numbers
%    bookmarksopen=false,      %
%    colorlinks=false,         %
%    linkcolor=black,          %
%    bookmarksopen=false,      %
%    hypertexnames=false,      % needed for correct links to figures !!!
%    breaklinks=true,%         % break links if exceeding a single line
%%    linkbordercolor={0 0 1}  %
%    pdfborder={0 0 0},        % no red border for links
%    pdfpagelayout=SinglePage  % display one page per view
%]{hyperref}
%\AtEndOfClass{
%  \pdfminorversion=3
%  \pdfcompresslevel=0
%  \hypersetup{
%    pdfauthor = {\DTU@author},
%    pdftitle = {\DTU@title},
%    pdfsubject = {\DTU@subject},
%    pdfkeywords = {\DTU@keywords},
%    %pdfcreator = {LaTeX with hyperref package},
%    %pdfproducer = {pdfTex}
%  }
%  \pdfadjustspacing=1
%  %%%%%%%%% PDF/X-3 stuff, necessary for Blurb IF USING pdflatex %%%%%%%%%
%  % ICC color profiles are embedded in the images
%  \pdfinfo{
%  /Title (\DTU@title)   % set your title here
%  /Author (\DTU@author)       % set author name
%  /Subject (\DTU@subject)          % set subject
%  /Keywords (\DTU@keywords) % set keywords
%  /Trapped (False)
%  /GTS_PDFXVersion (PDF/X-3:2002)
%  }
%  % must have a trim box,
%  %\pdfpageattr{%/MediaBox [0 0 693.36000 594.00000]
%  %/TrimBox [0.00000 9.00000 684.36000 585.00000]}
%  \pdfminorversion=3
%  \pdfcatalog{
%  /OutputIntents [ <<
%  /Info (none)
%  /Type /OutputIntent
%  /S /GTS_PDFX
%  /OutputConditionIdentifier (tes.mek.dtu.dk)
%  /RegistryName (http://www.color.org/)
%  >> ]
%  }
%}
%%
%%
%\RequirePackage{caption}
%%\usepackage[]{sidecap}    %catpion besides the figure, with option wide
%%\usepackage[top]{mcaption}
%% \AtBeginDocument{
%% \captionsetup{%
%%     %margin = 10pt,
%% %     font = {\usetokomafont{caption}},
%% %     labelfont = {small},
%% %     format = plain, % plain or 'hang'
%% %     indention = .2em,     % 
%% %     labelsep = newline, %period, space, quad, newline
%%     justification = RaggedRight, % justified, centering
%%      singlelinecheck = true, % false (true= center for one line)
%% %     position = top, %bottom
%% %     labelformat = simple % simple, empty, parens % format
%% }
%% % \captionsetup[table]{%
%% %     labelsep = quad, %period, space, quad, newline
%% % }
%% % \captionsetup[subfloat]{%
%%     % labelsep = space, %period, space, quad, newline
%%     % %justification = RaggedRight, % justified, centering
%%     % %singlelinecheck = true, % false 
%%     % %position = bottom, %top
%%     % labelformat = parens % simple, empty, parens 
%% % }
%% %\def\eqprint#1{{\fontseries{l} \selectfont \footnotesize \sffamily (#1)}}
%% %
%% }
%%
%%======================================================================
%%===  Define fonts according to "DTU_Poster_A0_HOEJ_2sp.Skabelon.cs2"
%%===  However, there are slight differences.
%%
%\InputIfFileExists{dtucolours}{ %loaded the file
%  }{ %could not load the file
%}%
%%\@loadthefonts
%%\@postercolour
%\AtBeginDocument{\pagestyle{empty}}
%% 
%% Visit these pages for more information on font commands:
%% http://mirrors.dotsrc.org/ctan/info/latex2e-help-texinfo/latex2e.html#Typefaces
%% http://www.cl.cam.ac.uk/~rf10/pstex/latexcommands.htm
%%======================================================================
%% Use a times clone and arial in case the default fonts for 
%% the poster are undefined.
%% \providecommand{\sfdefaultposter}{ua1}
%% \providecommand{\rmdefaultposter}{ptm}
%\providecommand{\sfdefaultposter}{\sfdefault}
%\providecommand{\rmdefaultposter}{\rmdefault}
%% 
%\newcommand{\sfbfposter}{\usefont{\encodingdefault}{\sfdefaultposter}{\bfdefault}{\shapedefault}} % bold, sans-serif
%\newcommand{\sfmdposter}{\usefont{\encodingdefault}{\sfdefaultposter}{\mddefault}{\shapedefault}} % normal, sans-serif
%\newcommand{\rmbfposter}{\usefont{\encodingdefault}{\rmdefaultposter}{\bfdefault}{\shapedefault}} % bold, roman
%\newcommand{\rmmdposter}{\usefont{\encodingdefault}{\rmdefaultposter}{\mddefault}{\shapedefault}} % normal, roman
%%
%\AtEndOfClass{\@loadthefonts} 
%%
%%======================================================================
%%===  Create a new fontsize command
%\newlength{\DTU@fontsize}
%% \newcommand{\DTU@fscommand}[1]{%
%%   \normalsize
%%   \@defaultunits\DTU@fontsize=#1pt\relax\@nnil
%%   \edef\@tempa{{\strip@pt\DTU@fontsize}}%
%%   \ifx\protect\@typeset@protect
%%      \edef\@currsize{\noexpand\DTU@fscommand\@tempa}% store calculated size
%%   \fi
%%   \DTU@fontsize=1.2\DTU@fontsize
%%   \edef\@tempa{\@tempa{\strip@pt\DTU@fontsize}}%
%%   \@tempa
%%   \expandafter\fontsize\@tempa
%%   \selectfont
%% }
%\newcommand{\DTU@fscommand}[1]{%
%  \setlength{\DTU@fontsize}{#1}%
%  \setlength{\DTU@fontsize}{1.2\DTU@fontsize}%
%  \fontsize{#1}{\DTU@fontsize}%
%  \selectfont
%}
%
%%
%%======================================================================
%%    DTU font specifications
%%======================================================================
%%===  Use windows fonts that comply with DTU standards
%%     \renewcommand{\rmdefault}{times-ttf}
%%     \renewcommand{\sfdefault}{verdana}
%%     \renewcommand{\sfdefault}{arial}
%%======================================================================
%%===  Built-in Tex fonts that comply with DTU standards
%%      \usepackage{mathptmx}       %Time New Roman, set as default rm font - use "ptm" for direct access
%%      \usepackage[scaled]{uarial} %Arial clone, set as default sf font - use "ua1" for direct access
%%======================================================================
%%===  The official fonts, NeoSans is not available on most systems
%%     \usepackage{MnSymbol}                    %Math font for MinionPro, free package
%%     \usepackage{neosansstd}                  %NeoSans, set as default sf font - use "fns" for direct access
%%     \usepackage[minionint,mathlf]{MinionPro} %MinionPro, set as default rm font - use "MinionLF" for direct access
%%======================================================================
%%===  Jorrit's choice, Myriad fits Minion and both are free 
%%     \usepackage{MnSymbol}  
%%     \usepackage[lf]{MyriadPro} 
%%     \usepackage[minionint,lf]{MinionPro}
%%======================================================================
%%===  Jorrit's choice for posters
%%    \RequirePackage{cmbright}
%%    \RequirePackage[scaled]{uarial} %Arial clone, set as default sf font - use "ua1" for direct access
%%       \RequirePackage[typeface=default,
%%             sanstypeface=urwarial,
%%             mathtypeface=arevmath
%%       ]{typeface}
%%      \renewcommand{\familydefault}{\sfdefault}
%%======================================================================
%%
%%
%%======================================================================
%%     \newcommand{\euro}{\texteuro}
%%======================================================================
%%
%%     cmr             Computer Modern Roman
%%     cmss            Computer Modern Sans
%%     cmtt            Computer Modern Typewriter
%%     cmm             Computer Modern Math Italic
%%     cmsy            Computer Modern Math Symbols
%%     cmex            Computer Modern Math Extensions
%%     ptm             Adobe Times
%%     phv             Adobe Helvetica
%%     pcr             Adobe Courier
%%
%%======================================================================
%%    typeset units correctly
%%======================================================================
%\RequirePackage{siunitx}    % new way to typeset units!
%\AtBeginDocument{ 
%  \sisetup{detect-all}
%  % \sisetup{detect-all, unit-mode=text, mode=text, number-mode=math}
%  % \renewcommand{\ohm}{\text{\fontfamily{cmbr}\fontseries{m}\selectfont{}{\textohm}}}
%  % \renewcommand{\angstrom}{\text{\fontfamily{pfr}\myFont{}\capitalring{A}}}
%  % \newcommand{\euro}{\text{\fontfamily{cmbr}\fontseries{m}\selectfont{}{\texteuro}}}
%  % \newcommand{\celsius}{\text{\fontfamily{pfr}\fontseries{\seriesdefault}\selectfont{}{\textcelsius}}}%{\degree~C}}}
%  \DeclareSIUnit\rpm{rpm}
%  \DeclareSIUnit\wtp{wt\percent}
%  \DeclareSIUnit\volp{vol\percent}
%  \DeclareSIUnit\century{century}
%  \DeclareSIUnit\year{a}
%  \DeclareSIUnit\kWth{\kilo\watt\textsubscript{th}}
%  \DeclareSIUnit\kWel{\kilo\watt\textsubscript{el}}
%  \DeclareSIUnit\kWh{kWh}
%  \DeclareSIUnit\EUR{\mbox{\texteuro}}
%  \DeclareSIUnit\DKK{kr}
%}
%%
%%======================================================================
%% Define spaces according to "DTU_Poster_A0_HOEJ_2sp.Skabelon.cs2"
%%======================================================================
%\newlength{\bgmarginleftright}%
%\setlength{\bgmarginleftright}{20mm}
%\newlength{\bgmargintop}%
%\setlength{\bgmargintop}{30mm}
%\newlength{\bgheight}%
%\setlength{\bgheight}{0mm}
%\addtolength{\bgheight}{\paperheight}
%%
%\newlength{\bgfirstline}%
%\setlength{\bgfirstline}{120mm}
%\newlength{\bgsecondline}%
%\setlength{\bgsecondline}{1080mm}
%\newlength{\bglinewidth}%
%\setlength{\bglinewidth}{5pt}
%%
%\newlength{\textmarginleftright}%
%\setlength{\textmarginleftright}{40mm}
%\newlength{\textmargintop}%
%\setlength{\textmargintop}{150mm}
%\newlength{\textmarginbottom}%
%\setlength{\textmarginbottom}{130mm}
%%
%\newlength{\textintercolumn}%
%\setlength{\textintercolumn}{20mm}
%%
%\newlength{\footerimage}%
%\setlength{\footerimage}{\paperwidth}
%\addtolength{\footerimage}{-2\textmarginleftright} % left and right
%\addtolength{\footerimage}{-3\textmarginleftright} % in between the 4 images
%\addtolength{\footerimage}{-0.75\footerimage} % 4 images => 1/4 of length
%%
%%\usepackage[a0paper,centering,left=\sidemargin,right=\sidemargin,top=\sidemargin,bottom=\bottomheight,nohead]{geometry}
%\RequirePackage[a0paper,centering,left=\textmarginleftright,right=\textmarginleftright,top=\textmargintop,bottom=\textmarginbottom,nohead]{geometry}
%%
%%A0 paper 841 x 1189 mm
%%A1 paper 594 x 841 mm
%%A4 paper 210 x 297 mm
%%
%%\usepackage[cam,axes,info,width=90truecm,height=125truecm,center]{crop}
%\RequirePackage[cam,axes,info,width=88truecm,height=123truecm,pdflatex,center]{crop}
%\newlength{\cropleftright}%
%\setlength{\cropleftright}{19.5mm} % (880 - 841) / 2
%\newlength{\croptopbottom}%
%\setlength{\croptopbottom}{20.5mm} % (1230 - 1189) / 2
%%
%%======================================================================
%% Use tikz to draw the background 
%%======================================================================
%\RequirePackage{tikz}
%\usetikzlibrary{shapes,calc,positioning,backgrounds,shadings}
%%
%\AtBeginDocument{\makebackground}
%\newcommand{\makebackground}%
%{ 
%  \begin{tikzpicture}[remember picture,overlay]
%  \begin{pgfonlayer}{background}
%  % set base node as marker
%  \node [inner sep=0pt,xshift=\cropleftright,yshift=\croptopbottom,below right] at (current page.north west)
%  { %ttt };
%    \begin{tikzpicture}[remember picture,overlay]
%      % just a marker
%      %\filldraw[inner sep=0pt,color=white] (0mm,0mm) rectangle +(0.1mm,-0.1mm);
%      %
%      \draw (\textmarginleftright,-50mm) node[inner sep=0pt, below right] {\includegraphics[height=43.25mm]{tex_dtu_mekanik_b_uk}}; 
%      \draw (\paperwidth-\textmarginleftright,-30mm) node[inner sep=0pt, below left] {\includegraphics[width=44.5mm]{tex_dtu_logo}}; 
%      \filldraw[inner sep=0pt,color=DTUposter!10] (\bgmarginleftright,-\bgfirstline-\bglinewidth) rectangle (\paperwidth-\bgmarginleftright,-\bgsecondline); 
%      \filldraw[inner sep=0pt,color=DTUposter]    (\bgmarginleftright,-\bgfirstline) rectangle (\paperwidth-\bgmarginleftright,-\bgfirstline-\bglinewidth); 
%      \filldraw[inner sep=0pt,color=DTUposter]    (\bgmarginleftright,-\bgsecondline) rectangle (\paperwidth-\bgmarginleftright,-\bgsecondline-\bglinewidth); 
%      %
%      \draw (\textmarginleftright,-1125mm) node[inner sep=0pt, below right] {\includegraphics[width=\footerimage]{tex_dtu_mekanik_b_uk}};
%      \draw (2\textmarginleftright+\footerimage,-1125mm) node[inner sep=0pt, below right] {\includegraphics[width=\footerimage]{tex_dtu_mekanik_b_uk}};
%      \draw (3\textmarginleftright+2\footerimage,-1125mm) node[inner sep=0pt, below right] {\includegraphics[width=\footerimage]{tex_dtu_mekanik_b_uk}};
%      \draw (4\textmarginleftright+3\footerimage,-1125mm) node[inner sep=0pt, below right] {\includegraphics[width=\footerimage]{tex_dtu_mekanik_b_uk}};
%      % 
%    \end{tikzpicture}
%  };
%  \@drawTheGrid 
%  \end{pgfonlayer}
%  \end{tikzpicture}
%}
%%
%%======================================================================
%%       New headlines
%%======================================================================
%%
%%\@startsection{<type>}{<level>}{<indent>}{<beforeskip>}{<afterskip>}{<style>} 
%%
%\renewcommand{\section}{%
%  \@startsection
%    {section}{1}{0pt}{1.25\baselineskip}%
%    {.25\baselineskip}{\usekomafont{section}}%
%}
%\renewcommand{\subsection}{%
%  \@startsection
%    {subsection}{2}{0pt}{0.75\baselineskip}%
%    {-.25\baselineskip}{\usekomafont{subsection}}%
%}
%%
%%======================================================================
%%        New/redefined commands and environments
%%======================================================================
%%
%\def\trim#1{\ignorespaces#1\unskip} 
%\newcommand{\rmnum}[1]{\romannumeral #1}
%\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}
%% Avoid problems with TikZ in moving arguments:
%\tikzset{circlednumber/.style={inner sep=0pt,minimum size=20pt,circle,line width=1pt,draw}}
%\DeclareRobustCommand\tikzNum[1]{\tikz[baseline=(one.base)] \node [circlednumber] (one) {#1};}
%%
%\newenvironment{fadebox}%
%  {\begin{lrbox}{\@tempboxa}} %
%  {\end{lrbox} % box created, now load the rest
%    \begin{tikzpicture} %
%      \begin{pgfonlayer}{background} %
%      % set base node as marker
%      \node [inner sep=0.5ex,line width=5pt,outer color=DTUposter!0,inner color=white,draw=DTUposter!5,rounded corners=10pt] { %
%        \usebox{\@tempboxa} %
%      }; %
%      \end{pgfonlayer} %
%    \end{tikzpicture} %\par
%  } %
%%
%% optional argument for figure width, standard is linewidth
%\newcommand{\figurebox}[2][\linewidth]{% 
%  \begin{fadebox} %
%    \includegraphics[width=#1]{#2} %
%  \end{fadebox} }
%%
%\newcommand{\figureboxfree}[2][width=\linewidth]{% 
%  \begin{fadebox} %
%    \includegraphics[#1]{#2} %
%\end{fadebox} }
%%
%\newenvironment{posterhead}{ %
%  \begin{minipage}{.95\linewidth} %
%    \flushleft \par
%    {\usekomafont{title} \@title } \par \vspace*{2\baselineskip} %
%    \usekomafont{minisec} \trim{\@author} 
%}{ %
%  \par  \vspace*{.5\baselineskip} %
%  \end{minipage} %
%} %
%%
%\newenvironment{postercontent}{ %
%%  \raggedcolumns
%  \setlength{\columnsep}{\textintercolumn}
%  \begin{multicols}{\@postercolumns} 
%}{ 
%  \end{multicols} 
%} %
%%
%\renewenvironment{table} %
%  { \par \def\@captype{table}} %
%  { \par } %
%%
%\renewenvironment{figure} %
%  { \par \def\@captype{figure} \begin{center} \begin{minipage}{.9\columnwidth} \begin{center} } %
%  { \end{center} \end{minipage} \end{center} \par } %
%%

\endinput