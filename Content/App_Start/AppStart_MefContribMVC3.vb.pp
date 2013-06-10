Imports System.ComponentModel.Composition.Hosting
Imports System.Linq
Imports System.Web.Mvc
Imports MefContrib.Hosting.Conventions
Imports MefContrib.Web.Mvc

<Assembly: WebActivator.PreApplicationStartMethod(GetType($rootnamespace$.App_Start.AppStart_MefContribMVC3), "Start")> 

Namespace $rootnamespace$.App_Start

    ''' <summary>
    ''' This is a VB.Net version of the AppStart class from the MefContrib.MVC3 nuget package
    ''' available from the official online nuget package source.
    ''' </summary>
    ''' <remarks>
    ''' <para>
    ''' Converted from C#:  11/2/2011 at 4:44 AM.<br />
    ''' By: Bryan Johns, K4GDW<br />
    ''' Email:  bjohns@greendragonweb.com
    ''' </para>
    ''' </remarks>
    Public NotInheritable Class AppStart_MefContribMVC3

        ''' <summary>
        ''' Initializes a new instance of the <see cref="AppStart_MefContribMVC3" /> class.
        ''' </summary>
        ''' <remarks>
        ''' <para>
        ''' Converted from C#:  11/2/2011 at 4:45 AM.<br />
        ''' By: Bryan Johns, K4GDW<br />
        ''' Email:  bjohns@greendragonweb.com
        ''' </para>
        ''' </remarks>
        Private Sub New()
        End Sub

        ''' <summary>
        ''' Starts this instance.
        ''' </summary>
        ''' <remarks>
        ''' <para>
        ''' Converted from C#:  11/2/2011 at 4:45 AM.<br />
        ''' By: Bryan Johns, K4GDW<br />
        ''' Email:  bjohns@greendragonweb.com
        ''' </para>
        ''' </remarks>
        Public Shared Sub Start()
            ' Register the CompositionContainerLifetimeHttpModule HttpModule.
            ' This makes sure everything is cleaned up correctly after each request.
            CompositionContainerLifetimeHttpModule.Register()

            ' Create MEF catalog based on the contents of ~/bin.
            '
            ' Note that any class in the referenced assemblies implementing in "IController"
            ' is automatically exported to MEF. There is no need for explicit [Export] attributes
            ' on ASP.NET MVC controllers. When implementing multiple constructors ensure that
            ' there is one constructor marked with the [ImportingConstructor] attribute.
            Dim catalog = New AggregateCatalog(New DirectoryCatalog("bin"), New ConventionCatalog(New MvcApplicationRegistry()))
            ' Note: add your own (convention)catalogs here if needed.
            ' Tell MVC3 to use MEF as its dependency resolver.
            Dim dependencyResolver__1 = New CompositionDependencyResolver(catalog)
            DependencyResolver.SetResolver(dependencyResolver__1)

            ' Tell MVC3 to resolve dependencies in controllers
            ControllerBuilder.Current.SetControllerFactory(New CompositionControllerFactory(New CompositionControllerActivator(dependencyResolver__1)))

            ' Tell MVC3 to resolve dependencies in filters
            FilterProviders.Providers.Remove(FilterProviders.Providers.[Single](Function(f) TypeOf f Is FilterAttributeFilterProvider))
            FilterProviders.Providers.Add(New CompositionFilterAttributeFilterProvider(dependencyResolver__1))

            ' Tell MVC3 to resolve dependencies in model validators
            ModelValidatorProviders.Providers.Remove(ModelValidatorProviders.Providers.OfType(Of DataAnnotationsModelValidatorProvider)().[Single]())
            ModelValidatorProviders.Providers.Add(New CompositionDataAnnotationsModelValidatorProvider(dependencyResolver__1))

            ' Tell MVC3 to resolve model binders through MEF. Note that a model binder should be decorated
            ' with [ModelBinderExport].
            ModelBinderProviders.BinderProviders.Add(New CompositionModelBinderProvider(dependencyResolver__1))
        End Sub
    End Class
End Namespace