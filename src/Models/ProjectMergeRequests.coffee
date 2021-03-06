BaseModel = require '../BaseModel'
Utils = require '../Utils'

class ProjectMergeRequests extends BaseModel
  list: (projectId, params={}, fn = null) =>
    if 'function' is typeof params
      fn = params
      params={}

    params.page ?= 1
    params.per_page ?= 100

    @debug "Projects::mergerequests()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_requests", params, (data) => fn data if fn

  show: (projectId, mergerequestId, fn = null) =>
    @debug "Projects::mergerequest()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_request/#{parseInt mergerequestId}", (data) => fn data if fn

  changes: (projectId, mergerequestId, fn = null) =>
    @debug "Projects:changesMergeRequest()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_request/" +
      "#{parseInt mergerequestId}/changes", (data) -> fn data if fn

  versions: (projectId, mergerequestId, fn = null) =>
    @debug "Projects:getAllVersionsMergeRequest()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_requests/" +
      "#{parseInt mergerequestId}/versions", (data) -> fn data if fn

  version: (projectId, mergerequestId, versionId, fn = null) =>
    @debug "Projects:getVersionMergeRequest()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_requests/" +
      "#{parseInt mergerequestId}/versions/#{parseInt versionId}",
      (data) -> fn data if fn

  add: (projectId, sourceBranch, targetBranch, assigneeId, title, fn = null) =>
    @debug "Projects::addMergeRequest()"
    params =
      id:            Utils.parseProjectId projectId
      source_branch: sourceBranch
      target_branch: targetBranch
      title:         title
    params.assigneeId = parseInt assigneeId unless assigneeId is undefined
    @post "projects/#{Utils.parseProjectId projectId}/merge_requests", params, (data) => fn data if fn

  update: (projectId, mergerequestId, params, fn = null) =>
    @debug "Projects::saveMergeRequest()"

    params.id = Utils.parseProjectId projectId;
    params.merge_request_id = parseInt mergerequestId;

    @put "projects/#{Utils.parseProjectId projectId}/merge_request/#{parseInt mergerequestId}", params, (data) => fn data if fn

  comment: (projectId, mergerequestId, note, fn = null) =>
    @debug "Projects::commentMergeRequest()"
    params =
      id:               Utils.parseProjectId projectId
      merge_request_id: parseInt mergerequestId
      note:             note
    @post "projects/#{Utils.parseProjectId projectId}/merge_request/#{parseInt mergerequestId}/comments", params, (data) => fn data if fn

  getNotes: (projectId, mergerequestId, fn = null) =>
    @debug "Projects::getMergeRequestNotes()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_requests/" +
      "#{parseInt mergerequestId}/notes",
      (data) -> fn data if fn

  getNote: (projectId, mergerequestId, noteId, fn = null) =>
    @debug "Projects::getMergeRequestNote()"
    @get "projects/#{Utils.parseProjectId projectId}/merge_requests/" +
        "#{parseInt mergerequestId}/notes/#{parseInt noteId}",
      (data) -> fn data if fn

module.exports = (client) -> new ProjectMergeRequests client
