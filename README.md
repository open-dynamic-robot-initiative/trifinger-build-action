GitHub Actions for Building and Running Tests
=============================================

This repository contains a number of GitHub Actions that can be used in
workflows to build and run unit tests using colcon in an Apptainer container.

Default arguments are taylored for the TriFinger packages but by setting custom
values the actions can also be used for other projects using the same package
structure.

Provided actions are:

- **setup_apptainer**: Install Apptainer and pull an image (so it can be used in
  following steps).
- **build**: Build the package using `colon build`.
- **build_and_deploy_docs**: Build documentation using [breathing
  cat](https://github.com/machines-in-motion/breathing-cat) (assumed to be
  installed in the Apptainer image!) and deploys to GitHub Pages using
  `actions/deploy-pages`.
- **run_tests**: Run unit tests using `colon test`.


Usage Example
-------------

A usage example using all steps (you may, of course, omit some of the steps,
e.g. to not build/deploy documentation in pull requests):

```
name: Build and Test
on:
  push:
    branches:
     - master

jobs:
  build_and_test:
    runs-on: ubuntu-20.04

    # permissions and environment are only needed for the build_and_deploy_docs
    # action.
    permissions:
      pages: write      # to deploy to Pages
      id-token: write   # to verify the deployment originates from an appropriate source
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      - name: Check out code
        uses: actions/checkout@v3

      - name: Setup Apptainer
        uses: open-dynamic-robot-initiative/trifinger-build-action/setup_apptainer@v2

      - name: Build
        uses: open-dynamic-robot-initiative/trifinger-build-action/build@v2

      - name: Documentation
        uses: open-dynamic-robot-initiative/trifinger-build-action/build_and_deploy_docs@v2

      - name: Tests
        uses: open-dynamic-robot-initiative/trifinger-build-action/run_tests@v2
```


Actions
-------

### setup_apptainer

Installs Apptainer and pulls an image into the workspace.

Important: Call this action _after_ `actions/checkout`, as the latter will clean
the workspace and would thus delete an image pulled earlier.

Inputs:
- apptainer_version (default: 1.1.2):  Version of Apptainer.  Has to match a
  release on the [Apptainer repository](https://github.com/apptainer/apptainer/releases).
- uri (default: latest trifinger_user image):  URI to pull the container from
  (as it is used by `apptainer pull`).
- output_file (default: container.sif):  Name of the image that is written.


### build

Build the package using `colon build` inside the Apptainer image.

Important: Uses `apptainer run <image>.sif colon build`, i.e. the image must
have a run script that sets up the environment as needed and then executes the
given command.

Inputs:
- container (default: container.sif):  Name of the Apptainer image.


### run_tests

Run tests of the package using `colon test` inside the Apptainer image.

Important: Uses `apptainer run <image>.sif colon test`, i.e. the image must
have a run script that sets up the environment as needed and then executes the
given command.

Inputs:
- container (default: container.sif):  Name of the Apptainer image.


### build_and_deploy_docs

Build documentation using [breathing
cat](https://github.com/machines-in-motion/breathing-cat) inside the Apptainer
image and deploys to GitHub Pages using
[actions/deploy-pages](github.com/actions/deploy-pages).

Important: Uses `apptainer run <image>.sif bcat ...`, i.e. the image must
have a run script that sets up the environment as needed and then executes the
given command.  Further breathing cat needs to be installed in the container.

Inputs:
- container (default: container.sif):  Name of the Apptainer image.
- build_dir (default: docbuild):  Directory to which build files are written.
