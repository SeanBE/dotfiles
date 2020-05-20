# -*- coding: utf-8 -*-
#
# Copyright (C) 2011-2015 SÃ©bastien Helleu <flashcode@flashtux.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#
# WeeChat theme manager.
# (this script requires WeeChat 0.3.7 or newer)
#
# History:
#
# 2015-07-13, SÃ©bastien Helleu <flashcode@flashtux.org>:
#     version 0.1: dev snapshot
# 2011-02-22, SÃ©bastien Helleu <flashcode@flashtux.org>:
#     start dev
#

SCRIPT_NAME = 'theme'
SCRIPT_AUTHOR = 'SÃ©bastien Helleu <flashcode@flashtux.org>'
SCRIPT_VERSION = '0.1-dev'
SCRIPT_LICENSE = 'GPL3'
SCRIPT_DESC = 'WeeChat theme manager'

SCRIPT_COMMAND = 'theme'

import_weechat_ok = True
import_other_ok = True

try:
    import weechat
except ImportError:
    import_weechat_ok = False

try:
    import sys
    import os
    import re
    import datetime
    import time
    import html
    import tarfile
    import traceback
    import xml.dom.minidom
except ImportError as e:
    print('Missing package(s) for {0}: {1}'.format(SCRIPT_NAME, e))
    import_other_ok = False

THEME_CONFIG_FILENAME = 'theme'

THEME_URL = 'https://weechat.org/files/themes.tar.bz2'

# color attributes (in weechat color options)
COLOR_ATTRIBUTES = ('*', '_', '/', '!')

# timeout for download of themes.tar.bz2
TIMEOUT_UPDATE = 120 * 1000

# hook process and stdout
theme_hook_process = ''
theme_stdout = ''

# config file and options
theme_cfg_file = ''
theme_cfg = {}

theme_bars = 'input|nicklist|status|title'
theme_plugins = 'weechat|alias|spell|charset|fifo|irc|logger|relay|'\
    'rmodifier|xfer'

theme_options_include_re = (
    r'^weechat\.bar\.({0})\.color.*'.format(theme_bars),
    r'^weechat\.look\.buffer_time_format$',
    r'^({0})\.color\..*'.format(theme_plugins),
    r'^({0})\.look\..*color.*'.format(theme_plugins),
)

theme_options_exclude_re = (
    r'^weechat.look.color_pairs_auto_reset$',
    r'^weechat.look.color_real_white$',
    r'^weechat.look.color_basic_force_bold$',
    r'^irc\.look\.',
)


def new_section(cfg, name):
    # https://weechat.org/files/doc/stable/weechat_plugin_api.en.html#_config_new_section
    return weechat.config_new_section(
        cfg, name, 0, 0, '', '', '', '', '', '', '', '', '', '')


def new_color_option(cfg, section, name, desc, default):
    # https://weechat.org/files/doc/stable/weechat_plugin_api.en.html#_config_new_option
    return weechat.config_new_option(
        cfg, section, name, 'color', desc, '', 0, 0,
        default, default, 0, '', '', '', '', '', '')

# =================================[ config ]=================================


