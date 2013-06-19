MefContrib.MVC3.VB
==============

----

This is a simple [NuGet](http://nuget.org) package that installs a vb.net
bootstrapper for Microsoft's [Managed Extensibility Framework][1] (MEF) into
a VB [Asp.Net Mvc3][2] project.

[1]	http://bit.ly/11DdiE2
[2] http://www.asp.net/mvc/mvc3

Once i've had time to test it and verify that it actually does what it's
supposed to do I'll end up publishing it to the official NuGet Package
Source so it'll be widely available to other web developers on the Asp.Net
stack.$

If you'd like to take a stab at it or have improvement suggestions, just send
me a pull request.  I'm using the git-flow workflow so you should fork the
project, create a feature branch named "feature/<your-new-feature>" or
"hotfix/<your-new-bugfix>", in the case of a bug, and send me a pull request
from that branch.

Notes:
------

*	I'm switching the project to git-flow workflow.  The only deviation I'm
	using is I want to name the development branch "dev" instead of
	"develop".	Unfortunately, for some reason git will not let me rename the
	branch using any of the methods for doing so I've found.  So until I
	can figure out a way to do it, I've got a "dev" branch that I use and
	the "develop" branch will just sit there until I can find a way to
	delete it.
*	It would ***probably*** work fine for Mvc4 as well as it follows the same
	App_Start convention for such start up code.  YMMV
