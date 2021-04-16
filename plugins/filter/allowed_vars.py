# Filter a list based on allowed/denied keys.
# @todo Refactor. Sorry about the nesting, I can't Python.


def allowed_vars(original, policies):
    filtered = {}
    for orig_key, orig_value in original.items():
        for allowed in policies:
            if allowed['name'] == orig_key:
                if allowed.get('allow'):
                    for allow in allowed['allow']:
                        filtered[orig_key] = orig_value
    return filtered


class FilterModule(object):
    def filters(self):
        return {
            'allowed_vars': allowed_vars
        }