def theme_config_init():
    """Initialization of configuration file. Sections: color, themes."""
    global theme_cfg_file, theme_cfg
    theme_cfg_file = weechat.config_new(THEME_CONFIG_FILENAME,
                                        'theme_config_reload_cb', '')

    # section "color"
    section = new_section(theme_cfg_file, 'color')
    theme_cfg['color_script'] = new_color_option(
        theme_cfg_file, section, 'script', 'Color for script names', 'cyan')

    theme_cfg['color_script'] = weechat.config_new_option(
        theme_cfg_file, section, 'script', 'color',
        'Color for script names', '', 0, 0,
        'cyan', 'cyan', 0, '', '', '', '', '', '')
    theme_cfg['color_installed'] = weechat.config_new_option(
        theme_cfg_file, section, 'installed', 'color',
        'Color for "installed" indicator', '', 0, 0,
        'yellow', 'yellow', 0, '', '', '', '', '', '')
    theme_cfg['color_running'] = weechat.config_new_option(
        theme_cfg_file, section, 'running', 'color',
        'Color for "running" indicator', '', 0, 0,
        'lightgreen', 'lightgreen', 0, '', '', '', '', '', '')
    theme_cfg['color_obsolete'] = weechat.config_new_option(
        theme_cfg_file, section, 'obsolete', 'color',
        'Color for "obsolete" indicator', '', 0, 0,
        'lightmagenta', 'lightmagenta', 0, '', '', '', '', '', '')
    theme_cfg['color_unknown'] = weechat.config_new_option(
        theme_cfg_file, section, 'unknown', 'color',
        'Color for "unknown status" indicator', '', 0, 0,
        'lightred', 'lightred', 0, '', '', '', '', '', '')
    theme_cfg['color_language'] = weechat.config_new_option(
        theme_cfg_file, section, 'language', 'color',
        'Color for language names', '', 0, 0,
        'lightblue', 'lightblue', 0, '', '', '', '', '', '')

    # section "themes"
    section = weechat.config_new_section(
        theme_cfg_file, 'themes', 0, 0,
        '', '', '', '', '', '', '', '', '', '')
    theme_cfg['themes_url'] = weechat.config_new_option(
        theme_cfg_file, section,
        'url', 'string', 'URL for file with themes (.tar.bz2 file)', '', 0, 0,
        THEME_URL, THEME_URL, 0, '', '', '', '', '', '')
    theme_cfg['themes_cache_expire'] = weechat.config_new_option(
        theme_cfg_file, section,
        'cache_expire', 'integer', 'Local cache expiration time, in minutes '
        '(-1 = never expires, 0 = always expires)', '',
        -1, 60 * 24 * 365, '60', '60', 0, '', '', '', '', '', '')
    theme_cfg['themes_dir'] = weechat.config_new_option(
        theme_cfg_file, section,
        'dir', 'string', 'Local directory for themes', '', 0, 0,
        '%h/themes', '%h/themes', 0, '', '', '', '', '', '')


def theme_config_reload_cb(data, config_file):
    """Reload configuration file."""
    return weechat.config_read(config_file)


def theme_config_read():
    """Read configuration file."""
    return weechat.config_read(theme_cfg_file)


def theme_config_write():
    """Write configuration file."""
    return weechat.config_write(theme_cfg_file)


def theme_config_color(color):
    """Get a color from configuration."""
    option = theme_cfg.get('color_' + color, '')
    if not option:
        return ''
    return weechat.color(weechat.config_string(option))


def theme_config_get_dir():
    """Return themes directory, with expanded WeeChat home dir."""
    return weechat.config_string(
        theme_cfg['themes_dir']).replace('%h',
                                         weechat.info_get('weechat_dir', ''))


def theme_config_get_backup():
    """
    Return name of backup theme
    (by default "~/.weechat/themes/_backup.theme").
    """
    return theme_config_get_dir() + '/_backup.theme'


def theme_config_get_undo():
    """
    Return name of undo file
    (by default "~/.weechat/themes/_undo.theme").
    """
    return theme_config_get_dir() + '/_undo.theme'


def theme_config_create_dir():
    """Create "themes" directory."""
    directory = theme_config_get_dir()
    if not os.path.isdir(directory):
        os.makedirs(directory, mode=0o700)


# =================================[ themes ]=================================


