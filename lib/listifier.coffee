{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'listifier:sql-listify': => @sqlListify()

    @subscriptions.add atom.commands.add 'atom-workspace',
      'listifier:json-listify': => @jsonListify()

  deactivate: ->
    @subscriptions.dispose

  listify: (input, tags = {start: '(', end: ')'}) ->
      list = input.trim().split('\r\n')
      stringified = list.join('","')
      listified = "#{tags.start}\"#{stringified}\"#{tags.end}"

  sqlListify: ->
    tags =
      start: '('
      end: ')'
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      listified = @listify selection, tags
      editor.insertText listified

  jsonListify: ->
    tags =
      start: '['
      end: ']'
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      listified = @listify selection, tags
      editor.insertText listified
