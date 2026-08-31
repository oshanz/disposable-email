# Changelog

## [v0.5.7] - 2026-08-31

### Fixed
- download_blocklist/0 doesn't check HTTP status #30
- non-200 responses silently corrupt the blocklist #30

## [v0.5.6] - 2026-08-17

### Changed
- Update disposable email blocklist.
- Replace ETS lookup with `member?`.

## [v0.5.5] - 2026-06-21

### Changed
- Update disposable email blocklist.

### Fixed
- Warnings on invalid domains.

## [v0.5.4] - 2026-05-22

### Changed
- Update disposable email blocklist.

### Fixed
- Warnings on invalid domains.

## [v0.5.3] - 2026-05-16

### Changed
- Update disposable email blocklist.

### Fixed
- Zizmor warnings.

## [v0.5.2] - 2026-04-26

### Changed
- Update disposable email blocklist.

## [v0.5.1] - 2026-03-08

### Added
- Weekly blocklist update automation.
- GitHub Action for publishing to Hex.pm.

### Changed
- Update disposable email blocklist.

### Fixed
- Compilation warnings.

## [v0.5.0] - 2026-02-01

### Changed
- Update minimum supported version requirements.

## [0.4.2] - 2026-01-28

### Changed
- Update disposable email blocklist.

## [v0.4.1] - 2025-12-17

### Changed
- Maintenance updates and synchronization.

## [v0.4.0] - 2025-12-16

### Fixed
- Error when blocklist was missing.

## [v0.3.0] - 2025-12-16

### Fixed
- SSL certificate error.

## [v0.2.0] - 2025-12-16

### Deprecated
- `is_disposable?/1` has been deprecated; use `disposable?/1` instead.

## [v0.1.0] - 2025-12-09

- Initial release.
