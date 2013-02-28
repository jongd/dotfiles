import os
from fnmatch import fnmatch
import sublime
import sublime_plugin


class DetectFileTypeCommand(sublime_plugin.EventListener):
    """
        Detects current file type if the file's extension isn't
        Modified for Ruby on Rails and Sublime Text 2 Original pastie
        here: http://pastie.org/private/kz8gtts0cjcvkec0d4quqa

        Place in your Packages/User directory.
    """

    def on_load(self, view):
        filename = view.file_name()
        if not filename:  # buffer has never been saved
            return

        try:
            name = os.path.basename(filename.lower())
            if fnmatch(name, "*_spec.rb"):
                set_syntax(view, "RSpec", "rspec/Syntaxes")
            elif name == "factories.rb":
                set_syntax(view, "RSpec", "rspec/Syntaxes")
            elif name == "gemfile":
                set_syntax(view, "Ruby on Rails", "Rails")
            elif name == "guardfile":
                set_syntax(view, "Ruby on Rails", "Rails")
            elif name == "config.ru":
                set_syntax(view, "Ruby on Rails", "Rails")
            elif fnmatch(name, "*.rb"):
                set_syntax(view, "Ruby on Rails", "Rails")
            elif fnmatch(name, "*.jbuilder"):
                set_syntax(view, "Ruby on Rails", "Rails")
            elif fnmatch(name, "*.rabl"):
                set_syntax(view, "Ruby on Rails", "Rails")
            elif fnmatch(name, "*.kitsch"):
                set_syntax(view, "Ruby on Rails", "Rails")
            elif fnmatch(name, "*_spec.js"):
                set_syntax(view, "Jasmine", "Jasmine/Syntaxes")
            elif fnmatch(name, "jakefile"):
                set_syntax(view, "JavaScript", "JavaScript")
        except:
            print "There was an error changing syntax."


def set_syntax(view, syntax, path=None):
    if path is None:
        path = syntax
    view.settings().set('syntax', 'Packages/' + path + '/' + syntax +
    '.tmLanguage')
    print "Switched syntax to: " + syntax