class Theme:

    def __init__(self, filename=None):
        self.filename = filename
        self.props = {}
        self.listprops = []
        self.options = {}
        self.theme_ok = True
        if self.filename:
            self.theme_ok = self.load(self.filename)
        else:
            self.init_weechat()
        self.nick_prefixes = self._get_nick_prefixes()

    def isok(self):
        return self.theme_ok

    def _option_is_used(self, option):
        global theme_options_include_re, theme_options_exclude_re
        for regex in theme_options_exclude_re:
            if re.search(regex, option):
                return False
        for regex in theme_options_include_re:
            if re.search(regex, option):
                return True
        return False

    def _get_nick_prefixes(self):
        """Get dict with nick prefixes."""
        prefixes = {}
        nick_prefixes = self.options.get('irc.color.nick_prefixes', '')
        for prefix in nick_prefixes.split(';'):
            values = prefix.split(':', 1)
            if len(values) == 2:
                prefixes[values[0]] = values[1]
        return prefixes

    def _get_attr_color(self, color):
        """Return tuple with attributes and color."""
        m = re.match('([*_!]*)(.*)', color)
        if m:
            return m.group(1), m.group(2)
        return '', color

    def _get_color_without_alias(self, color):
        """
        Return color without alias (color can be "fg", "fg,bg" or "fg:bg").
        """
        pos = color.find(',')
        if pos < 0:
            pos = color.find(':')
        if pos > 0:
            fg = color[0:pos]
            bg = color[pos + 1:]
        else:
            fg = color
            bg = ''
        attr, col = self._get_attr_color(fg)
        fg = attr + self.palette.get(col, col)
        attr, col = self._get_attr_color(bg)
        bg = attr + self.palette.get(col, col)
        if bg:
            return fg + color[pos:pos + 1] + bg
        return fg

    def _replace_color_alias(self, match):
        value = match.group()[8:-1]
        if value in self.palette:
            value = self.palette[value]
        return '${color:' + value + '}'

    def init_weechat(self):
        """
        Initialize theme using current WeeChat options (aliases are
        replaced with their values from palette).
        """
        # get palette options
        self.palette = {}
        infolist = weechat.infolist_get('option', '', 'weechat.palette.*')
        while weechat.infolist_next(infolist):
            option_name = weechat.infolist_string(infolist, 'option_name')
            value = weechat.infolist_string(infolist, 'value')
            self.palette[value] = option_name
        weechat.infolist_free(infolist)
        # get color options (replace aliases by values from palette)
        self.options = {}
        infolist = weechat.infolist_get('option', '', '')
        while weechat.infolist_next(infolist):
            full_name = weechat.infolist_string(infolist, 'full_name')
            if self._option_is_used(full_name):
                value = weechat.infolist_string(infolist, 'value')
                self.options[full_name] = self._get_color_without_alias(value)
        weechat.infolist_free(infolist)
        # replace aliases in chat_nick_colors
        option = 'weechat.color.chat_nick_colors'
        colors = []
        for color in self.options.get(option, '').split(','):
            colors.append(self._get_color_without_alias(color))
        if colors:
            self.options[option] = ','.join(colors)
        # replace aliases in buffer_time_format
        option = 'weechat.look.buffer_time_format'
        if option in self.options:
            value = re.compile(r'\$\{color:[^\}]+\}').sub(
                self._replace_color_alias, self.options[option])
            if value:
                self.options[option] = value
        # build dict with nick prefixes (and replace alisases)
        prefixes = []
        option = 'irc.color.nick_prefixes'
        for prefix in self.options.get(option, '').split(';'):
            values = prefix.split(':', 1)
            if len(values) == 2:
                prefixes.append(values[0] + ':' +
                                self._get_color_without_alias(values[1]))
        if prefixes:
            self.options[option] = ';'.join(prefixes)
        # delete palette
        del self.palette

    def prnt(self, message):
        try:
            weechat.prnt('', message)
        except:
            print(message)

    def prnt_error(self, message):
        try:
            weechat.prnt('', weechat.prefix('error') + message)
        except:
            print(message)

    def load(self, filename):
        self.options = {}
        try:
            lines = open(filename, 'rb').readlines()
            for line in lines:
                line = str(line.strip().decode('utf-8'))
                if line.startswith('#'):
                    m = re.match('^# \\$([A-Za-z]+): (.*)', line)
                    if m:
                        self.props[m.group(1)] = m.group(2)
                        self.listprops.append(m.group(1))
                else:
                    items = line.split('=', 1)
                    if len(items) == 2:
                        value = items[1].strip()
                        if value.startswith('"') and value.endswith('"'):
                            value = value[1:-1]
                        self.options[items[0].strip()] = value
            return True
        except:
            self.prnt('Error loading theme "{0}"'.format(filename))
            return False

    def save(self, filename):
        names = sorted(self.options)
        try:
            f = open(filename, 'w')
            version = weechat.info_get('version', '')
            pos = version.find('-')
            if pos > 0:
                version = version[0:pos]
            header = ('#',
                      '# -- WeeChat theme --',
                      '# $name: {0}'.format(os.path.basename(filename)),
                      '# $date: {0}'.format(datetime.date.today()),
                      '# $weechat: {0}'.format(version),
                      '# $script: {0}.py {1}'.format(SCRIPT_NAME,
                                                     SCRIPT_VERSION),
                      '#\n')
            f.write('\n'.join(header))
            for option in names:
                f.write('{0} = "{1}"\n'.format(option, self.options[option]))
            f.close()
            self.prnt('Theme saved to "{0}"'.format(filename))
        except:
            self.prnt_error('Error writing theme to "{0}"'.format(filename))
            raise

    def show(self, header):
        """Display content of theme."""
        names = sorted(self.options)
        self.prnt('')
        self.prnt(header)
        for name in names:
            self.prnt('  {0} {1}= {2}{3}'
                      ''.format(name,
                                weechat.color('chat_delimiters'),
                                weechat.color('chat_value'),
                                self.options[name]))

    def info(self, header):
        """Display info about theme."""
        self.prnt('')
        self.prnt(header)
        for prop in self.listprops:
            self.prnt('  {0}: {1}{2}'
                      ''.format(prop,
                                weechat.color('chat_value'),
                                self.props[prop]))
        numerrors = 0
        for name in self.options:
            if not weechat.config_get(name):
                numerrors += 1
        if numerrors == 0:
            text = 'all OK'
        else:
            text = ('WARNING: {0} option(s) not found in your WeeChat'
                    ''.format(numerrors))
        self.prnt('  options: {0}{1}{2} ({3})'
                  ''.format(weechat.color('chat_value'),
                            len(self.options),
                            weechat.color('reset'),
                            text))

    def install(self):
        try:
            numset = 0
            numerrors = 0
            for name in self.options:
                option = weechat.config_get(name)
                if option:
                    rc = weechat.config_option_set(option,
                                                   self.options[name], 1)
                    if rc == weechat.WEECHAT_CONFIG_OPTION_SET_ERROR:
                        self.prnt_error('Error setting option "{0}" to value '
                                        '"{1}" (running an old WeeChat?)'
                                        ''.format(name, self.options[name]))
                        numerrors += 1
                    else:
                        numset += 1
                else:
                    self.prnt('Warning: option not found: "{0}" '
                              '(running an old WeeChat?)'.format(name))
                    numerrors += 1
            errors = ''
            if numerrors > 0:
                errors = ', {0} error(s)'.format(numerrors)
            if self.filename:
                self.prnt('Theme "{0}" installed ({1} options set{2})'
                          ''.format(self.filename, numset, errors))
            else:
                self.prnt('Theme installed ({0} options set{1})'
                          ''.format(numset, errors))
        except:
            if self.filename:
                self.prnt_error('Failed to install theme "{0}"'
                                ''.format(self.filename))
            else:
                self.prnt_error('Failed to install theme')

    def nick_prefix_color(self, prefix):
        """Get color for a nick prefix."""
        modes = 'qaohv'
        prefixes = '~&@%+'
        pos = prefixes.find(prefix)
        if pos < 0:
            return ''
        while pos < len(modes):
            if modes[pos] in self.nick_prefixes:
                return self.nick_prefixes[modes[pos]]
            pos += 1
        return self.nick_prefixes.get('*', '')


