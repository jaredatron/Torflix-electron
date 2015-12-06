require 'shouldhave/Array#includes'
require 'shouldhave/Array#remove'

Reactatron = require 'Reactatron'
formatBytes = require '../formatBytes'
Checkbox = require './Checkbox'

{div, progress} = Reactatron.DOM

module.exports = Reactatron.component 'TransfersList',

  propTypes:
    transfers:         Reactatron.PropTypes.array.isRequired
    selectedTransfers: Reactatron.PropTypes.array.isRequired

  render: ->
    div className: 'TransfersList', @renderTransfers()

  renderTransfers: ->
    return div(null, 'Loading...') if !this.props.transfers
    @props.transfers.map (transfer) =>
      Transfer
        key: transfer.id
        transfer: transfer
        selectedTransfers: @props.selectedTransfers

Transfer = Reactatron.component 'TransfersList-Transfer',

  propTypes:
    transfer: Reactatron.PropTypes.object.isRequired
    selectedTransfers: Reactatron.PropTypes.array.isRequired

  toggleSelection: ->
    @emit 'transfers:toggleSelection', @props.transfer

  render: ->
    transfer = @props.transfer
    selected = @props.selectedTransfers.includes(transfer.id)
    className = 'TransfersList-Transfer columns'
    if selected
      className = className+' TransfersList-Transfer-selected'

    div className: className, tabIndex:'0', onKeyDown: @onKeyDown,
      div className: 'padding-1',
        Checkbox
          tabIndex: '-1'
          checked: selected
          onChange: @toggleSelection
      div className: 'rows grow shrink padding-1',
        div null,
          transfer.name
          formatBytes(transfer.size)
        div null,
          progress max: 100, value: transfer.percent_done||0
        div null,
          transfer.status_message

