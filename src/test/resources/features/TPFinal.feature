@All
Feature: Clockify TP Final

  Background:

    And header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MWNmNmY0YTktZjdkZS00YzBiLWIyN2ItYzFiOTAwODllYzMx

  @ListWorkspace
  Scenario: Get all my workspaces
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define workspaceId = $.[1].id

  @ListProject
  Scenario: Get all projects on workspace
    Given call TPFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id
    * define userId = $.[0].memberships.[0].userId

  @ListTimeEntries
  Scenario: Get time entries for a user on workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@ListProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200

  @AddProjectHours
  Scenario: Add time entry to a project
    Given call TPFinal.feature@ListWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And body addtimeentry.json
    When execute method POST
    Then the status code should be 201
    * define timeEntryId = $.id

  @UpdateTimeEntry
  Scenario: Update time entry on workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@AddProjectHours
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    And body update_time_entry.json
    When execute method PUT
    Then the status code should be 200

  @DeleteTimeEntry
  Scenario: Delete time entry from workspace
    Given call TPFinal.feature@ListWorkspace
    And call TPFinal.feature@AddProjectHours
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    When execute method DELETE
    Then the status code should be 204