# ================================[ command ]=================================


def theme_cmd(data, buffer, args):
    """Callback for /theme command."""
    if args == '':
        weechat.command('', '/help ' + SCRIPT_COMMAND)
        return weechat.WEECHAT_RC_OK
    argv = args.strip().split(' ', 1)
    if len(argv) == 0:
        return weechat.WEECHAT_RC_OK

    if argv[0] in ('install',):
        weechat.prnt('',
                     '{0}: action "{1}" not developed'
                     ''.format(SCRIPT_NAME, argv[0]))
        return weechat.WEECHAT_RC_OK

    # check arguments
    if len(argv) < 2:
        if argv[0] in ('install', 'installfile', 'save'):
            weechat.prnt('',
                         '{0}: too few arguments for action "{1}"'
                         ''.format(SCRIPT_NAME, argv[0]))
            return weechat.WEECHAT_RC_OK

    # execute asked action
    if argv[0] == 'info':
        filename = None
        if len(argv) >= 2:
            filename = argv[1]
        theme = Theme(filename)
        if filename:
            theme.info('Info about theme "{0}":'.format(filename))
        else:
            theme.info('Info about current theme:')
    elif argv[0] == 'show':
        filename = None
        if len(argv) >= 2:
            filename = argv[1]
        theme = Theme(filename)
        if filename:
            theme.show('Content of theme "{0}":'.format(filename))
        else:
            theme.show('Content of current theme:')
    elif argv[0] == 'installfile':
        theme = Theme()
        theme.save(theme_config_get_undo())
        theme = Theme(argv[1])
        if theme.isok():
            theme.install()
    elif argv[0] == 'undo':
        theme = Theme(theme_config_get_undo())
        if theme.isok():
            theme.install()
    elif argv[0] == 'save':
        theme = Theme()
        theme.save(argv[1])
    elif argv[0] == 'backup':
        theme = Theme()
        theme.save(theme_config_get_backup())
    elif argv[0] == 'restore':
        theme = Theme(theme_config_get_backup())
        if theme.isok():
            theme.install()

    return weechat.WEECHAT_RC_OK


