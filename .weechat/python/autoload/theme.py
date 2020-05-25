# Adapted from SÃ©bastien Helleu <flashcode@flashtux.org> theme.py.
# This script simply installs weechat_dir/current.theme at startup.
# If you use this, make sure to version control because there is no undo.

import os
import re
import weechat

SCRIPT_LICENSE = 'GPL3'
SCRIPT_AUTHOR = 'seanBE'
SCRIPT_NAME = 'themeloader'
SCRIPT_VERSION = '0.0.1-dev'
SCRIPT_DESC = 'WeeChat theme loader'

def prnt(msg):
    try:
        weechat.prnt('', msg)
    except:
        print(msg)


def prnt_error(msg):
    try:
        weechat.prnt('', weechat.prefix('error') + msg)
    except:
        print(msg)


def load_theme(filename):
    props = {}
    listprops = []
    options = {}
    lines = open(filename, 'rb').readlines()
    for line in lines:
        line = str(line.strip().decode('utf-8'))
        if line.startswith('#'):
            m = re.match('^# \\$([A-Za-z]+): (.*)', line)
            if m:
                props[m.group(1)] = m.group(2)
                listprops.append(m.group(1))
        else:
            items = line.split('=', 1)
            if len(items) == 2:
                value = items[1].strip()
                if value.startswith('"') and value.endswith('"'):
                    value = value[1:-1]
                options[items[0].strip()] = value
    return props, listprops, options
    

def install_theme(filename):
    numset = 0
    numerrors = 0
    props, listprops, options = load_theme(filename)
    for name in options:
        option = weechat.config_get(name)
        if option:
            rc = weechat.config_option_set(option, options[name], 1)
            if rc == weechat.WEECHAT_CONFIG_OPTION_SET_ERROR:
                prnt_error(
                    'Error setting option "{0}" to value '
                    '"{1}" (running an old WeeChat?)'
                    ''.format(name, options[name])
                )
                numerrors += 1
            else:
                numset += 1
        else:
            prnt(
                'Warning: option not found: "{0}" '
                '(running an old WeeChat?)'.format(name)
            )
            numerrors += 1
    errors = ', {0} error(s)'.format(numerrors) if numerrors > 0 else ''
    prnt(
        'Theme installed ({0} options set{1})' ''.format(numset, errors)
    )


if __name__ == '__main__':
    if weechat.register(
            SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
            SCRIPT_LICENSE, SCRIPT_DESC, '', ''
    ):
        filename = weechat.info_get('weechat_dir', '') + '/current.theme'
        if not os.path.isfile(filename):
            prnt_error('Error finding current.theme')
        else:
            try:
                install_theme(filename)
            except Exception:
                prnt_error('Failed to install theme')
