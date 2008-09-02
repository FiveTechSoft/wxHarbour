#
#(C) 2008 WindTelSoft de Mexico
#

import utils

def addSufixToList(sufix, value):
    """Adds sufix to every item in 'value' interpreted as
       whitespace-separated list."""

    def callback(sufix, cond, sources):
        prf = suf = ''
        if sources[0].isspace(): prf=' '
        if sources[-1].isspace(): suf=' '
        retval = []
        for s in sources.split():
            retval.append(s+sufix)
        return '%s%s%s' % (prf, ' '.join(retval), suf)
    return utils.substitute2(value, lambda c,s: callback(sufix,c,s))
