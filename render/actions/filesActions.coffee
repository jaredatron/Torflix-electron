module.exports = (App) ->

  App.state.files = JSON.parse(localStorage.files||null)

  App.loadFiles = ->
    App.state.files or App.reloadFiles()

  App.reloadFiles = ->
    # App.putio.allFiles().then (files) ->
    # App.putio.directoryContents(0).then ({files}) ->
    App.putio.reloadAllFiles (files) ->
      linkFiles(files)
      localStorage.files = JSON.stringify(files)
      App.setState files: files

  App.on 'login', ({token}) ->
    App.loadTransfers()

  App.on 'reloadFiles', ->
    App.setState files: null
    App.reloadFiles()



linkFiles = (files) ->
  filesById = {}
  filesById[file.id] = file for file in files
  for file in files
    file.parent_directory = filesById[file.parent_id]
