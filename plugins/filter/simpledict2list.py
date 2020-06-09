# Transform a dict into a list.
# @todo Can't believe there's not already a filter for that, need to search again.


def simpledict2list(original):
    new_list = []
    for orig_key, orig_value in original.items():
        new_list.append({orig_key: orig_value})
    return new_list


class FilterModule(object):
    def filters(self):
        return {
            'simpledict2list': simpledict2list
        }
