# Filter a list based on allowed/denied keys.
# @todo Refactor. Sorry about the nesting, I can't Python.


def allowed_vars(original, policies):
    filtered = {}
    for orig_key, orig_value in original.items():
        for allowed in policies:
            if allowed['name'] == orig_key:
                if allowed.get('allow'):
                    filtered[orig_key] = {}
                    for allow in allowed['allow']:
                        if allow in orig_value:
                            filtered[orig_key][allow] = orig_value.get(allow)
    return filtered


class FilterModule(object):
    def filters(self):
        return {
            'allowed_vars': allowed_vars
        }
