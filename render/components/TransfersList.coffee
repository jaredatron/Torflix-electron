Reactatron = require 'Reactatron'
formatBytes = require '../formatBytes'
Checkbox = require './Checkbox'

{div, progress} = Reactatron.DOM

module.exports = Reactatron.component 'TransfersList',

  propTypes:
    transfers: Reactatron.PropTypes.array

  render: ->
    div className: 'TransfersList rows',
      if !this.props.transfers
        div(null, 'Loading...')
      else
        @props.transfers.map (transfer) ->
          Transfer(Object.assign({key: transfer.id}, transfer))


Transfer = Reactatron.component 'TransfersList-Transfer',

  propTypes:
    name: Reactatron.PropTypes.string.isRequired
    size: Reactatron.PropTypes.number.isRequired

  render: ->
    div className: 'TransfersList-Transfer columns',
      div className: 'padding-1',
        Checkbox checked: false
      div className: 'rows grow shrink padding-1',
        div null,
          @props.name
          formatBytes(@props.size)
        div null,
          progress value: @props.percent_done, max: 100
        div null,
          @props.status_message
      div className: 'padding-1', 'DELETE'
