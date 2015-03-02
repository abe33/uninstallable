UninstallableView = require './uninstallable-view'
{CompositeDisposable} = require 'atom'

module.exports = Uninstallable =
  uninstallableView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @uninstallableView = new UninstallableView(state.uninstallableViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @uninstallableView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'uninstallable:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @uninstallableView.destroy()

  serialize: ->
    uninstallableViewState: @uninstallableView.serialize()

  toggle: ->
    console.log 'Uninstallable was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