# ==================================[ main ]==================================


def theme_init():
    """Called when script is loaded."""
    theme_config_create_dir()
    filename = theme_config_get_backup()
    if not os.path.isfile(filename):
        theme = Theme()
        theme.save(filename)


def main_weechat():
    """Main function, called only in WeeChat."""
    if not weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                            SCRIPT_LICENSE, SCRIPT_DESC, '', ''):
        return
    
    theme_config_init()
    theme_config_read()
    theme_init()
    weechat.hook_command(
        SCRIPT_COMMAND,
        'WeeChat theme manager',
        'info|show [<theme>] || install <theme>'
        ' || installfile <file> || update || undo || backup || save <file>'
        ' || restore',
        '       info: show info about theme (without argument: for current '
        'theme)\n'
        '       show: show all options in theme (without argument: for '
        'current theme)\n'
        '    install: install a theme from repository\n'
        'installfile: load theme from a file\n'
        '     update: download and unpack themes in themes directory\n'
        '       undo: undo last theme install\n'
        '     backup: backup current theme (by default in '
        '~/.weechat/themes/_backup.theme); this is done the first time script '
        'is loaded\n'
        '       save: save current theme in a file\n'
        '    restore: restore theme backuped by script\n\n'
        'Examples:\n'
        '  /' + SCRIPT_COMMAND + ' save /tmp/flashcode.theme => save current '
        'theme',
        'info %(filename)'
        ' || show %(filename)'
        ' || install %(themes)'
        ' || installfile %(filename)'
        ' || undo'
        ' || save %(filename)'
        ' || backup'
        ' || restore',
        'theme_cmd', '')


def theme_usage():
    """Display usage."""
    padding = ' ' * len(sys.argv[0])
    print('')
    print('Usage:  {0}  --info <filename>'.format(padding))
    print('        {0}  --help'.format(padding))
    print('')
    print('  -i, --info    display info about a theme')
    print('  -h, --help    display this help')
    print('')
    sys.exit(0)


def main_cmdline():
    """Main function, called only outside WeeChat."""
    if len(sys.argv) < 2 or sys.argv[1] in ('-h', '--help'):
        theme_usage()
    elif len(sys.argv) > 1:
        if sys.argv[1] in ('-i', '--info'):
            if len(sys.argv) < 3:
                theme_usage()
            theme = Theme(sys.argv[2])
            theme.info('Info about theme "{0}":'.format(sys.argv[2]))
        else:
            theme_usage()


if __name__ == '__main__' and import_other_ok:
    if import_weechat_ok:
        main_weechat()
    else:
        main_cmdline()
