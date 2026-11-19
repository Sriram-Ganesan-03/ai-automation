class VersionLocators:
    """Simple resolver that keeps locator maps version-aware when needed."""

    def __init__(self):
        self._default = {}

    def resolve(self, locator_map, app_version=None):
        if not locator_map:
            return {}
        if app_version is None:
            return locator_map
        key = str(app_version)
        return locator_map.get(key, locator_map.get("default", locator_map))
