> Source: https://wiki.servarr.com/prowlarr/contributing



# <a href="#how-to-contribute" class="toc-anchor">¶</a> How to Contribute

We're always looking for people to help make Prowlarr even better, there are a number of ways to contribute.

# <a href="#documentation" class="toc-anchor">¶</a> Documentation

Setup guides, <a href="/prowlarr/faq" class="is-internal-link is-valid-page">FAQ</a>, the more information we have on the <a href="/prowlarr" class="is-internal-link is-valid-page">wiki</a> the better.

# <a href="#development" class="toc-anchor">¶</a> Development

Prowlarr is written in C# (backend) and JS (frontend). The backend is built on the .NET8 framework, while the frontend utilizes Reactjs.

## <a href="#tools-required" class="toc-anchor">¶</a> Tools required

- Visual Studio 2022 or higher is recommended (<a href="https://www.visualstudio.com/vs/" class="is-external-link">https://www.visualstudio.com/vs/</a>). The community version is free and works (<a href="https://www.visualstudio.com/downloads/" class="is-external-link">https://www.visualstudio.com/downloads/</a>).

> VS 2022 V17.8 or higher is recommended as it includes the .NET8 SDK

- HTML/Javascript editor of choice (VS Code/Sublime Text/Webstorm/Atom/etc)
- <a href="https://git-scm.com/downloads" class="is-external-link">Git</a>
- The <a href="https://nodejs.org/" class="is-external-link">Node.js</a> runtime is required. The following versions are supported:
  - **20** (any minor or patch version within this)

> The Application will **NOT** run on older versions such as `18.x`, `16.x` or any version below 20.0! Due to a dependency issue, it will also not run on `21.x` and is untested on other versions.

- <a href="https://yarnpkg.com/getting-started/install" class="is-external-link">Yarn</a> is required to build the frontend
  - Yarn is included with **Node 20**+ by default. Enable it with `corepack enable`
  - For other Node versions, install it with `npm i -g corepack`

## <a href="#getting-started" class="toc-anchor">¶</a> Getting started

1.  Fork Prowlarr
2.  Clone the repository into your development machine. <a href="https://docs.github.com/en/get-started/quickstart/fork-a-repo" class="is-external-link"><em>info</em></a>

> Be sure to run lint `yarn lint --fix` on your code for any front end changes before committing.  
> For css changes `yarn stylelint-windows --fix`

### <a href="#building-the-frontend" class="toc-anchor">¶</a> Building the frontend

- Navigate to the cloned directory

- Install the required Node Packages

  ``` prismjs
  yarn install
  ```

- Start webpack to monitor your development environment for any changes that need post processing using:

  ``` prismjs
  yarn start
  ```

### <a href="#building-the-backend" class="toc-anchor">¶</a> Building the Backend

The backend solution is most easily built and ran in Visual Studio or Rider, however if the only priority is working on the frontend UI it can be built easily from command line as well when the correct SDK is installed.

#### <a href="#visual-studio" class="toc-anchor">¶</a> Visual Studio

> Ensure startup project is set to `Prowlarr.Console` and framework to `net8.0`

1.  First `Build` the solution in Visual Studio, this will ensure all projects are correctly built and dependencies restored
2.  Next `Debug/Run` the project in Visual Studio to start Prowlarr
3.  Open <a href="http://localhost:9696" class="is-external-link">http://localhost:9696</a>

#### <a href="#command-line" class="toc-anchor">¶</a> Command line

1.  Clean solution

``` prismjs
dotnet clean src/Prowlarr.sln -c Debug
```

1.  Restore and Build debug configuration for the correct platform (Posix or Windows)

``` prismjs
dotnet msbuild -restore src/Prowlarr.sln -p:Configuration=Debug -p:Platform=Posix -t:PublishAllRids
```

1.  Run the produced executable from `/_output`

## <a href="#contributing-code" class="toc-anchor">¶</a> Contributing Code

- If you're adding a new, already requested feature, please comment on <a href="https://github.com/Prowlarr/Prowlarr/issues" class="is-external-link">GitHub Issues</a> so work is not duplicated (If you want to add something not already on there, please talk to us first)
- Rebase from Prowlarr's develop branch, do not merge
- Make meaningful commits, or squash them
- Feel free to make a pull request before work is complete, this will let us see where its at and make comments/suggest improvements
- Reach out to us on the discord if you have any questions
- Add tests (unit/integration)
- Commit with \*nix line endings for consistency (We checkout Windows and commit \*nix)
- One feature/bug fix per pull request to keep things clean and easy to understand
- Use 4 spaces instead of tabs, this is the default for VS 2022 and WebStorm

### <a href="#contributing-indexers" class="toc-anchor">¶</a> Contributing Indexers

### <a href="#c-indexers" class="toc-anchor">¶</a> C# Indexers

- C# Indexers are to be pull requested to the <a href="https://github.com/prowlarr/prowlarr" class="is-external-link">Prowlarr App Repository</a> against the `develop` branch
- If you're contributing a C# indexer please phrase your commit as something like: `New: (Indexer) {Indexer Name}`, `New: (Indexer) {Usenet|Torrent} {Indexer Name}`, `New: (Indexer) {Torznab|Newznab} {Indexer Name}`
- If you're updating a C# indexer please phrase your commit as something like: `Fixed: (Indexer) {Indexer Name} {changes}` e.g. `Fixed: (Indexer) Changed BHD to use API`

### <a href="#cardigann-yml-indexers" class="toc-anchor">¶</a> Cardigann (YML) Indexers

- Cardigann and YML Indexers are to be pull requested to the <a href="https://github.com/prowlarr/indexers" class="is-external-link">Prowlarr Indexer Repository</a> against the `master` branch
- For Cardigann/YML Indexers details please see <a href="/prowlarr/cardigann-yml-definition" class="is-internal-link is-valid-page">the definition and description of the Prowlarr Cardigann yml format</a>
- For testing custom yml definitions please see <a href="/prowlarr/indexers#adding-a-custom-yml-definition" class="is-internal-link is-valid-page">the custom yml section in the Indexer page</a>

## <a href="#pull-requesting" class="toc-anchor">¶</a> Pull Requesting

- Only make pull requests to `develop`, never `master`, if you make a PR to `master` we will comment on it and close it
- You're probably going to get some comments or questions from us, they will be to ensure consistency and maintainability
- We'll try to respond to pull requests as soon as possible, if its been a day or two, please reach out to us, we may have missed it
- Each PR should come from its own <a href="http://martinfowler.com/bliki/FeatureBranch.html" class="is-external-link">feature branch</a> not develop in your fork, it should have a meaningful branch name (what is being added/fixed)
  - `new-feature` (Good)
  - `fix-bug` (Good)
  - `patch` (Bad)
  - `develop` (Bad)
- Commits should be wrote as `New:` or `Fixed:` for changes that would not be considered a `maintenance release`

## <a href="#unit-testing" class="toc-anchor">¶</a> Unit Testing

Prowlarr utilizes nunit for its unit, integration, and automation test suite.

### <a href="#running-tests" class="toc-anchor">¶</a> Running Tests

Tests can be run easily from within VS using the included nunit3testadapter nuget package or from the command line using the included bash script `test.sh`.

From VS simply navigate to Test Explorer and run or debug the tests you'd like to examine.

Tests can be run all at once or one at a time in VS.

From command line the `test.sh` script accepts 3 parameters

``` prismjs
test.sh <PLATFORM> <TYPE> <COVERAGE>
```

### <a href="#writing-tests" class="toc-anchor">¶</a> Writing Tests

While not always fun, we encourage writing unit tests for any backend code changes. This will ensure the change is functioning as you intended and that future changes dont break the expected behavior.

> We currently require 80% coverage on new code when submitting a PR

If you have any questions about any of this, please let us know.

# <a href="#translation" class="toc-anchor">¶</a> Translation

Prowlarr uses a self hosted open access <a href="https://translate.servarr.com" class="is-external-link">Weblate</a> instance to manage its json translation files. These files are stored in the repo at `src/NzbDrone.Core/Localization`

## <a href="#contributing-to-an-existing-translation" class="toc-anchor">¶</a> Contributing to an Existing Translation

Weblate handles synchronization and translation of strings for all languages other than English. Editing of translated strings and translating existing strings for supported languages should be performed there for the Prowlarr project.

The English translation, `en.json`, serves as the source for all other translations and is managed on GitHub repo.

## <a href="#adding-a-language" class="toc-anchor">¶</a> Adding a Language

Adding translations to Prowlarr requires two steps

- Adding the Language to weblate
- Adding the Language to Prowlarr codebase

## <a href="#adding-translation-strings-in-code" class="toc-anchor">¶</a> Adding Translation Strings in Code

The English translation, `src/NzbDrone.Core/Localization/Core/en.json`, serves as the source for all other translations and is managed on GitHub repo. When adding a new string to either the UI or backend a key must also be added to `en.json` along with the default value in English. This key may then be consumed as follows:

> PRs for translation of log messages will not be accepted

### <a href="#backend-strings" class="toc-anchor">¶</a> Backend Strings

Backend strings may be added utilizing the Localization Service `GetLocalizedString` method

``` prismjs
private readonly ILocalizationService _localizationService;

public IndexerCheck(ILocalizationService localizationService)
{
  _localizationService = localizationService;
}

var translated = _localizationService.GetLocalizedString("IndexerHealthCheckNoIndexers")
```

### <a href="#frontend-strings" class="toc-anchor">¶</a> Frontend Strings

New strings can be added to the frontend by importing the translate function and using a key specified from `en.json`

``` prismjs
import translate from 'Utilities/String/translate';

  {translate('UnableToAddANewIndexerPleaseTryAgain')}
```


