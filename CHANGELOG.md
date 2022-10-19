# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Change default name of container to "container.sif" (both in output of the
  setup_apptainer action and in the input of the others).  This means that no
  further changes from the defaults are needed when using a different container
  in setup_apptainer's "uri" input.


## [1.0.0] - 2022-10-11

First version.


[Unreleased]: https://github.com/open-dynamic-robot-initiative/trifinger-build-action/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/open-dynamic-robot-initiative/trifinger-build-action/releases/tag/v1.0.0
